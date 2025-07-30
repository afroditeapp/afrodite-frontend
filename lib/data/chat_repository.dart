import 'dart:async';

import 'package:app/data/chat/message_manager/utils.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/chat/message_database_iterator.dart';
import 'package:app/data/chat/message_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/general/notification/state/like_received.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile/account_id_database_iterator.dart';
import 'package:app/data/profile/profile_downloader.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:database/database.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';

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
    required ClientIdManager clientIdManager,
    required ServerConnectionManager connectionManager,
    required this.currentUser,
  }) :
    syncHandler = ConnectedActionScheduler(connectionManager),
    profileEntryDownloader = ProfileEntryDownloader(media, accountBackgroundDb, db, connectionManager.api),
    sentBlocksIterator = AccountIdDatabaseIterator((startIndex, limit) => db.accountData((db) => db.daoConversationList.getSentBlocksList(startIndex, limit)).ok()),
    api = connectionManager.api,
    messageManager = MessageManager(
      messageKeyManager,
      clientIdManager,
      connectionManager.api,
      db,
      profile,
      accountBackgroundDb,
      currentUser
    );

  final ConnectedActionScheduler syncHandler;

  final ProfileEntryDownloader profileEntryDownloader;
  final AccountIdDatabaseIterator sentBlocksIterator;
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
    await db.accountAction((db) => db.daoLimits.resetSyncVersion());
    await db.accountAction((db) => db.daoInitialSync.updateChatSyncDone(false));
  }

  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return await _sentBlocksRefresh()
      .andThen((_) => _generateMessageKeyIfNeeded())
      .andThen((_) => _reloadChatNotificationSettings())
      .andThen((_) => reloadDailyLikesLimit())
      .andThen((_) => db.accountAction((db) => db.daoInitialSync.updateChatSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final currentChatSyncValue = await db.accountStreamSingle((db) => db.daoInitialSync.watchChatSyncDone()).ok() ?? false;
      if (currentChatSyncValue) {
        // Already done
        return;
      }
      await _sentBlocksRefresh()
        .andThen((_) => _generateMessageKeyIfNeeded())
        .andThen((_) => _reloadChatNotificationSettings())
        .andThen((_) => reloadDailyLikesLimit())
        .andThen((_) => db.accountAction((db) => db.daoInitialSync.updateChatSyncDone(true)));
    });
  }

  Future<Result<void, void>> _generateMessageKeyIfNeeded() async {
    final keys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (keys == null) {
      return const Err(null);
    }
    final serverPublicKeyInfo =
      await api.chat((api) => api.getPrivatePublicKeyInfo(currentUser.aid)).ok();
    if (serverPublicKeyInfo == null) {
      return const Err(null);
    }

    if (serverPublicKeyInfo.latestPublicKeyId != keys.id) {
      final uploadAndSaveResult = await messageKeyManager.uploadPublicKeyAndSaveAllKeys(GeneratedMessageKeys(
        public: keys.public.data,
        private: keys.private.data,
      ));
      if (uploadAndSaveResult.isErr()) {
        return const Err(null);
      }
    }

    return const Ok(null);
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInMatches(accountId)).ok() ?? false;
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInSentLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInReceivedLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await db.accountData((db) => db.daoConversationList.isInSentBlocks(accountId)).ok() ?? false;
  }

  Future<void> _updateAccountInteractionState(
    AccountId accountId,
    CurrentAccountInteractionState state,
  ) async {
    final sentLike = state == CurrentAccountInteractionState.likeSent;
    final receivedLike = state == CurrentAccountInteractionState.likeReceived;
    final match = state == CurrentAccountInteractionState.match;
    await db.accountAction((db) => db.daoProfileStates.setSentLikeStatus(accountId, sentLike));
    await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatus(accountId, receivedLike));
    await db.accountAction((db) => db.daoProfileStates.setMatchStatus(accountId, match));
  }

  Future<Result<LimitedActionStatus, SendLikeError>> sendLikeTo(AccountId accountId) async {
    final result = await api.chat((api) => api.postSendLike(accountId));
    switch (result) {
      case Ok(:final v):
        final newState = v.errorAccountInteractionStateMismatch;
        if (newState != null) {
          await _updateAccountInteractionState(accountId, newState);
          if (newState == CurrentAccountInteractionState.likeSent) {
            return const Err(SendLikeError.alreadyLiked);
          } else if (newState == CurrentAccountInteractionState.match) {
            return const Err(SendLikeError.alreadyMatch);
          } else {
            return const Err(SendLikeError.unspecifiedError);
          }
        }
        final status = v.status;
        if (status == null) {
          return const Err(SendLikeError.unspecifiedError);
        }
        if (status != LimitedActionStatus.failureLimitAlreadyReached) {
          final dailyLikesLeft = v.dailyLikesLeft;
          if (dailyLikesLeft != null) {
            await db.accountAction((db) => db.daoLimits.updateDailyLikesLeft(dailyLikesLeft));
          }
          final isReceivedLike = await isInReceivedLikes(accountId);
          if (isReceivedLike) {
            await db.accountAction((db) => db.daoProfileStates.setMatchStatus(accountId, true));
          } else {
            await db.accountAction((db) => db.daoProfileStates.setSentLikeStatus(accountId, true));
          }
        }
        return Ok(status);
      case Err():
        return const Err(SendLikeError.unspecifiedError);
    }
  }

  Future<bool> sendBlockTo(AccountId accountId) async {
    final result = await api.chatAction((api) => api.postBlockProfile(accountId));
    if (result.isOk()) {
      await db.accountAction((db) => db.daoConversationList.setSentBlockStatus(accountId, true));
      await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatus(accountId, false));
      profile.sendProfileChange(ProfileBlocked(accountId));
    }
    return result.isOk();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final result = await api.chatAction((api) => api.postUnblockProfile(accountId));
    if (result.isOk()) {
      await db.accountAction((db) => db.daoConversationList.setSentBlockStatus(accountId, false));
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

  Future<Result<void, void>> _sentBlocksRefresh() {
    return api.chat((api) => api.getSentBlocks())
      .andThen((value) => db.accountAction((db) => db.daoConversationList.setSentBlockStatusList(value)));
  }

  Future<void> receivedLikesCountRefresh() async {
    final currentCount = await accountBackgroundDb.accountStream((db) => db.newReceivedLikesCount.watchReceivedLikesCount()).firstOrNull;
    final currentCountInt = currentCount?.c ?? 0;

    final r = await api.chat((api) => api.postGetNewReceivedLikesCount()).ok();
    final v = r?.v;
    final c = r?.c;
    if (v == null || c == null) {
      return;
    }
    await accountBackgroundDb.accountAction((db) => db.newReceivedLikesCount.updateSyncVersionReceivedLikes(v, c));

    if (currentCountInt == 0 && c.c > 0) {
      await NotificationLikeReceived.getInstance().incrementReceivedLikesCount(accountBackgroundDb);
    }
  }

  // Local messages
  Stream<MessageEntry?> watchLatestMessage(AccountId match) {
    return db.accountStream((db) => db.daoMessageTable.watchLatestMessage(currentUser, match));
  }

  /// Get message and updates to it.
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId) {
    return db.accountStream((db) => db.daoMessageTable.getMessageUpdatesUsingLocalMessageId(localId));
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

  Future<Result<void, void>> _reloadChatNotificationSettings() async {
    return await api.chat((api) => api.getChatAppNotificationSettings())
      .andThen((v) => accountBackgroundDb.accountAction(
        (db) => db.appNotificationSettings.updateChatNotificationSettings(v),
      ));
  }

  Future<Result<void, void>> reloadDailyLikesLimit() async {
    return await api.chat((api) => api.getDailyLikesLeft())
      .andThen((v) => db.accountAction(
        (db) => db.daoLimits.updateDailyLikesLeft(v),
      ));
  }

  // Message manager API

  Future<void> receiveNewMessages() async {
    final cmd = ReceiveNewMessages();
    messageManager.queueCmd(cmd);
    await cmd.waitUntilReady();
  }

  Stream<MessageSendingEvent> sendMessageTo(AccountId accountId, Message message) async* {
    final cmd = SendMessage(accountId, message);
    messageManager.queueCmd(cmd);
    yield* cmd.events();
  }

  Future<Result<void, DeleteSendFailedError>> deleteSendFailedMessage(LocalMessageId localId) async {
    final cmd = DeleteSendFailedMessage(localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitUntilReady();
  }

  Future<Result<void, ResendFailedError>> resendSendFailedMessage(LocalMessageId localId) async {
    final cmd = ResendSendFailedMessage(localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitUntilReady();
  }

  Future<Result<void, RetryPublicKeyDownloadError>> retryPublicKeyDownload(LocalMessageId localId) async {
    final cmd = RetryPublicKeyDownload(localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitUntilReady();
  }
}

enum SendLikeError {
  alreadyLiked,
  alreadyMatch,
  unspecifiedError,
}
