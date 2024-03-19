import 'dart:async';

import 'package:async/async.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/chat/message_database_iterator.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/account_id_database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/chat/matches_database.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/database/chat/received_blocks_database.dart';
import 'package:pihka_frontend/database/chat/received_likes_database.dart';
import 'package:pihka_frontend/database/chat/sent_blocks_database.dart';
import 'package:pihka_frontend/database/chat/sent_likes_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("ChatRepository");

class ChatRepository extends DataRepository {
  ChatRepository._private();
  static final _instance = ChatRepository._private();
  factory ChatRepository.getInstance() {
    return _instance;
  }

  final ApiManager _api = ApiManager.getInstance();
  final profileEntryDownloader = ProfileEntryDownloader();
  final AccountIdDatabaseIterator sentBlocksIterator =
    AccountIdDatabaseIterator(SentBlocksDatabase.getInstance());
  final AccountIdDatabaseIterator receivedLikesIterator =
    AccountIdDatabaseIterator(ReceivedLikesDatabase.getInstance());
  final AccountIdDatabaseIterator matchesIterator =
    AccountIdDatabaseIterator(MatchesDatabase.getInstance());
  final MessageDatabaseIterator messageIterator =
    MessageDatabaseIterator(MessageDatabase.getInstance());

  @override
  Future<void> init() async {
    // empty
  }

  @override
  Future<void> onLogin() async {
    sentBlocksIterator.reset();
    receivedLikesIterator.reset();
    matchesIterator.reset();
    messageIterator.resetToInitialState();

    _api.state
      .firstWhere((element) => element == ApiManagerState.connected)
      .then((value) async {
        await _syncData();
      })
      .ignore();
  }

  @override
  Future<void> onLogout() async {
    await SentBlocksDatabase.getInstance().clearAccountIds();
    await SentLikesDatabase.getInstance().clearAccountIds();
    await ReceivedBlocksDatabase.getInstance().clearAccountIds();
    await ReceivedLikesDatabase.getInstance().clearAccountIds();
    await MatchesDatabase.getInstance().clearAccountIds();
    // NOTE: MessageDatabase is not cleared.
  }

  @override
  Future<void> onResumeAppUsage() async {
    _api.state
      .firstWhere((element) =>
        element == ApiManagerState.connected ||
        element == ApiManagerState.waitingRefreshToken
      )
      .then((value) async {
        if (value == ApiManagerState.connected) {
          await _syncData();
        }
      })
      .ignore();
  }

  Future<void> _syncData() async {
    // TODO: Perhps client should track these operations and retry
    // these if needed.

    // Download received blocks.
    await receivedBlocksRefresh();

    // Download sent blocks.
    final sentBlocks = await _api.chat((api) => api.getSentBlocks()).ok();
    await SentBlocksDatabase.getInstance().insertAccountIdList(sentBlocks?.profiles);

    // Download received likes.
    await receivedLikesRefresh();

    // Download sent likes.
    final sentLikes = await _api.chat((api) => api.getSentLikes()).ok();
    await SentLikesDatabase.getInstance().insertAccountIdList(sentLikes?.profiles);

    // Download current matches.
    await receivedMatchesRefresh();

    // Download pending messages and remove those from server.
    await receiveNewMessages();
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await MatchesDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await SentLikesDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await ReceivedLikesDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await SentBlocksDatabase.getInstance().exists(accountId);
  }

  Future<bool> isInReceivedBlocks(AccountId accountId) async {
    return await ReceivedBlocksDatabase.getInstance().exists(accountId);
  }

  Future<bool> sendLikeTo(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postSendLike(accountId));
    if (result.isSuccess()) {
      final isReceivedLike = await ReceivedLikesDatabase.getInstance().exists(accountId);
      if (isReceivedLike) {
        await MatchesDatabase.getInstance().insertAccountId(accountId);
      } else {
        await SentLikesDatabase.getInstance().insertAccountId(accountId);
      }
    }
    return result.isSuccess();
  }

  Future<bool> removeLikeFrom(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.deleteLike(accountId));
    if (result.isSuccess()) {
      await SentLikesDatabase.getInstance().removeAccountId(accountId);
    }
    return result.isSuccess();
  }

  Future<bool> sendBlockTo(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postBlockProfile(accountId));
    if (result.isSuccess()) {
      await SentBlocksDatabase.getInstance().insertAccountId(accountId);
      await ReceivedLikesDatabase.getInstance().removeAccountId(accountId);
      ProfileRepository.getInstance().sendProfileChange(ProfileBlocked(accountId));
    }
    return result.isSuccess();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postUnblockProfile(accountId));
    if (result.isSuccess()) {
      await SentBlocksDatabase.getInstance().removeAccountId(accountId);
      ProfileRepository.getInstance().sendProfileChange(ProfileUnblocked(accountId));
    }
    return result.isSuccess();
  }

  /// Returns AccountId for all blocked profiles. ProfileEntry is returned only
  /// if the blocked profile is public.
  Future<List<(AccountId, ProfileEntry?)>> sentBlocksIteratorNext() async {
    final accounts = await sentBlocksIterator.nextList();
    final newList = List<(AccountId, ProfileEntry?)>.empty(growable: true);
    for (final accountId in accounts) {
      final profileData = await profileEntryDownloader.download(accountId);
      newList.add((accountId, profileData));
    }
    return newList;
  }

  void sentBlocksIteratorReset() {
    sentBlocksIterator.reset();
  }

  Future<void> receivedBlocksRefresh() async {
    final receivedBlocks = await _api.chat((api) => api.getReceivedBlocks()).ok();
    if (receivedBlocks != null) {
      final db = ReceivedBlocksDatabase.getInstance();

      final currentReceivedBlocks = await db.getAccountIdList(0, null) ?? [];
      await db.clearAccountIds();
      await db.insertAccountIdList(receivedBlocks.profiles);

      for (final account in receivedBlocks.profiles) {
        if (!currentReceivedBlocks.contains(account)) {
          await ReceivedLikesDatabase.getInstance().removeAccountId(account);
          await MatchesDatabase.getInstance().removeAccountId(account);
          await SentLikesDatabase.getInstance().removeAccountId(account);
          // Perhaps if both users blocks same time, the same account could be
          // in both sent and received blocks. This handles that case.
          await SentBlocksDatabase.getInstance().removeAccountId(account);
          ProfileRepository.getInstance().sendProfileChange(ProfileBlocked(account));
        }
      }
    }
  }

  /// ProfileEntry is returned if a profile of the like sender
  /// is cached or the profile is public.
  ///
  /// Private profiles are not returned (except the cached ones).
  Future<List<ProfileEntry>> receivedLikesIteratorNext() async {
    final accounts = await receivedLikesIterator.nextList();
    final newList = <ProfileEntry>[];
    for (final accountId in accounts) {
      final profileData =
        await ProfileDatabase.getInstance().getProfileEntry(accountId) ??
        await profileEntryDownloader.download(accountId);
      if (profileData != null) {
        newList.add(profileData);
      }
    }
    return newList;
  }

  void receivedLikesIteratorReset() {
    receivedLikesIterator.reset();
  }

  Future<void> receivedLikesRefresh() async {
    final receivedLikes = await _api.chat((api) => api.getReceivedLikes()).ok();
    if (receivedLikes != null) {
      final db = ReceivedLikesDatabase.getInstance();
      await db.clearAccountIds();
      await db.insertAccountIdList(receivedLikes.profiles);
      ProfileRepository.getInstance().sendProfileChange(LikesChanged());
    }
  }

  /// Iterate ProfileEntries of current matches.
  ///
  /// Matches can see the profiles of each other even if one/both are
  /// set as private.
  Future<List<ProfileEntry>> matchesIteratorNext() async {
    final accounts = await matchesIterator.nextList();
    final newList = <ProfileEntry>[];
    for (final accountId in accounts) {
      final profileData =
        await ProfileDatabase.getInstance().getProfileEntry(accountId) ??
        await profileEntryDownloader.download(accountId, isMatch: true);
      if (profileData != null) {
        newList.add(profileData);
      }
    }
    return newList;
  }

  void matchesIteratorReset() {
    matchesIterator.reset();
  }

  Future<void> receivedMatchesRefresh() async {
    final data = await _api.chat((api) => api.getMatches()).ok();
    if (data != null) {
      final db = MatchesDatabase.getInstance();
      await db.clearAccountIds();
      await db.insertAccountIdList(data.profiles);
      ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
    }
  }

  // Messages

  Future<void> receiveNewMessages() async {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return;
    }
    final newMessages = await _api.chat((api) => api.getPendingMessages()).ok();
    if (newMessages != null) {
      final toBeDeleted = <PendingMessageId>[];
      final db = MessageDatabase.getInstance();
      for (final message in newMessages.messages) {
        final isMatch = await isInMatches(message.id.accountIdSender);
        if (!isMatch) {
          await MatchesDatabase.getInstance().insertAccountId(message.id.accountIdSender);
          ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
        }

        if (await db.insertPendingMessage(currentUser, message)) {
          toBeDeleted.add(message.id);
          ProfileRepository.getInstance().sendProfileChange(ConversationChanged(message.id.accountIdSender, ConversationChangeType.messageReceived));
        }
      }

      final toBeDeletedList = PendingMessageDeleteList(messagesIds: toBeDeleted);
      final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.deletePendingMessages(toBeDeletedList));
      if (result.isSuccess()) {
        for (final message in newMessages.messages) {
          await db.updateReceivedMessageState(
            currentUser,
            message.id.accountIdSender,
            message.id.messageNumber,
            ReceivedMessageState.deletedFromServer,
          );
        }
      }
      // TODO: If request fails try again at some point.
    }
  }

  // TODO error handling
  // Use stream instead?
  // If saving to local database fails, don't clear the chat box UI.
  Future<void> sendMessageTo(AccountId accountId, String message) async {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return;
    }

    final isMatch = await isInMatches(accountId);
    if (!isMatch) {
      final (resultSendLike, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postSendLike(accountId));
      if (resultSendLike.isSuccess()) {
        await MatchesDatabase.getInstance().insertAccountId(accountId);
        ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
        await ReceivedLikesDatabase.getInstance().removeAccountId(accountId);
        ProfileRepository.getInstance().sendProfileChange(LikesChanged());
      } else {
        // Notify about error
        return;
      }
    }

    final saveMessageResult = await MessageDatabase.getInstance().insertToBeSentMessage(
      currentUser,
      accountId,
      message,
    );
    if (!saveMessageResult) {
      return;
    }

    ProfileRepository.getInstance().sendProfileChange(ConversationChanged(accountId, ConversationChangeType.messageSent));

    final sendMessage = SendMessageToAccount(message: message, receiver: accountId);
    final (result, _) = await _api.chatWrapper().requestWithHttpStatus((api) => api.postSendMessage(sendMessage));
    if (!result.isSuccess()) {
      // TODO error handling
    }

    // TODO save sent status to local database
  }

  /// Get message and updates to it.
  Stream<MessageEntry?> getMessageWithLocalId(AccountId match, int localId) async* {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      yield null;
      return;
    }
    final db = MessageDatabase.getInstance();
    final messageList = await db.getMessageListByLocalMessageId(currentUser, match, localId, 1);
    final message = messageList.firstOrNull;
    if (message == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.getMessageListByLocalMessageId(currentUser, match, localId, 1);
        final message = messageList.firstOrNull;
        if (message != null) {
          yield message;
        }
      }
    }
  }

  /// Get message and updates to it.
  /// Index 0 is the latest message.
  Stream<MessageEntry?> getMessageWithIndex(AccountId match, int index) async* {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      yield null;
      return;
    }
    final db = MessageDatabase.getInstance();
    final message = await db.getMessage(currentUser, match, index);
    final localId = message?.localId;
    if (message == null || localId == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.getMessageListByLocalMessageId(currentUser, match, localId, 1);
        final message = messageList.firstOrNull;
        if (message != null) {
          yield message;
        }
      }
    }
  }

  /// Get message count of conversation and possibly the related change event.
  /// Also receive updates to both.
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match) async* {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      yield (0, null);
      return;
    }
    final db = MessageDatabase.getInstance();
    final messageNumber = await db.countMessagesInConversation(currentUser, match);
    yield (messageNumber ?? 0, null);

    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageNumber = await db.countMessagesInConversation(currentUser, match);
        yield (messageNumber ?? 0, event);
      }
    }
  }

  Future<void> messageIteratorReset(AccountId match) async {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return;
    }
    await messageIterator.switchConversation(currentUser, match);
  }

  // Get max 10 next messages.
  Future<List<MessageEntry>> messageIteratorNext() async {
    return await messageIterator.nextList();
  }

  Future<List<MessageEntry>> getAllMessages(AccountId accountId) async {
    await ChatRepository.getInstance().messageIteratorReset(accountId);

    List<MessageEntry> allMessages = [];
    while (true) {
      final messages = await ChatRepository.getInstance().messageIteratorNext();
      if (messages.isEmpty) {
        break;
      }
      allMessages.addAll(messages);
    }
    return allMessages;
  }
}
