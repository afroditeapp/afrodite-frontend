import 'dart:async';

import 'package:logging/logging.dart';
import 'package:native_utils_ffi/message.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/message_database_iterator.dart';
import 'package:pihka_frontend/data/chat/message_manager.dart';
import 'package:pihka_frontend/data/chat/message_key_generator.dart';
import 'package:pihka_frontend/data/general/notification/state/like_received.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile/account_id_database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("ChatRepository");

// TODO(architecture): Do login related database data reset in transaction?

class ChatRepository extends DataRepositoryWithLifecycle {
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final MessageKeyManager messageKeyManager;
  final AccountId currentUser;

  ChatRepository({
    required MediaRepository media,
    required this.profile,
    required this.accountBackgroundDb,
    required this.db,
    required this.messageKeyManager,
    required ServerConnectionManager connectionManager,
    required this.currentUser,
  }) :
    syncHandler = ConnectedActionScheduler(connectionManager),
    profileEntryDownloader = ProfileEntryDownloader(media, accountBackgroundDb, db, connectionManager.api),
    sentBlocksIterator = AccountIdDatabaseIterator((startIndex, limit) => db.accountData((db) => db.daoProfileStates.getSentBlocksList(startIndex, limit)).ok()),
    receivedLikesIterator = AccountIdDatabaseIterator((startIndex, limit) => db.accountData((db) => db.daoProfileStates.getReceivedLikesList(startIndex, limit)).ok()),
    matchesIterator = AccountIdDatabaseIterator((startIndex, limit) => db.accountData((db) => db.daoMatches.getMatchesList(startIndex, limit)).ok()),
    api = connectionManager.api,
    messageManager = MessageManager(messageKeyManager, connectionManager.api, db, profile, accountBackgroundDb, currentUser);

  final ConnectedActionScheduler syncHandler;

  final ProfileEntryDownloader profileEntryDownloader;
  final AccountIdDatabaseIterator sentBlocksIterator;
  final AccountIdDatabaseIterator receivedLikesIterator;
  final AccountIdDatabaseIterator matchesIterator;
  final ApiManager api;

  final MessageManager messageManager;

  @override
  Future<void> init() async {
    await messageManager.init();
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
    await messageManager.dispose();
  }

  @override
  Future<void> onLogin() async {
    sentBlocksIterator.reset();
    receivedLikesIterator.reset();
    matchesIterator.reset();
    await db.accountAction((db) => db.daoInitialSync.updateChatSyncDone(false));

    // Reset message sending error detection counter value as other client
    // might have used the current value in server.
    await db.accountAction((db) => db.daoConversations.resetAllSenderMessageIds());
    await db.accountAction((db) => db.daoMessages.resetSenderMessageIdForAllMessages());

    syncHandler.onLoginSync(() async {
      await _generateMessageKeyIfNeeded();
    });
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      await _generateMessageKeyIfNeeded();
    });
  }

  Future<void> _generateMessageKeyIfNeeded() async {
    final currentChatSyncValue = await db.accountStreamSingle((db) => db.daoInitialSync.watchChatSyncDone()).ok() ?? false;
    if (currentChatSyncValue) {
      // Already done
      return;
    }

    final keys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (keys == null) {
      return;
    }
    final currentPublicKeyOnServer =
      await api.chat((api) => api.getPublicKey(currentUser.accountId, 1)).ok();
    if (currentPublicKeyOnServer == null) {
      return;
    }

    if (currentPublicKeyOnServer.key?.id != keys.public.id) {
      final uploadAndSaveResult = await messageKeyManager.uploadPublicKeyAndSaveAllKeys(GeneratedMessageKeys(
        armoredPublicKey: keys.public.data.data,
        armoredPrivateKey: keys.private.data,
      ));
      if (uploadAndSaveResult.isErr()) {
        return;
      }
    }

    await db.accountAction((db) => db.daoInitialSync.updateChatSyncDone(true));
  }

  Future<bool> isInMatches(AccountId accountId) {
    return messageManager.isInMatches(accountId);
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInSentLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInReceivedLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInSentBlocks(accountId)).ok() ?? false;
  }

  Future<bool> isInReceivedBlocks(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInReceivedBlocks(accountId)).ok() ?? false;
  }

  Future<Result<LimitedActionStatus, void>> sendLikeTo(AccountId accountId) async {
    final result = await api.chat((api) => api.postSendLike(accountId));
    switch (result) {
      case Ok(:final v):
        if (v.status != LimitedActionStatus.failureLimitAlreadyReached) {
          final isReceivedLike = await isInReceivedLikes(accountId);
          if (isReceivedLike) {
            await db.accountAction((db) => db.daoMatches.setMatchStatus(accountId, true));
          } else {
            await db.accountAction((db) => db.daoProfileStates.setSentLikeStatus(accountId, true));
          }
        }
        return Ok(v.status);
      case Err():
        return const Err(null);
    }
  }

  Future<Result<LimitedActionStatus, void>> removeLikeFrom(AccountId accountId) async {
    final result = await api.chat((api) => api.deleteLike(accountId));
    switch (result) {
      case Ok(:final v):
        if (v.status != LimitedActionStatus.failureLimitAlreadyReached) {
           await db.accountAction((db) => db.daoProfileStates.setSentLikeStatus(accountId, false));
        }
        return Ok(v.status);
      case Err():
        return const Err(null);
    }
  }

  Future<bool> sendBlockTo(AccountId accountId) async {
    final result = await api.chatAction((api) => api.postBlockProfile(accountId));
    if (result.isOk()) {
      await db.accountAction((db) => db.daoProfileStates.setSentBlockStatus(accountId, true));
      await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatus(accountId, false));
      profile.sendProfileChange(ProfileBlocked(accountId));
    }
    return result.isOk();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final result = await api.chatAction((api) => api.postUnblockProfile(accountId));
    if (result.isOk()) {
      await db.accountAction((db) => db.daoProfileStates.setSentBlockStatus(accountId, false));
      profile.sendProfileChange(ProfileUnblocked(accountId));
    }
    return result.isOk();
  }

  Future<List<(AccountId, ProfileEntry?)>> _genericIteratorNext(
    AccountIdDatabaseIterator iterator,
    {
      bool cache = false,
      bool download = false,
      bool isMatch = false,
    }
  ) async {
    final accounts = await iterator.nextList();
    final newList = <(AccountId, ProfileEntry?)>[];
    for (final accountId in accounts) {
      ProfileEntry? profileData;
      if (cache) {
        profileData = await db.profileData((db) => db.getProfileEntry(accountId)).ok();
      }
      if (download) {
        profileData ??= await profileEntryDownloader.download(accountId, isMatch: isMatch).ok();
      }
      newList.add((accountId, profileData));
    }
    return newList;
  }

  /// Returns AccountId for all blocked profiles. ProfileEntry is returned only
  /// if the blocked profile is public.
  Future<List<(AccountId, ProfileEntry?)>> sentBlocksIteratorNext() =>
    _genericIteratorNext(sentBlocksIterator, download: true);

  void sentBlocksIteratorReset() {
    sentBlocksIterator.reset();
  }

  Future<void> receivedBlocksRefresh() async {
    final receivedBlocks = await api.chat((api) => api.getReceivedBlocks()).ok();
    if (receivedBlocks != null) {
      final currentReceivedBlocks = await db.accountData((db) => db.daoProfileStates.getReceivedBlocksListAll()).ok() ?? [];
      await db.accountAction((db) => db.daoProfileStates.setReceivedBlockStatusList(receivedBlocks));

      for (final account in receivedBlocks.profiles) {
        if (!currentReceivedBlocks.contains(account)) {
          await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatus(account, false));
          await db.accountAction((db) => db.daoMatches.setMatchStatus(account, false));
          await db.accountAction((db) => db.daoProfileStates.setSentLikeStatus(account, false));
          // Perhaps if both users blocks same time, the same account could be
          // in both sent and received blocks. This handles that case.
          await db.accountAction((db) => db.daoProfileStates.setSentBlockStatus(account, false));
          profile.sendProfileChange(ProfileBlocked(account));
        }
      }
    }
  }

  Future<void> sentBlocksRefresh() async {
    final sentBlocks = await api.chat((api) => api.getSentBlocks()).ok();
    if (sentBlocks != null) {
      await db.accountAction((db) => db.daoProfileStates.setSentBlockStatusList(sentBlocks));
    }
  }

  Future<void> sentLikesRefresh() async {
    final sentLikes = await api.chat((api) => api.getSentLikes()).ok();
    if (sentLikes != null) {
      await db.accountAction((db) => db.daoProfileStates.setSentLikeStatusList(sentLikes));
    }
  }

  Future<List<ProfileEntry>> _genericIteratorNextOnlySuccessful(
    AccountIdDatabaseIterator iterator,
    {
      bool cache = false,
      bool download = false,
      bool isMatch = false,
    }
  ) async {
    var profiles = <ProfileEntry>[];
    while (true) {
      final list = await _genericIteratorNext(iterator, cache: cache, download: download, isMatch: isMatch);
      if (list.isEmpty) {
        return profiles;
      }
      profiles = list.map((e) => e.$2).nonNulls.toList();
      if (profiles.isEmpty) {
        continue;
      } else {
        return profiles;
      }
    }
  }

  /// ProfileEntry is returned if a profile of the like sender
  /// is cached or the profile is public.
  ///
  /// Private profiles are not returned (except the cached ones).
  Future<List<ProfileEntry>> receivedLikesIteratorNext() =>
    _genericIteratorNextOnlySuccessful(receivedLikesIterator, cache: true, download: true);

  void receivedLikesIteratorReset() =>
    receivedLikesIterator.reset();

  Future<void> receivedLikesRefresh() async {
    // TODO(prod): Add event to API which has info that there is new like
    // available.
    final currentReceivedLikes = await db.accountData((db) => db.daoProfileStates.getReceivedLikesList(0, 1000000000)).ok() ?? [];

    final receivedLikes = await api.chat((api) => api.getReceivedLikes()).ok();
    if (receivedLikes != null) {
      await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatusList(receivedLikes));
      profile.sendProfileChange(LikesChanged());

      final newList = receivedLikes.profiles;
      if (newList.length > currentReceivedLikes.length) {
        await NotificationLikeReceived.getInstance().incrementReceivedLikesCount(accountBackgroundDb);
      }
    }
  }

  /// Iterate ProfileEntries of current matches.
  ///
  /// Matches can see the profiles of each other even if one/both are
  /// set as private.
  Future<List<ProfileEntry>> matchesIteratorNext() =>
    _genericIteratorNextOnlySuccessful(matchesIterator, cache: true, download: true, isMatch: true);

  void matchesIteratorReset() =>
    matchesIterator.reset();

  Future<void> receivedMatchesRefresh() async {
    final data = await api.chat((api) => api.getMatches()).ok();
    if (data != null) {
      await db.accountAction((db) => db.daoMatches.setMatchStatusList(data));
      profile.sendProfileChange(MatchesChanged());
    }
  }

  // Local messages
  Stream<MessageEntry?> watchLatestMessage(AccountId match) {
    return db.accountStream((db) => db.daoMessages.watchLatestMessage(currentUser, match));
  }

  /// Get message and updates to it.
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId) {
    return db.accountStream((db) => db.daoMessages.getMessageUpdatesUsingLocalMessageId(localId));
  }

  /// Get message and updates to it.
  /// Index 0 is the latest message.
  Stream<MessageEntry?> getMessageWithIndex(AccountId match, int index) async* {
    final message = await db.messageData((db) => db.getMessage(currentUser, match, index)).ok();
    final localId = message?.localId;
    if (message == null || localId == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in profile.profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.messageData((db) => db.getMessageListUsingLocalMessageId(currentUser, match, localId, 1)).ok() ?? [];
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
    final messageNumber = await db.messageData((db) => db.countMessagesInConversation(currentUser, match)).ok();
    yield (messageNumber ?? 0, null);

    await for (final event in profile.profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageNumber = await db.messageData((db) => db.countMessagesInConversation(currentUser, match)).ok();
        yield (messageNumber ?? 0, event);
      }
    }
  }

  /// First message is the latest message.
  Future<List<MessageEntry>> getAllMessages(AccountId accountId) async {
    final messageIterator = MessageDatabaseIterator(db);
    await messageIterator.switchConversation(currentUser, accountId);

    List<MessageEntry> allMessages = [];
    while (true) {
      final messages = await messageIterator.nextList();
      if (messages.isEmpty) {
        break;
      }
      allMessages.addAll(messages);
    }
    return allMessages;
  }

  // Message manager API

  Future<void> receiveNewMessages() async {
    final cmd = ReceiveNewMessages();
    messageManager.queueCmd(cmd);
    await cmd.waitUntilReady();
  }

  Stream<MessageSendingEvent> sendMessageTo(AccountId accountId, String message) async* {
    final cmd = SendMessage(accountId, message);
    messageManager.queueCmd(cmd);
    yield* cmd.events();
  }

  Future<Result<void, DeleteSendFailedError>> deleteSendFailedMessage(AccountId receiverAccountId, LocalMessageId localId) async {
    final cmd = DeleteSendFailedMessage(receiverAccountId, localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitUntilReady();
  }

  Future<Result<void, DeleteSendFailedError>> resendSendFailedMessage(AccountId receiverAccountId, LocalMessageId localId) async {
    final cmd = ResendSendFailedMessage(receiverAccountId, localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitUntilReady();
  }
}
