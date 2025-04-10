

import 'dart:async';
import 'dart:convert';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/chat/message_converter.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/api.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/iterator.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("MessageManager");

sealed class MessageManagerCommand {}
class ReceiveNewMessages extends MessageManagerCommand {
  final BehaviorSubject<bool> _completed = BehaviorSubject.seeded(false);

  Future<void> waitUntilReady() async  {
    await _completed.where((v) { return v; }).first;
    return;
  }
}
class SendMessage extends MessageManagerCommand {
  final ReplaySubject<MessageSendingEvent?> _events = ReplaySubject();
  final AccountId receiverAccount;
  final String message;
  SendMessage(this.receiverAccount, this.message);

  Stream<MessageSendingEvent> events() async* {
    await for (final event in _events) {
      if (event == null) {
        return;
      }
      yield event;
    }
  }
}
class DeleteSendFailedMessage extends MessageManagerCommand {
  final BehaviorSubject<Result<void, DeleteSendFailedError>?> _completed = BehaviorSubject.seeded(null);
  final AccountId receiverAccount;
  final LocalMessageId localId;
  DeleteSendFailedMessage(this.receiverAccount, this.localId);

  Future<Result<void, DeleteSendFailedError>> waitUntilReady() async  {
    return await _completed.whereNotNull().first;
  }
}
class ResendSendFailedMessage extends MessageManagerCommand {
  final BehaviorSubject<Result<void, ResendFailedError>?> _completed = BehaviorSubject.seeded(null);
  final AccountId receiverAccount;
  final LocalMessageId localId;
  ResendSendFailedMessage(this.receiverAccount, this.localId);

  Future<Result<void, ResendFailedError>> waitUntilReady() async  {
    return await _completed.whereNotNull().first;
  }
}
class RetryPublicKeyDownload extends MessageManagerCommand {
  final BehaviorSubject<Result<void, RetryPublicKeyDownloadError>?> _completed = BehaviorSubject.seeded(null);
  final AccountId receiverAccount;
  final LocalMessageId localId;
  RetryPublicKeyDownload(this.receiverAccount, this.localId);

  Future<Result<void, RetryPublicKeyDownloadError>> waitUntilReady() async  {
    return await _completed.whereNotNull().first;
  }
}

// TODO(prod): Enable message sender verification from Rust code

/// Synchronized message actions
class MessageManager extends LifecycleMethods {
  final MessageKeyManager messageKeyManager;
  final ClientIdManager clientIdManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;

  MessageManager(this.messageKeyManager, this.clientIdManager, this.api, this.db, this.profile, this.accountBackgroundDb, this.currentUser);

  final PublishSubject<MessageManagerCommand> _commands = PublishSubject();
  StreamSubscription<void>? _commandsSubscription;

  bool allSentMessagesAcknoledgedOnce = false;

  @override
  Future<void> init() async {
    _commandsSubscription = _commands
      .asyncMap((cmd) async {
        switch (cmd) {
          case ReceiveNewMessages(:final _completed):
            await _receiveNewMessages();
            _completed.add(true);
          case SendMessage(:final _events, :final receiverAccount, :final message):
            await for (final event in _sendMessageTo(receiverAccount, message)) {
              _events.add(event);
            }
            _events.add(null);
          case DeleteSendFailedMessage(:final _completed, :final receiverAccount, :final localId):
            _completed.add(await _deleteSendFailedMessage(receiverAccount, localId));
          case ResendSendFailedMessage(:final _completed, :final receiverAccount, :final localId):
            _completed.add(await _resendSendFailedMessage(receiverAccount, localId));
          case RetryPublicKeyDownload(:final _completed, :final receiverAccount, :final localId):
            _completed.add(await _retryPublicKeyDownload(receiverAccount, localId));
        }
      })
      .listen((_) {});
  }

  @override
  Future<void> dispose() async {
    await _commandsSubscription?.cancel();
  }

  void queueCmd(MessageManagerCommand cmd) {
    _commands.add(cmd);
  }

  Future<void> _receiveNewMessages() async {
    if (kIsWeb) {
      // Messages are not supported on web
      return;
    }

    final allKeys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (allKeys == null) {
      return;
    }
    final newMessageBytes = await api.chat((api) => api.getPendingMessagesFixed()).ok();
    if (newMessageBytes == null) {
      return;
    }

    final newMessages = _parsePendingMessagesResponse(newMessageBytes);
    if (newMessages == null) {
      return;
    }

    final toBeDeleted = <PendingMessageId>[];

    for (final (message, messageBytes) in newMessages) {
      final isMatch = await isInMatches(message.id.sender);
      if (!isMatch) {
        await db.accountAction((db) => db.daoProfileStates.setMatchStatus(message.id.sender, true));
      }

      if (!await isInConversationList(message.id.sender)) {
        await db.accountAction((db) => db.daoConversationList.setConversationListVisibility(message.id.sender, true));
      }

      final alreadyExistingMessageResult = await db.accountData((db) => db.daoMessages.getMessageUsingMessageNumber(
        currentUser,
        message.id.sender,
        message.id.mn
      ));
      switch (alreadyExistingMessageResult) {
        case Err():
          return;
        case Ok(v: final alreadyExistingMessage):
          if (alreadyExistingMessage != null) {
            toBeDeleted.add(message.id);
            continue;
          }
      }

      final String decryptedMessage;
      final ReceivedMessageState messageState;
      switch (await _decryptReceivedMessage(allKeys, message.id.sender, messageBytes)) {
        case Err(:final e):
          decryptedMessage = base64Encode(messageBytes);
          switch (e) {
            case ReceivedMessageError.decryptingFailed:
              messageState = ReceivedMessageState.decryptingFailed;
            case ReceivedMessageError.unknownMessageType:
              messageState = ReceivedMessageState.unknownMessageType;
            case ReceivedMessageError.publicKeyDonwloadingFailed:
              messageState = ReceivedMessageState.publicKeyDownloadFailed;
          }
        case Ok(:final v):
          decryptedMessage = v;
          messageState = ReceivedMessageState.received;
      }

      final r = await db.messageAction((db) => db.insertReceivedMessage(
        currentUser,
        message,
        decryptedMessage,
        messageState,
      ));
      if (r.isOk()) {
        toBeDeleted.add(message.id);
      }
      final unreadMessagesCount = await accountBackgroundDb.accountData((db) => db.daoConversationsBackground.incrementUnreadMessagesCount(message.id.sender)).ok();
      if (unreadMessagesCount != null) {
        profile.sendProfileChange(ConversationChanged(message.id.sender, ConversationChangeType.messageReceived));
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(message.id.sender, unreadMessagesCount.count, accountBackgroundDb);
      }
    }

    for (final sender in newMessages.map((item) => item.$1.id.sender).toSet()) {
      await accountBackgroundDb.accountAction((db) => db.daoNewMessageNotification.setNotificationShown(sender, false));
    }

    final toBeAcknowledgedList = PendingMessageAcknowledgementList(ids: toBeDeleted);
    final result = await api.chatAction((api) => api.postAddReceiverAcknowledgement(toBeAcknowledgedList));
    if (result.isErr()) {
      log.error("Receive messages: acknowleding the server failed");
    }
  }

  List<(PendingMessage, Uint8List)>? _parsePendingMessagesResponse(Uint8List bytes) {
    final bytesIterator = bytes.iterator;
    final List<(PendingMessage, Uint8List)> parsedData = [];
    while (true) {
      final jsonLen1 = bytesIterator.next();
      final jsonLen2 = bytesIterator.next();
      if (jsonLen1 == null) {
        return parsedData;
      }
      if (jsonLen2 == null) {
        return null;
      }
      final jsonLength = ByteData.sublistView(Uint8List.fromList([jsonLen1, jsonLen2]))
        .getUint16(0, Endian.little);
      final List<int> utf8Text = [];
      for (var i = 0; i < jsonLength; i++) {
        final byteValue = bytesIterator.next();
        if (byteValue == null) {
          return null;
        }
        utf8Text.add(byteValue);
      }
      final PendingMessage pendingMessage;
      try {
        final text = utf8.decode(utf8Text);
        final pendingMessageOrNull = PendingMessage.fromJson(jsonDecode(text));
        if (pendingMessageOrNull == null) {
          return null;
        }
        pendingMessage = pendingMessageOrNull;
      } catch (_)  {
        return null;
      }
      final dataLen1 = bytesIterator.next();
      final dataLen2 = bytesIterator.next();
      if (dataLen1 == null || dataLen2 == null) {
        return null;
      }
      final dataLength = ByteData.sublistView(Uint8List.fromList([dataLen1, dataLen2]))
        .getUint16(0, Endian.little);
      final List<int> data = [];
      for (var i = 0; i < dataLength; i++) {
        final byteValue = bytesIterator.next();
        if (byteValue == null) {
          return null;
        }
        data.add(byteValue);
      }
      final dataList = Uint8List.fromList(data);

      parsedData.add((pendingMessage, dataList));
    }
  }

  Future<Result<String, ReceivedMessageError>> _decryptReceivedMessage(AllKeyData allKeys, AccountId messageSender, Uint8List messageBytesFromServer) async {
    // 0 is PGP message
    if (messageBytesFromServer.isEmpty || messageBytesFromServer.first != 0) {
      return const Err(ReceivedMessageError.unknownMessageType);
    }
    final encryptedMessageBytes = Uint8List.fromList(messageBytesFromServer.skip(1).toList());

    bool forcePublicKeyDownload = false;
    while (true) {
      var publicKey = await _getPublicKeyForForeignAccount(messageSender, forceDownload: forcePublicKeyDownload).ok();
      if (publicKey == null) {
        return const Err(ReceivedMessageError.publicKeyDonwloadingFailed);
      }

      final (messageBytes, decryptingResult) = decryptMessage(
        publicKey.data,
        allKeys.private.data,
        encryptedMessageBytes,
      );

      if (messageBytes == null) {
        log.error("Received message decrypting failed, error: $decryptingResult, forcePublicKeyDownload: $forcePublicKeyDownload");
      }

      if (messageBytes == null && forcePublicKeyDownload) {
        return const Err(ReceivedMessageError.decryptingFailed);
      } else if (messageBytes == null) {
        forcePublicKeyDownload = true;
        continue;
      }

      return MessageConverter().bytesToText(messageBytes).mapErr((_) => ReceivedMessageError.unknownMessageType);
    }
  }

  Stream<MessageSendingEvent> _sendMessageTo(
    AccountId accountId,
    String message,
    {
      bool sendUiEvent = true,
    }
  ) async* {
    if (kIsWeb) {
      // Messages are not supported on web
      yield const ErrorBeforeMessageSaving();
    }

    await for (final e in _sendMessageToInternal(accountId, message, sendUiEvent: sendUiEvent)) {
      switch (e) {
        case SavedToLocalDb():
          yield e;
        case ErrorBeforeMessageSaving():
          yield e;
        case ErrorAfterMessageSaving(:final id):
          // The existing error is more important, so ignore
          // the state change result.
          await db.messageAction((db) => db.updateSentMessageState(
            id,
            sentState: SentMessageState.sendingError,
          ));
          yield e;
      }
    }
  }

  Stream<MessageSendingEvent> _sendMessageToInternal(AccountId accountId, String message, {bool sendUiEvent = true}) async* {
    final isMatch = await isInMatches(accountId);
    if (!isMatch) {
      final resultSendLike = await api.chatAction((api) => api.postSendLike(accountId));
      if (resultSendLike.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      final matchStatusChange = await db.accountAction((db) => db.daoProfileStates.setMatchStatus(accountId, true));
      if (matchStatusChange.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
    }

    if (!await isInConversationList(accountId)) {
      final r = await db.accountAction((db) => db.daoConversationList.setConversationListVisibility(accountId, true));
      if (r.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
    }

    final lastSentMessageResult = await db.accountData((db) => db.daoMessages.getLatestSentMessage(
      currentUser,
      accountId,
    ));
    switch (lastSentMessageResult) {
      case Err():
        yield const ErrorBeforeMessageSaving();
        return;
      case Ok(v: final lastSentMessage):
        // If previous sent message is still in pending state, then the app is
        // probably closed or crashed too early.
        if (lastSentMessage != null && lastSentMessage.messageState.toSentState() == SentMessageState.pending) {
          final result = await db.messageAction((db) => db.updateSentMessageState(
            lastSentMessage.localId,
            sentState: SentMessageState.sendingError,
          ));
          if (result.isErr()) {
            yield const ErrorBeforeMessageSaving();
            return;
          }
        }
    }

    final ForeignPublicKey receiverPublicKey;
    final receiverPublicKeyOrNull = await _getPublicKeyForForeignAccount(accountId, forceDownload: false).ok();
    if (receiverPublicKeyOrNull == null) {
      yield const ErrorBeforeMessageSaving();
      return;
    }
    receiverPublicKey = receiverPublicKeyOrNull;

    final saveMessageResult = await db.messageData((db) => db.insertToBeSentMessage(
      currentUser,
      accountId,
      message,
    ));
    final LocalMessageId localId;
    switch (saveMessageResult) {
      case Ok(:final v):
        yield const SavedToLocalDb();
        localId = v;
      case Err():
        yield const ErrorBeforeMessageSaving();
        return;
    }

    if (sendUiEvent) {
      profile.sendProfileChange(ConversationChanged(accountId, ConversationChangeType.messageSent));
    }

    final clientId = await clientIdManager.getClientId().ok();
    if (clientId == null) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final currentUserKeys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (currentUserKeys == null) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final messageBytes = MessageConverter().textToBytes(message).ok();
    if (messageBytes == null) {
      yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.messageTooLarge);
      return;
    }

    final (encryptedMessage, encryptingResult) = encryptMessage(
      currentUserKeys.private.data,
      receiverPublicKey.data,
      messageBytes,
    );

    if (encryptedMessage == null) {
      log.error("Message encryption error: $encryptingResult");
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final dataIdentifierAndEncryptedMessage = [0]; // 0 is PGP message
    dataIdentifierAndEncryptedMessage.addAll(encryptedMessage);

    UnixTime unixTimeFromServer;
    MessageNumber messageNumberFromServer;
    var messageSenderAcknowledgementTried = false;
    while (true) {
      final result = await api.chat((api) => api.postSendMessage(
        accountId.aid,
        receiverPublicKey.id.id,
        clientId.id,
        localId.id,
        MultipartFile.fromBytes("", dataIdentifierAndEncryptedMessage),
      )).ok();
      if (result == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      if (result.errorReceiverBlockedSenderOrReceiverNotFound) {
        yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.receiverBlockedSenderOrReceiverNotFound);
        return;
      }

      if (result.errorTooManyReceiverAcknowledgementsMissing) {
        yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.tooManyPendingMessages);
        return;
      }

      if (result.errorTooManySenderAcknowledgementsMissing) {
        if (messageSenderAcknowledgementTried) {
          yield ErrorAfterMessageSaving(localId);
          return;
        } else {
          messageSenderAcknowledgementTried = true;

          log.error("Send message error: too many sender acknowledgements missing");

          final acknowledgeResult = await _markSentMessagesAcknowledged(clientId);
          if (acknowledgeResult.isErr()) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }
          continue;
        }
      }

      if (result.errorReceiverPublicKeyOutdated) {
        log.error("Send message error: public key outdated");

        await _getPublicKeyForForeignAccount(accountId, forceDownload: true);
        // Show possible key change info to user
        if (sendUiEvent) {
          profile.sendProfileChange(ConversationChanged(accountId, ConversationChangeType.messageSent));
        }
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      final unixTimeFromResult = result.ut;
      final messageNumberFromResult = result.mn;
      if (unixTimeFromResult == null || messageNumberFromResult == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }
      unixTimeFromServer = unixTimeFromResult;
      messageNumberFromServer = messageNumberFromResult;
      break;
    }

    final updateSentState = await db.messageAction((db) => db.updateSentMessageState(
      localId,
      sentState: SentMessageState.sent,
      unixTimeFromServer: unixTimeFromServer,
      messageNumberFromServer: messageNumberFromServer,
    ));
    if (updateSentState.isErr()) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    if (!allSentMessagesAcknoledgedOnce) {
      await _markSentMessagesAcknowledged(clientId);
    } else {
      await api.chatAction((api) => api.postAddSenderAcknowledgement(
        SentMessageIdList(ids: [
          SentMessageId(c: clientId, l: ClientLocalId(id: localId.id))],
        )
      ));
    }
  }

  Future<Result<void, void>> _markSentMessagesAcknowledged(ClientId clientId) async {
    final sentMessages = await api.chat((api) => api.getSentMessageIds()).ok();
    if (sentMessages == null) {
      return const Err(null);
    }
    for (final sentMessageId in sentMessages.ids) {
      if (clientId != sentMessageId.c) {
        continue;
      }
      final sentMessageLocalId = sentMessageId.l.toLocalMessageId();
      final currentMessage = await db.messageData((db) => db.getMessageUsingLocalMessageId(
        sentMessageLocalId,
      )).ok();
      if (currentMessage?.messageState.toSentState() == SentMessageState.sendingError) {
        final updateSentState = await db.messageAction((db) => db.updateSentMessageState(
          sentMessageLocalId,
          sentState: SentMessageState.sent,
        ));
        if (updateSentState.isErr()) {
          return const Err(null);
        }
      }
    }

    final acknowledgeResult = await api.chatAction((api) => api.postAddSenderAcknowledgement(sentMessages));
    if (acknowledgeResult.isErr()) {
      return const Err(null);
    }

    allSentMessagesAcknoledgedOnce = true;
    return const Ok(null);
  }

  /// If ForeignPublicKey is null then PublicKey for that account does not exist.
  Future<Result<ForeignPublicKey?, void>> _getPublicKeyForForeignAccount(
    AccountId accountId,
    {required bool forceDownload}
  ) async {
    if (forceDownload) {
      if (await _refreshForeignPublicKey(accountId).isErr()) {
        return const Err(null);
      }
    }

    switch (await db.accountData((db) => db.daoConversations.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          if (await _refreshForeignPublicKey(accountId).isErr()) {
            return const Err(null);
          }
          return await db.accountData((db) => db.daoConversations.getPublicKey(accountId));
        } else {
          return Ok(v);
        }
      case Err():
        return const Err(null);
    }
  }

  Future<Result<void, void>> _refreshForeignPublicKey(AccountId accountId) async {
    // TODO: use public key ID from message when that is available
    final r = await api.chat((api) => api.getLatestPublicKeyId(accountId.aid));
    final PublicKeyId latestPublicKeyId;
    switch (r) {
      case Ok(:final v):
        final id = v.id;
        if (id == null) {
          return const Err(null);
        } else {
          latestPublicKeyId = id;
        }
      case Err():
        return const Err(null);
    }

    final keyResult = await api.chat((api) => api.getPublicKeyFixed(accountId.aid, latestPublicKeyId.id));
    final Uint8List latestPublicKeyData;
    switch (keyResult) {
      case Ok(:final v):
        latestPublicKeyData = v;
      case Err():
        return const Err(null);
    }

    final InfoMessageState? infoState;
    switch (await db.accountData((db) => db.daoConversations.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          infoState = InfoMessageState.infoMatchFirstPublicKeyReceived;
        } else if (v.id != latestPublicKeyId) {
          infoState = InfoMessageState.infoMatchPublicKeyChanged;
        } else {
          infoState = null;
        }
      case Err():
        return const Err(null);
    }

    return await db.accountAction((db) => db.daoConversations.updatePublicKeyAndAddInfoMessage(currentUser, accountId, latestPublicKeyData, latestPublicKeyId, infoState))
      .mapErr((_) => null);
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInMatches(accountId)).ok() ?? false;
  }

  Future<bool> isInConversationList(AccountId accountId) async {
    return await db.accountData((db) => db.daoConversationList.isInConversationList(accountId)).ok() ?? false;
  }

  Future<Result<void, DeleteSendFailedError>> _deleteSendFailedMessage(
    AccountId receiverAccount,
    LocalMessageId localId,
    {
      bool sendUiEvent = true,
      bool actuallySentMessageCheck = true,
    }
  ) async {
    if (kIsWeb) {
      // Messages are not supported on web
      return const Err(DeleteSendFailedError.unspecifiedError);
    }

    if (actuallySentMessageCheck) {
      final clientId = await clientIdManager.getClientId().ok();
      if (clientId == null) {
        return const Err(DeleteSendFailedError.unspecifiedError);
      }

      // Try to move failed messages to correct state if message sending
      // HTTP response receiving failed.
      final acknowledgeResult = await _markSentMessagesAcknowledged(clientId);
      if (acknowledgeResult.isErr()) {
        return const Err(DeleteSendFailedError.unspecifiedError);
      }
    }

    final toBeRemoved = await db.accountData((db) => db.daoMessages.getMessageUsingLocalMessageId(
      localId,
    )).ok();
    if (toBeRemoved == null) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    }
    if (toBeRemoved.messageState.toSentState() != SentMessageState.sendingError) {
      return const Err(DeleteSendFailedError.isActuallySentSuccessfully);
    }

    final deleteResult = await db.accountData((db) => db.daoMessages.deleteMessage(
      localId,
    ));
    if (deleteResult.isErr()) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    } else {
      if (sendUiEvent) {
        profile.sendProfileChange(ConversationChanged(toBeRemoved.remoteAccountId, ConversationChangeType.messageRemoved));
      }
      return const Ok(null);
    }
  }

  Future<Result<void, ResendFailedError>> _resendSendFailedMessage(
    AccountId receiverAccount,
    LocalMessageId localId,
  ) async {
    if (kIsWeb) {
      // Messages are not supported on web
      return const Err(ResendFailedError.unspecifiedError);
    }

    final clientId = await clientIdManager.getClientId().ok();
    if (clientId == null) {
      return const Err(ResendFailedError.unspecifiedError);
    }

    // Try to move failed messages to correct state if message sending
    // HTTP response receiving failed.
    final acknowledgeResult = await _markSentMessagesAcknowledged(clientId);
    if (acknowledgeResult.isErr()) {
      return const Err(ResendFailedError.unspecifiedError);
    }

    final toBeResent = await db.accountData((db) => db.daoMessages.getMessageUsingLocalMessageId(
      localId,
    )).ok();
    if (toBeResent == null) {
      return const Err(ResendFailedError.unspecifiedError);
    }
    if (toBeResent.messageState.toSentState() != SentMessageState.sendingError) {
      return const Err(ResendFailedError.isActuallySentSuccessfully);
    }

    ResendFailedError? sendingError;
    ResendFailedError? deleteError;
    await for (var e in _sendMessageTo(receiverAccount, toBeResent.messageText, sendUiEvent: false)) {
      switch (e) {
        case SavedToLocalDb():
          // actuallySentMessageCheck is false because the check is already done
          final deleteResult = await _deleteSendFailedMessage(receiverAccount, localId, sendUiEvent: false, actuallySentMessageCheck: false);
          switch (deleteResult) {
            case Err(:final e):
              deleteError = e.toResendFailedError();
            case Ok():
              ();
          }
          profile.sendProfileChange(ConversationChanged(toBeResent.remoteAccountId, ConversationChangeType.messageResent));
        case ErrorBeforeMessageSaving():
          sendingError = ResendFailedError.unspecifiedError;
        case ErrorAfterMessageSaving():
          sendingError = e.details?.toResendFailedError() ?? ResendFailedError.unspecifiedError;
      }
    }

    final currentSendingError = sendingError;
    if (currentSendingError != null) {
      // The unlikely delete error is ignored in this case
      return Err(currentSendingError);
    }
    final currentDeleteError = deleteError;
    if (currentDeleteError != null) {
      return Err(currentDeleteError);
    }
    return const Ok(null);
  }

  Future<Result<void, RetryPublicKeyDownloadError>> _retryPublicKeyDownload(
    // TODO(refactor): receiverAccount can be removed from every error handling
    //                 related action as it is also in MessageEntry
    AccountId receiverAccount,
    LocalMessageId localId,
  ) async {
    if (kIsWeb) {
      // Messages are not supported on web
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    }

    final allKeys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (allKeys == null) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    }

    final toBeDecrypted = await db.accountData((db) => db.daoMessages.getMessageUsingLocalMessageId(
      localId,
    )).ok();
    final messageNumber = toBeDecrypted?.messageNumber;
    if (toBeDecrypted == null || messageNumber == null || toBeDecrypted.messageState != MessageState.receivedAndPublicKeyDownloadFailed) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    }

    final messageBytes = base64.decode(toBeDecrypted.messageText);

    final String decryptedMessage;
    final ReceivedMessageState messageState;
    switch (await _decryptReceivedMessage(allKeys, toBeDecrypted.remoteAccountId, messageBytes)) {
      case Err(:final e):
        decryptedMessage = toBeDecrypted.messageText;
        switch (e) {
          case ReceivedMessageError.decryptingFailed:
            messageState = ReceivedMessageState.decryptingFailed;
          case ReceivedMessageError.unknownMessageType:
            messageState = ReceivedMessageState.unknownMessageType;
          case ReceivedMessageError.publicKeyDonwloadingFailed:
            return const Err(RetryPublicKeyDownloadError.unspecifiedError);
        }
      case Ok(:final v):
        decryptedMessage = v;
        messageState = ReceivedMessageState.received;
    }

    final r = await db.messageAction((db) => db.updateReceivedMessageState(
      currentUser,
      toBeDecrypted.remoteAccountId,
      messageNumber,
      messageState,
      messageText: decryptedMessage,
    ));
    if (r.isErr()) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    } else {
      return const Ok(null);
    }
  }
}

sealed class MessageSendingEvent {
  const MessageSendingEvent();
}
class SavedToLocalDb extends MessageSendingEvent {
  const SavedToLocalDb();
}

enum MessageSendingErrorDetails {
  messageTooLarge,
  tooManyPendingMessages,
  receiverBlockedSenderOrReceiverNotFound;

  ResendFailedError toResendFailedError() {
    switch (this) {
      case messageTooLarge:
        return ResendFailedError.messageTooLarge;
      case tooManyPendingMessages:
        return ResendFailedError.tooManyPendingMessages;
      case receiverBlockedSenderOrReceiverNotFound:
        return ResendFailedError.receiverBlockedSenderOrReceiverNotFound;
    }
  }
}

/// Error happened before the message was saved successfully
class ErrorBeforeMessageSaving extends MessageSendingEvent {
  const ErrorBeforeMessageSaving();
}
class ErrorAfterMessageSaving extends MessageSendingEvent {
  final LocalMessageId id;
  final MessageSendingErrorDetails? details;
  const ErrorAfterMessageSaving(this.id, [this.details]);
}

enum ReceivedMessageError {
  unknownMessageType,
  decryptingFailed,
  publicKeyDonwloadingFailed,
}

enum DeleteSendFailedError {
  unspecifiedError,
  isActuallySentSuccessfully;

  ResendFailedError toResendFailedError() {
    switch (this) {
      case unspecifiedError:
        return ResendFailedError.unspecifiedError;
      case isActuallySentSuccessfully:
        return ResendFailedError.isActuallySentSuccessfully;
    }
  }
}

enum ResendFailedError {
  unspecifiedError,
  isActuallySentSuccessfully,
  messageTooLarge,
  tooManyPendingMessages,
  receiverBlockedSenderOrReceiverNotFound,
}

enum RetryPublicKeyDownloadError {
  unspecifiedError,
}
