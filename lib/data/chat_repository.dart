import 'dart:async';

import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/check_online_status_manager.dart';
import 'package:app/data/chat/message_manager/utils.dart';
import 'package:app/data/chat/typing_indicator_manager.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/app_error.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
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
import 'package:utils/utils.dart';

class ChatRepository extends DataRepositoryWithLifecycle {
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final MessageKeyManager messageKeyManager;
  final AccountId currentUser;

  ChatRepository({
    required AccountRepository account,
    required MediaRepository media,
    required this.profile,
    required this.accountBackgroundDb,
    required this.db,
    required this.messageKeyManager,
    required ServerConnectionManager connectionManager,
    required this.currentUser,
  }) : syncHandler = ConnectedActionScheduler(connectionManager),
       profileEntryDownloader = ProfileEntryDownloader(
         media,
         accountBackgroundDb,
         db,
         connectionManager,
       ),
       sentBlocksIterator = AccountIdDatabaseIterator(
         (startIndex, limit) =>
             db.accountData((db) => db.conversationList.getSentBlocksList(startIndex, limit)).ok(),
       ),
       api = connectionManager,
       messageManager = MessageManager(
         messageKeyManager,
         connectionManager,
         db,
         profile,
         accountBackgroundDb,
         currentUser,
       ),
       typingIndicatorManager = TypingIndicatorManager(connectionManager, account),
       checkOnlineStatusManager = CheckOnlineStatusManager(connectionManager, account, db);

  final ConnectedActionScheduler syncHandler;

  final ProfileEntryDownloader profileEntryDownloader;
  final AccountIdDatabaseIterator sentBlocksIterator;
  final ApiManager api;

  final MessageManager messageManager;
  final TypingIndicatorManager typingIndicatorManager;
  final CheckOnlineStatusManager checkOnlineStatusManager;

  @override
  Future<void> init() async {
    await messageManager.init();
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
    await messageManager.dispose();
    await typingIndicatorManager.dispose();
    await checkOnlineStatusManager.dispose();
  }

  @override
  Future<void> onLogin() async {
    sentBlocksIterator.reset();
    await db.accountAction((db) => db.like.resetDailyLikesSyncVersion());
    await db.accountAction((db) => db.app.updateChatSyncDone(false));
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await _sentBlocksRefresh()
        .andThen((_) => _generateMessageKeyIfNeeded())
        .andThen((_) => _reloadChatNotificationSettings())
        .andThen((_) => reloadChatPrivacySettings())
        .andThen((_) => reloadDailyLikesLimit())
        .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateChatSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final currentChatSyncValue =
          await db.accountStreamSingle((db) => db.app.watchChatSyncDone()).ok() ?? false;
      if (currentChatSyncValue) {
        // Already done
        return;
      }
      await _sentBlocksRefresh()
          .andThen((_) => _generateMessageKeyIfNeeded())
          .andThen((_) => _reloadChatNotificationSettings())
          .andThen((_) => reloadChatPrivacySettings())
          .andThen((_) => reloadDailyLikesLimit())
          .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateChatSyncDone(true)));
    });
  }

  Future<Result<(), ()>> _generateMessageKeyIfNeeded() async {
    final keys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (keys == null) {
      return const Err(());
    }
    final serverPublicKeyInfo = await api
        .chat((api) => api.getPrivatePublicKeyInfo(currentUser.aid))
        .ok();
    if (serverPublicKeyInfo == null) {
      return const Err(());
    }

    if (serverPublicKeyInfo.latestPublicKeyId != keys.id) {
      final uploadAndSaveResult = await messageKeyManager.uploadPublicKeyAndSaveAllKeys(
        GeneratedMessageKeys(public: keys.public.data, private: keys.private.data),
      );
      if (uploadAndSaveResult.isErr()) {
        return const Err(());
      }
    }

    return const Ok(());
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.profile.isInMatches(accountId)).ok() ?? false;
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await db.accountData((db) => db.profile.isInSentLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await db.accountData((db) => db.profile.isInReceivedLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await db.accountData((db) => db.conversationList.isInSentBlocks(accountId)).ok() ??
        false;
  }

  Stream<bool> isInMatchesStream(AccountId accountId) {
    return db.accountStreamOrDefault((db) => db.profile.isInMatchesStream(accountId), false);
  }

  Future<void> _updateAccountInteractionState(
    AccountId accountId,
    CurrentAccountInteractionState state,
  ) async {
    final sentLike = state == CurrentAccountInteractionState.likeSent;
    final receivedLike = state == CurrentAccountInteractionState.likeReceived;
    final match = state == CurrentAccountInteractionState.match;
    await db.accountAction((db) => db.profile.setSentLikeStatus(accountId, sentLike));
    await db.accountAction((db) => db.profile.setReceivedLikeStatus(accountId, receivedLike));
    await db.accountAction((db) => db.profile.setMatchStatus(accountId, match));
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
            await db.accountAction((db) => db.like.updateDailyLikesLeft(dailyLikesLeft));
          }
          final isReceivedLike = await isInReceivedLikes(accountId);
          if (isReceivedLike) {
            await db.accountAction((db) => db.profile.setMatchStatus(accountId, true));
          } else {
            await db.accountAction((db) => db.profile.setSentLikeStatus(accountId, true));
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
      await db.accountAction((db) => db.conversationList.setSentBlockStatus(accountId, true));
      await db.accountAction((db) => db.profile.setReceivedLikeStatus(accountId, false));
      profile.sendProfileChange(ProfileBlocked(accountId));
    }
    return result.isOk();
  }

  Future<bool> removeBlockFrom(AccountId accountId) async {
    final result = await api.chatAction((api) => api.postUnblockProfile(accountId));
    if (result.isOk()) {
      await db.accountAction((db) => db.conversationList.setSentBlockStatus(accountId, false));
      profile.sendProfileChange(ProfileUnblocked(accountId));
    }
    return result.isOk();
  }

  Future<List<(AccountId, ProfileEntry?)>> _genericIteratorNext(
    AccountIdDatabaseIterator iterator, {
    bool cache = false,
    bool download = false,
    bool isMatch = false,
  }) async {
    final accounts = await iterator.nextList();
    final newList = <(AccountId, ProfileEntry?)>[];
    for (final accountId in accounts) {
      ProfileEntry? profileData;
      if (cache) {
        profileData = await db.accountData((db) => db.profile.getProfileEntry(accountId)).ok();
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

  Future<Result<(), ()>> _sentBlocksRefresh() {
    return api
        .chat((api) => api.getSentBlocks())
        .andThenEmptyErr(
          (value) => db.accountAction((db) => db.conversationList.setSentBlockStatusList(value)),
        );
  }

  Future<void> receivedLikesCountRefresh() async {
    final r = await api.chat((api) => api.postGetNewReceivedLikesCount()).ok();
    if (r == null) {
      return;
    }
    await NotificationLikeReceived.getInstance().handleNewReceivedLikesCount(
      r,
      accountBackgroundDb,
      onlyDbUpdate: r.h,
    );
  }

  Future<void> receiveMessageDeliveryInfo() async {
    final deliveryInfoList = await api.chat((api) => api.getMessageDeliveryInfo()).ok();
    if (deliveryInfoList == null) {
      return;
    }

    final List<int> processedIds = [];

    for (final deliveryInfo in deliveryInfoList.info) {
      final message = await db
          .accountData(
            (db) =>
                db.message.getMessageUsingMessageId(deliveryInfo.receiver, deliveryInfo.messageId),
          )
          .ok();

      if (message == null) {
        // Message not found in DB
        processedIds.add(deliveryInfo.id);
        continue;
      }

      final currentState = message.messageState.toSentState();
      if (currentState == null) {
        // Not a sent message
        processedIds.add(deliveryInfo.id);
        continue;
      }

      SentMessageState? newState;
      UtcDateTime? deliveredTime;
      UtcDateTime? seenTime;

      if (deliveryInfo.deliveryType == DeliveryInfoType.delivered) {
        if (currentState != SentMessageState.seen) {
          newState = SentMessageState.delivered;
          deliveredTime = deliveryInfo.unixTime.toUtcDateTime();
        }
      } else if (deliveryInfo.deliveryType == DeliveryInfoType.seen) {
        newState = SentMessageState.seen;
        seenTime = deliveryInfo.unixTime.toUtcDateTime();
      }

      if (newState != null) {
        final result = await db.accountAction(
          (db) => db.message.updateSentMessageState(
            message.localId,
            sentState: newState,
            deliveredUnixTime: deliveredTime,
            seenUnixTime: seenTime,
          ),
        );

        if (result.isOk()) {
          // Only mark as processed if successfully saved to DB
          processedIds.add(deliveryInfo.id);
        }
      } else {
        // If no state change needed, still mark as processed
        processedIds.add(deliveryInfo.id);
      }
    }

    if (processedIds.isNotEmpty) {
      await api.chatAction(
        (api) => api.postDeleteMessageDeliveryInfo(MessageDeliveryInfoIdList(ids: processedIds)),
      );
    }
  }

  // Local messages
  Stream<MessageEntry?> watchLatestMessage(AccountId match) {
    return db.accountStream((db) => db.message.watchLatestMessage(match));
  }

  /// Get message and updates to it.
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId) {
    return db.accountStream((db) => db.message.getMessageUpdatesUsingLocalMessageId(localId));
  }

  /// Get message and updates to it.
  /// Index 0 is the latest message.
  Stream<MessageEntry?> getMessageWithIndex(AccountId match, int index) async* {
    final message = await db.accountData((db) => db.message.getMessage(match, index)).ok();
    final localId = message?.localId;
    if (message == null || localId == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in profile.profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList =
            await db
                .accountData(
                  (db) => db.message.getMessageListUsingLocalMessageId(match, localId, 1),
                )
                .ok() ??
            [];
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
    final messageNumber = await db
        .accountData((db) => db.message.countMessagesInConversation(match))
        .ok();
    yield (messageNumber ?? 0, null);

    await for (final event in profile.profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageNumber = await db
            .accountData((db) => db.message.countMessagesInConversation(match))
            .ok();
        yield (messageNumber ?? 0, event);
      }
    }
  }

  /// First message is the latest message.
  Future<Result<List<MessageEntry>, ()>> getAllMessages(AccountId accountId) async {
    return await db.accountData((db) => db.message.getAllMessages(accountId)).emptyErr();
  }

  Future<Result<(), ()>> _reloadChatNotificationSettings() async {
    return await api
        .chat((api) => api.getChatAppNotificationSettings())
        .andThenEmptyErr(
          (v) => accountBackgroundDb.accountAction(
            (db) => db.appNotificationSettings.updateChatNotificationSettings(v),
          ),
        );
  }

  Future<Result<(), ()>> reloadChatPrivacySettings() async {
    final settings = await api.chat((api) => api.getChatPrivacySettings()).ok();
    if (settings == null) {
      return const Err(());
    }
    return await db
        .accountAction((db) => db.privacy.updateChatPrivacySettings(settings))
        .emptyErr();
  }

  Future<Result<(), ()>> reloadDailyLikesLimit() async {
    return await api
        .chat((api) => api.getDailyLikesLeft())
        .andThenEmptyErr((v) => db.accountAction((db) => db.like.updateDailyLikesLeft(v)));
  }

  // Message manager API

  Future<void> receiveNewMessages() async {
    final cmd = ReceiveNewMessages();
    messageManager.queueCmd(cmd);
    await cmd.waitCompletionAndDispose();
  }

  Stream<MessageSendingEvent> sendMessageTo(AccountId accountId, Message message) async* {
    final cmd = SendMessage(accountId, message);
    messageManager.queueCmd(cmd);
    yield* cmd.events();
  }

  Future<Result<(), DeleteSendFailedError>> deleteSendFailedMessage(LocalMessageId localId) async {
    final cmd = DeleteSendFailedMessage(localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<(), ResendFailedError>> resendSendFailedMessage(LocalMessageId localId) async {
    final cmd = ResendSendFailedMessage(localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<(), RetryPublicKeyDownloadError>> retryPublicKeyDownload(
    LocalMessageId localId,
  ) async {
    final cmd = RetryPublicKeyDownload(localId);
    messageManager.queueCmd(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<ChatBackupData, DatabaseError>> createChatBackup() async {
    final cmd = CreateChatBackupCmd();
    messageManager.queueCmd(cmd);
    return await cmd.waitCompletionAndDispose();
  }

  Future<Result<(), DatabaseError>> importChatBackup(ChatBackupData backupData) async {
    final cmd = ImportChatBackupCmd(backupData);
    messageManager.queueCmd(cmd);
    return await cmd.waitCompletionAndDispose();
  }
}

enum SendLikeError { alreadyLiked, alreadyMatch, unspecifiedError }
