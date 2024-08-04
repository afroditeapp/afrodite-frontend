import 'dart:async';

import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:native_utils/message.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/message_converter.dart';
import 'package:pihka_frontend/data/chat/message_database_iterator.dart';
import 'package:pihka_frontend/data/chat/message_key_generator.dart';
import 'package:pihka_frontend/data/general/notification/state/like_received.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile/account_id_database_iterator.dart';
import 'package:pihka_frontend/data/profile/profile_list/online_iterator.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("ChatRepository");

class ChatRepository extends DataRepository {
  ChatRepository._private();
  static final _instance = ChatRepository._private();
  factory ChatRepository.getInstance() {
    return _instance;
  }

  final syncHandler = ConnectedActionScheduler();
  final messageKeyManager = MessageKeyManager();

  final db = DatabaseManager.getInstance();

  final ApiManager _api = ApiManager.getInstance();
  final profileEntryDownloader = ProfileEntryDownloader();
  final AccountIdDatabaseIterator sentBlocksIterator =
    AccountIdDatabaseIterator((startIndex, limit) => DatabaseManager.getInstance().profileData((db) => db.getSentBlocksList(startIndex, limit)).ok());
  final AccountIdDatabaseIterator receivedLikesIterator =
    AccountIdDatabaseIterator((startIndex, limit) => DatabaseManager.getInstance().profileData((db) => db.getReceivedLikesList(startIndex, limit)).ok());
  final AccountIdDatabaseIterator matchesIterator =
    AccountIdDatabaseIterator((startIndex, limit) => DatabaseManager.getInstance().profileData((db) => db.getMatchesList(startIndex, limit)).ok());

  @override
  Future<void> init() async {
    // empty
  }

  @override
  Future<void> onLogin() async {
    sentBlocksIterator.reset();
    receivedLikesIterator.reset();
    matchesIterator.reset();
    await db.accountAction((db) => db.daoInitialSync.updateChatSyncDone(false));

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

    final currentAccount = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentAccount == null) {
      return;
    }
    final keys = await messageKeyManager.generateOrLoadMessageKeys(currentAccount).ok();
    if (keys == null) {
      return;
    }
    final currentPublicKeyOnServer =
      await _api.chat((api) => api.getPublicKey(currentAccount.accountId, 1)).ok();
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

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.profileData((db) => db.isInMatches(accountId)).ok() ?? false;
  }

  Future<bool> isInLikedProfiles(AccountId accountId) async {
    return await db.profileData((db) => db.isInSentLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInReceivedLikes(AccountId accountId) async {
    return await db.profileData((db) => db.isInReceivedLikes(accountId)).ok() ?? false;
  }

  Future<bool> isInSentBlocks(AccountId accountId) async {
    return await db.profileData((db) => db.isInSentBlocks(accountId)).ok() ?? false;
  }

  Future<bool> isInReceivedBlocks(AccountId accountId) async {
    return await db.profileData((db) => db.isInReceivedBlocks(accountId)).ok() ?? false;
  }

  Future<Result<LimitedActionStatus, void>> sendLikeTo(AccountId accountId) async {
    final result = await _api.chat((api) => api.postSendLike(accountId));
    switch (result) {
      case Ok(:final v):
        if (v.status != LimitedActionStatus.failureLimitAlreadyReached) {
          final isReceivedLike = await isInReceivedLikes(accountId);
          if (isReceivedLike) {
            await db.profileAction((db) => db.setMatchStatus(accountId, true));
          } else {
            await db.profileAction((db) => db.setSentLikeStatus(accountId, true));
          }
        }
        return Ok(v.status);
      case Err():
        return const Err(null);
    }
  }

  Future<Result<LimitedActionStatus, void>> removeLikeFrom(AccountId accountId) async {
    final result = await _api.chat((api) => api.deleteLike(accountId));
    switch (result) {
      case Ok(:final v):
        if (v.status != LimitedActionStatus.failureLimitAlreadyReached) {
           await db.profileAction((db) => db.setSentLikeStatus(accountId, false));
        }
        return Ok(v.status);
      case Err():
        return const Err(null);
    }
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
    final receivedBlocks = await _api.chat((api) => api.getReceivedBlocks()).ok();
    if (receivedBlocks != null) {
      final currentReceivedBlocks = await db.profileData((db) => db.getReceivedBlocksListAll()).ok() ?? [];
      await db.profileAction((db) => db.setReceivedBlockStatusList(receivedBlocks));

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

  Future<void> sentBlocksRefresh() async {
    final sentBlocks = await _api.chat((api) => api.getSentBlocks()).ok();
    if (sentBlocks != null) {
      await db.profileAction((db) => db.setSentBlockStatusList(sentBlocks));
    }
  }

  Future<void> sentLikesRefresh() async {
    final sentLikes = await _api.chat((api) => api.getSentLikes()).ok();
    if (sentLikes != null) {
      await db.profileAction((db) => db.setSentLikeStatusList(sentLikes));
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
    final currentReceivedLikes = await db.profileData((db) => db.getReceivedLikesList(0, 1000000000)).ok() ?? [];

    final receivedLikes = await _api.chat((api) => api.getReceivedLikes()).ok();
    if (receivedLikes != null) {
      await db.profileAction((db) => db.setReceivedLikeStatusList(receivedLikes));
      ProfileRepository.getInstance().sendProfileChange(LikesChanged());

      final newList = receivedLikes.profiles;
      if (newList.length > currentReceivedLikes.length) {
        await NotificationLikeReceived.getInstance().incrementReceivedLikesCount();
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
    final data = await _api.chat((api) => api.getMatches()).ok();
    if (data != null) {
      await db.profileAction((db) => db.setMatchStatusList(data));
      ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
    }
  }

  // Messages

  Future<void> receiveNewMessages() async {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return;
    }
    final allKeys = await messageKeyManager.generateOrLoadMessageKeys(currentUser).ok();
    if (allKeys == null) {
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

        // TODO: Store some error state to database
        //       instead of the error text.
        final decryptedMessage = await decryptReceivedMessage(allKeys, message).ok() ?? "Message decrypting failed";

        final r = await db.messageAction((db) => db.insertPendingMessage(currentUser, message, decryptedMessage));
        if (r.isOk()) {
          toBeDeleted.add(message.id);
          ProfileRepository.getInstance().sendProfileChange(ConversationChanged(message.id.accountIdSender, ConversationChangeType.messageReceived));
          // TODO(prod): Update with correct message count once there is
          // count of not read messages in the database.
          await NotificationMessageReceived.getInstance().updateMessageReceivedCount(message.id.accountIdSender, 1);
        }
      }

      for (final sender in newMessages.messages.map((e) => e.id.accountIdSender).toSet()) {
        await BackgroundDatabaseManager.getInstance().accountAction((db) => db.daoNewMessageNotification.setNotificationShown(sender, false));
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

  Future<Result<String, void>> decryptReceivedMessage(AllKeyData allKeys, PendingMessage message) async {
    final publicKey = await getPublicKeyForForeignAccount(message.id.accountIdSender, forceDownload: false).ok();
    if (publicKey == null) {
      return const Err(null);
    }

    final (messageBytes, decryptingResult) = decryptMessage(
      publicKey.data.data,
      allKeys.private.data,
      message.message,
    );

    if (messageBytes == null) {
      // TODO: try again with downloaded public key
      log.error("TODO: try again public key downloading, error: $decryptingResult");
      return const Err(null);
    }

    return MessageConverter().bytesToText(messageBytes);
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

    final currentUserKeys = await messageKeyManager.generateOrLoadMessageKeys(currentUser).ok();
    if (currentUserKeys == null) {
      // TODO: error handling
      return;
    }
    final PublicKey receiverPublicKey;
    switch (await getPublicKeyForForeignAccount(accountId, forceDownload: false)) {
      case Ok(:final v):
        if (v == null) {
          // TODO: error handling
          return;
        } else {
          receiverPublicKey = v;
        }
      case Err(:final e):
       // TODO: error handling
       return;
    }

    final messageBytes = MessageConverter().textToBytes(message).ok();
    if (messageBytes == null) {
      // TODO: Error handling
      return;
    }

    final (encryptedMessage, encryptingResult) = encryptMessage(
      currentUserKeys.private.data,
      receiverPublicKey.data.data,
      messageBytes,
    );

    if (encryptedMessage == null) {
      log.error("Message encryption error: $encryptingResult");
      return;
    }

    final sendMessage = SendMessageToAccount(
      message: encryptedMessage,
      receiver: accountId,
      receiverPublicKeyId: receiverPublicKey.id,
      receiverPublicKeyVersion: receiverPublicKey.version,
    );
    final result = await _api.chat((api) => api.postSendMessage(sendMessage)).ok();
    if (result == null) {
      // TODO error handling
      return;
    }

    if (result.errorTooManyPendingMessages) {
      // TODO error handling
      return;
    }

    if (result.errorReceiverPublicKeyOutdated) {
      // TODO: download new key and try again
    }

    // TODO save sent status to local database
  }

  /// If PublicKey is null then PublicKey for that account does not exist.
  Future<Result<PublicKey?, void>> getPublicKeyForForeignAccount(
    AccountId accountId,
    {required bool forceDownload}
  ) async {
    if (forceDownload) {
      if (await refreshForeignPublicKey(accountId).isErr()) {
        return const Err(null);
      }
    }

    switch (await db.profileData((db) => db.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          if (await refreshForeignPublicKey(accountId).isErr()) {
            return const Err(null);
          }
          return await db.profileData((db) => db.getPublicKey(accountId));
        } else {
          return Ok(v);
        }
      case Err():
        return const Err(null);
    }
  }

  Future<Result<void, void>> refreshForeignPublicKey(AccountId accountId) async {
    return await _api.chat((api) => api.getPublicKey(accountId.accountId, 1))
      .andThen((key) => db.profileAction((db) => db.updatePublicKey(accountId, key.key)))
      .mapErr((_) => null);
  }

  /// Get message and updates to it.
  Stream<MessageEntry?> getMessageWithLocalId(AccountId match, int localId) async* {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      yield null;
      return;
    }
    final messageList = await db.messageData((db) => db.getMessageListByLocalMessageId(currentUser, match, localId, 1)).ok() ?? [];
    final message = messageList.firstOrNull;
    if (message == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.messageData((db) => db.getMessageListByLocalMessageId(currentUser, match, localId, 1)).ok() ?? [];
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
    final message = await db.messageData((db) => db.getMessage(currentUser, match, index)).ok();
    final localId = message?.localId;
    if (message == null || localId == null) {
      yield null;
      return;
    }
    yield message;
    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageList = await db.messageData((db) => db.getMessageListByLocalMessageId(currentUser, match, localId, 1)).ok() ?? [];
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
    final messageNumber = await db.messageData((db) => db.countMessagesInConversation(currentUser, match)).ok();
    yield (messageNumber ?? 0, null);

    await for (final event in ProfileRepository.getInstance().profileChanges) {
      if (event is ConversationChanged && event.conversationWith == match) {
        final messageNumber = await db.messageData((db) => db.countMessagesInConversation(currentUser, match)).ok();
        yield (messageNumber ?? 0, event);
      }
    }
  }

  /// First message is the latest message.
  Future<List<MessageEntry>> getAllMessages(AccountId accountId) async {
    final messageIterator = MessageDatabaseIterator();
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return [];
    }
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
}
