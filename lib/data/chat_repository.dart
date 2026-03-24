import 'dart:async';
import 'dart:typed_data';

import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/check_online_status_manager.dart';
import 'package:app/data/chat/message_manager/utils.dart';
import 'package:app/data/chat/typing_indicator_manager.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/utils/app_error.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/data/profile/account_id_database_iterator.dart';
import 'package:app/data/profile/profile_downloader.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:database/database.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';

class ChatRepository extends DataRepositoryWithLifecycle {
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final MessageKeyManager messageKeyManager;
  final AccountId currentUser;

  ChatRepository({
    required AccountRepository account,
    required MediaRepository media,
    required this.profile,
    required this.db,
    required this.messageKeyManager,
    required ServerConnectionManager connectionManager,
    required this.currentUser,
  }) : profileEntryDownloader = ProfileEntryDownloader(media, db, connectionManager),
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
         currentUser,
       ),
       typingIndicatorManager = TypingIndicatorManager(connectionManager, account),
       checkOnlineStatusManager = CheckOnlineStatusManager(connectionManager, account, db);

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
    await messageManager.dispose();
    await typingIndicatorManager.dispose();
    await checkOnlineStatusManager.dispose();
  }

  @override
  Future<void> onLogin() async {
    sentBlocksIterator.reset();
    await db.accountAction((db) => db.like.resetDailyLikesSyncVersion());
    await db.accountAction((db) => db.key.updatePublicKeyIdOnServer(null));
    await db.accountAction((db) => db.app.updateChatSyncDone(false));
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await _sentBlocksRefresh()
        .andThen((_) => _downloadPublicKeyIdFromServerAndGenerateInitialKeysIfNeeded())
        .andThen((_) => _reloadChatNotificationSettings())
        .andThen((_) => reloadChatPrivacySettings())
        .andThen((_) => reloadDailyLikesLimit())
        .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateChatSyncDone(true)));
  }

  Future<Result<(), ()>> _downloadPublicKeyIdFromServerAndGenerateInitialKeysIfNeeded() async {
    final serverPublicKeyInfo = await api
        .chat((api) => api.getPrivatePublicKeyInfo(currentUser.aid))
        .ok();
    if (serverPublicKeyInfo == null) {
      return Err(());
    }

    final r = await db.accountAction(
      (db) => db.key.updatePublicKeyIdOnServer(serverPublicKeyInfo.latestPublicKeyId),
    );
    if (r.isErr()) {
      return Err(());
    }

    if (serverPublicKeyInfo.latestPublicKeyId == null) {
      // Generate initial keypair
      return await messageKeyManager.generateNewKeypairAndUploadPublicKey().emptyErr();
    } else {
      return Ok(());
    }
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
    final result = await api.chat((api) => api.postSendLike(SendLike(accountId: accountId)));
    switch (result) {
      case Ok(:final v):
        final newState = v.errorAccountInteractionStateMismatch;
        if (newState != null) {
          await _updateAccountInteractionState(accountId, newState);
          if (newState == CurrentAccountInteractionState.likeSent) {
            return const Err(SendLikeError.alreadyLiked);
          } else if (newState == CurrentAccountInteractionState.likeReceived) {
            return const Err(SendLikeError.alreadyLikeReceived);
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

  Future<Result<(), ()>> receivedLikesCountRefresh() async {
    final r = await api.chat((api) => api.postGetNewReceivedLikesCount()).ok();
    if (r == null) {
      return const Err(());
    }
    await db.accountAction((db) => db.common.updateSyncVersionReceivedLikes(r));
    return const Ok(());
  }

  Future<void> receiveMessageDeliveryInfo() async {
    final cmd = ReceiveMessageDeliveryInfo();
    messageManager.queueCmd(cmd);
    await cmd.waitCompletionAndDispose();
  }

  Future<void> receiveLatestSeenMessageInfo() async {
    final cmd = ReceiveLatestSeenMessageInfo();
    messageManager.queueCmd(cmd);
    await cmd.waitCompletionAndDispose();
  }

  // Local messages
  Stream<MessageEntry?> watchLatestMessage(AccountId match) {
    return db.accountStream((db) => db.message.watchLatestMessage(match));
  }

  /// Get message and updates to it.
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId) {
    return db.accountStream((db) => db.message.getMessageUpdatesUsingLocalMessageId(localId));
  }

  /// Get message count of conversation
  Stream<int> getMessageCount(AccountId match) {
    return db.accountStreamOrDefault((db) => db.message.watchCountMessagesInConversation(match), 0);
  }

  /// First message is the latest message.
  Future<Result<List<MessageEntry>, ()>> getAllMessages(AccountId accountId) async {
    return await db.accountData((db) => db.message.getAllMessages(accountId)).emptyErr();
  }

  Future<Result<(), ()>> _reloadChatNotificationSettings() async {
    return await api
        .chat((api) => api.getChatAppNotificationSettings())
        .andThenEmptyErr(
          (v) => db.accountAction(
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

  Future<Result<(), ()>> handlePendingChatNotificationsChangedEvent() async {
    final pending = await api.chat((api) => api.getPendingChatNotifications()).ok();
    if (pending == null) {
      return const Err(());
    }

    if (pending.notifications.isEmpty) {
      return const Ok(());
    }

    for (final notification in pending.notifications) {
      await _handlePendingChatNotification(notification);
    }

    final handled = PendingChatNotificationList(notifications: pending.notifications);

    return await api
        .chatAction((api) => api.postDeletePendingChatNotifications(handled))
        .emptyErr();
  }

  Future<void> _handlePendingChatNotification(PendingChatNotification notification) async {
    final accountId = notification.accountIdSender;
    final messageCount = notification.messageCount;

    await db.accountAction(
      (db) => db.chatUnreadMessagesCount.setUnreadMessagesCount(
        accountId,
        UnreadMessagesCount(messageCount),
      ),
    );

    ConversationId? conversationId = await db
        .accountData((db) => db.chatUnreadMessagesCount.getConversationId(accountId))
        .ok();
    if (conversationId == null) {
      final result = await api.chat((api) => api.getConversationId(accountId.aid)).ok();
      conversationId = result?.value;
    }

    if (notification.pushNotificationSent) {
      return;
    }

    if (conversationId == null) {
      if (messageCount > 0) {
        await NotificationMessageReceived.getInstance().showFallbackMessageReceivedNotification(db);
      }
      return;
    }

    await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
      accountId,
      messageCount,
      conversationId,
      db,
    );
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

  Future<Result<(), ResendDeliveryFailedError>> resendDeliveryFailedMessage(
    LocalMessageId localId,
  ) async {
    final cmd = ResendDeliveryFailedMessage(localId);
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

  Future<Result<(), ImportChatBackupError>> importChatBackup(Uint8List bytes) async {
    final cmd = ImportChatBackupCmd(bytes);
    messageManager.queueCmd(cmd);
    return await cmd.waitCompletionAndDispose();
  }
}

enum SendLikeError { alreadyLiked, alreadyLikeReceived, alreadyMatch, unspecifiedError }
