import 'dart:async';

import 'package:async/async.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/message_database_iterator.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/account_id_database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("ChatRepository");

class ChatRepository extends DataRepository {
  ChatRepository._private();
  static final _instance = ChatRepository._private();
  factory ChatRepository.getInstance() {
    return _instance;
  }
  final db = DatabaseManager.getInstance();

  final ApiManager _api = ApiManager.getInstance();
  final profileEntryDownloader = ProfileEntryDownloader();
  final AccountIdDatabaseIterator sentBlocksIterator =
    AccountIdDatabaseIterator((startIndex, limit) => DatabaseManager.getInstance().profileData((db) => db.getSentBlocksList(startIndex, limit)));
  final AccountIdDatabaseIterator receivedLikesIterator =
    AccountIdDatabaseIterator((startIndex, limit) => DatabaseManager.getInstance().profileData((db) => db.getReceivedLikesList(startIndex, limit)));
  final AccountIdDatabaseIterator matchesIterator =
    AccountIdDatabaseIterator((startIndex, limit) => DatabaseManager.getInstance().profileData((db) => db.getMatchesList(startIndex, limit)));
  final MessageDatabaseIterator messageIterator = MessageDatabaseIterator();


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
    // await SentBlocksDatabase.getInstance().clearAccountIds();
    // await SentLikesDatabase.getInstance().clearAccountIds();
    // await ReceivedBlocksDatabase.getInstance().clearAccountIds();
    // await ReceivedLikesDatabase.getInstance().clearAccountIds();
    // await MatchesDatabase.getInstance().clearAccountIds();

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
    await db.profileAction((db) => db.setSentBlockStatusList(sentBlocks?.profiles, true));

    // Download received likes.
    await receivedLikesRefresh();

    // Download sent likes.
    final sentLikes = await _api.chat((api) => api.getSentLikes()).ok();
    await db.profileAction((db) => db.setSentLikeStatusList(sentLikes?.profiles, true));

    // Download current matches.
    await receivedMatchesRefresh();

    // Download pending messages and remove those from server.
    await receiveNewMessages();
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.profileData((db) => db.isInMatches(accountId)) ?? false;
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await db.profileData((db) => db.isInSentLikes(accountId)) ?? false;
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await db.profileData((db) => db.isInReceivedLikes(accountId)) ?? false;
  }

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await db.profileData((db) => db.isInSentBlocks(accountId)) ?? false;
  }

  Future<bool> isInReceivedBlocks(AccountId accountId) async {
    return await db.profileData((db) => db.isInReceivedBlocks(accountId)) ?? false;
  }

  Future<bool> sendLikeTo(AccountId accountId) async {
    final result = await _api.chatAction((api) => api.postSendLike(accountId));
    if (result.isOk()) {
      final isReceivedLike = await isInReceivedLikes(accountId);
      if (isReceivedLike) {
        await db.profileAction((db) => db.setMatchStatus(accountId, true));
      } else {
        await db.profileAction((db) => db.setSentLikeStatus(accountId, true));
      }
    }
    return result.isOk();
  }

  Future<bool> removeLikeFrom(AccountId accountId) async {
    final result = await _api.chatAction((api) => api.deleteLike(accountId));
    if (result.isOk()) {
      await db.profileAction((db) => db.setSentLikeStatus(accountId, false));
    }
    return result.isOk();
  }

  Future<bool> sendBlockTo(AccountId accountId) async {
    final result = await _api.chatAction((api) => api.postBlockProfile(accountId));
    if (result.isOk()) {
      await db.profileAction((db) => db.setSentBlockStatus(accountId, true));
      await db.profileAction((db) => db.setReceivedLikeStatus(accountId, false));
      ProfileRepository.getInstance().sendProfileChange(ProfileBlocked(accountId));
    }
    return result.isOk();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final result = await _api.chatAction((api) => api.postUnblockProfile(accountId));
    if (result.isOk()) {
      await db.profileAction((db) => db.setSentBlockStatus(accountId, false));
      ProfileRepository.getInstance().sendProfileChange(ProfileUnblocked(accountId));
    }
    return result.isOk();
  }

  /// Returns AccountId for all blocked profiles. ProfileEntry is returned only
  /// if the blocked profile is public.
  Future<List<(AccountId, ProfileEntry?)>> sentBlocksIteratorNext() async {
    final accounts = await sentBlocksIterator.nextList();
    final newList = List<(AccountId, ProfileEntry?)>.empty(growable: true);
    for (final accountId in accounts) {
      final profileData = await profileEntryDownloader.download(accountId).ok();
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
      final currentReceivedBlocks = await db.profileData((db) => db.getReceivedBlocksListAll()) ?? [];
      await db.profileAction((db) => db.setReceivedBlockStatusList(receivedBlocks.profiles, true, clear: true));

      for (final account in receivedBlocks.profiles) {
        if (!currentReceivedBlocks.contains(account)) {
          await db.profileAction((db) => db.setReceivedLikeStatus(account, false));
          await db.profileAction((db) => db.setMatchStatus(account, false));
          await db.profileAction((db) => db.setSentLikeStatus(account, false));
          // Perhaps if both users blocks same time, the same account could be
          // in both sent and received blocks. This handles that case.
          await db.profileAction((db) => db.setSentBlockStatus(account, false));
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
        await db.profileData((db) => db.getProfileEntry(accountId)) ??
        await profileEntryDownloader.download(accountId).ok();
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
      await db.profileAction((db) => db.setReceivedLikeStatusList(receivedLikes.profiles, true, clear: true));
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
        await db.profileData((db) => db.getProfileEntry(accountId)) ??
        await profileEntryDownloader.download(accountId, isMatch: true).ok();
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
      await db.profileAction((db) => db.setMatchStatusList(data.profiles, true, clear: true));
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

      for (final message in newMessages.messages) {
        final isMatch = await isInMatches(message.id.accountIdSender);
        if (!isMatch) {
          await db.profileAction((db) => db.setMatchStatus(message.id.accountIdSender, true));
          ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
        }

        final r = await db.messageAction((db) => db.insertPendingMessage(currentUser, message));
        if (r.isOk()) {
          toBeDeleted.add(message.id);
          ProfileRepository.getInstance().sendProfileChange(ConversationChanged(message.id.accountIdSender, ConversationChangeType.messageReceived));
        }
      }

      final toBeDeletedList = PendingMessageDeleteList(messagesIds: toBeDeleted);
      final result = await _api.chatAction((api) => api.deletePendingMessages(toBeDeletedList));
      if (result.isOk()) {
        for (final message in newMessages.messages) {
          await db.messageAction((db) => db.updateReceivedMessageState(
            currentUser,
            message.id.accountIdSender,
            message.id.messageNumber,
            ReceivedMessageState.deletedFromServer,
          ));
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
      final resultSendLike = await _api.chatAction((api) => api.postSendLike(accountId));
      if (resultSendLike.isOk()) {
        await db.profileAction((db) => db.setMatchStatus(accountId, true));
        ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
        await db.profileAction((db) => db.setReceivedLikeStatus(accountId, false));
        ProfileRepository.getInstance().sendProfileChange(LikesChanged());
      } else {
        // Notify about error
        return;
      }
    }

    final saveMessageResult = await db.messageAction((db) => db.insertToBeSentMessage(
      currentUser,
      accountId,
      message,
    ));
    if (saveMessageResult.isErr()) {
      return;
    }

    ProfileRepository.getInstance().sendProfileChange(ConversationChanged(accountId, ConversationChangeType.messageSent));

    final sendMessage = SendMessageToAccount(message: message, receiver: accountId);
    final result = await _api.chatAction((api) => api.postSendMessage(sendMessage));
    if (result.isErr()) {
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
    final messageList = await db.messageData((db) => db.getMessageListByLocalMessageId(currentUser, match, localId, 1)) ?? [];
    final message = messageList.firstOrNull;
    if (message == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.messageData((db) => db.getMessageListByLocalMessageId(currentUser, match, localId, 1)) ?? [];
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
    final message = await db.messageData((db) => db.getMessage(currentUser, match, index));
    final localId = message?.localId;
    if (message == null || localId == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.messageData((db) => db.getMessageListByLocalMessageId(currentUser, match, localId, 1)) ?? [];
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
    final messageNumber = await db.messageData((db) => db.countMessagesInConversation(currentUser, match));
    yield (messageNumber ?? 0, null);

    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageNumber = await db.messageData((db) => db.countMessagesInConversation(currentUser, match));
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
