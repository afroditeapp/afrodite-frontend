

import 'dart:async';
import 'dart:convert';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/message_converter.dart';
import 'package:pihka_frontend/data/chat/message_key_generator.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:utils/utils.dart';
import 'package:pihka_frontend/utils/iterator.dart';
import 'package:pihka_frontend/utils/result.dart';
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
  final BehaviorSubject<Result<void, DeleteSendFailedError>?> _completed = BehaviorSubject.seeded(null);
  final AccountId receiverAccount;
  final LocalMessageId localId;
  ResendSendFailedMessage(this.receiverAccount, this.localId);

  Future<Result<void, DeleteSendFailedError>> waitUntilReady() async  {
    return await _completed.whereNotNull().first;
  }
}

// TODO(prod): Move unread messages counter to background DB
// so that in the future push notifications can have count of messages
// pending on the server and app can show notification with count value
// where current DB count value is added with the pending messages count value.

/// Synchronized message actions
class MessageManager extends LifecycleMethods {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;

  MessageManager(this.messageKeyManager, this.api, this.db, this.profile, this.accountBackgroundDb, this.currentUser);

  final PublishSubject<MessageManagerCommand> _commands = PublishSubject();
  StreamSubscription<void>? _commandsSubscription;

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
        await db.accountAction((db) => db.daoMatches.setMatchStatus(message.id.sender, true));
        profile.sendProfileChange(MatchesChanged());
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
      switch (await _decryptReceivedMessage(allKeys, message, messageBytes)) {
        case Err(:final e):
          decryptedMessage = base64Encode(messageBytes);
          switch (e) {
            case ReceivedMessageError.decryptingFailed:
              messageState = ReceivedMessageState.decryptingFailed;
            case ReceivedMessageError.unknownMessageType:
              messageState = ReceivedMessageState.unknownMessageType;
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
        profile.sendProfileChange(ConversationChanged(message.id.sender, ConversationChangeType.messageReceived));
        // TODO(prod): Update with unread message message count from DB once
        // push notifications support other than the first new message.
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(message.id.sender, 1, accountBackgroundDb);
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

  Future<Result<String, ReceivedMessageError>> _decryptReceivedMessage(AllKeyData allKeys, PendingMessage message, Uint8List messageBytesFromServer) async {
    // 0 is PGP message
    if (messageBytesFromServer.isEmpty || messageBytesFromServer.first != 0) {
      return const Err(ReceivedMessageError.unknownMessageType);
    }
    final encryptedMessageBytes = Uint8List.fromList(messageBytesFromServer.skip(1).toList());

    bool forcePublicKeyDownload = false;
    while (true) {
      var publicKey = await _getPublicKeyForForeignAccount(message.id.sender, forceDownload: forcePublicKeyDownload).ok();
      if (publicKey == null) {
        return const Err(ReceivedMessageError.decryptingFailed);
      }

      final (messageBytes, decryptingResult) = decryptMessage(
        publicKey.data.data,
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

  // TODO(prod): The error correction needs to happend before the message sending
  // because if sending fails for multiple messages it is not sure what
  // message will succeed.
  //
  // Or not. Change message sending API to have check sent messages queue
  // (like receive messages queue). With that the message sending
  // is reliable and the logic is simple.
  // If everything related to message sending in client is synchronous, then
  // it could be possible to use one "slot" for the sent message and
  // remove/check that every time the message is sent. But that makes multiple
  // clients problematic so implement queue instead.
  //
  // The message uniqueness is still problem between clients. Randomnes kinda
  // works (or in practice works) but all client's could have ID number and
  // that could be combined with message local ID, so the new ID for the message
  // will be unique. The API which returns client ID, could be HTTP POST
  // so server will increment the ID, so next value returned will be unique.

  Stream<MessageSendingEvent> _sendMessageToInternal(AccountId accountId, String message, {bool sendUiEvent = true}) async* {
    final isMatch = await isInMatches(accountId);
    if (!isMatch) {
      final resultSendLike = await api.chatAction((api) => api.postSendLike(accountId));
      if (resultSendLike.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      final matchStatusChange = await db.accountAction((db) => db.daoMatches.setMatchStatus(accountId, true));
      if (matchStatusChange.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      profile.sendProfileChange(MatchesChanged());
      // TODO: Remove received likes status change once those are changed
      //       to server side iterator. This will be removed so it does not
      //       matter that this is not a transaction. And it is unlikely
      //       that this would return an error.
      final likeStatusChange = await db.accountAction((db) => db.daoProfileStates.setReceivedLikeStatus(accountId, false));
      if (likeStatusChange.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      profile.sendProfileChange(LikesChanged());
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
        // TODO(prod): is this needed?
        final SentMessageState? stateForLastMessage;
        if (lastSentMessage != null && lastSentMessage.sentMessageState == SentMessageState.pending) {
          final result = await db.messageAction((db) => db.updateSentMessageState(
            lastSentMessage.localId,
            sentState: SentMessageState.sendingError,
          ));
          if (result.isErr()) {
            yield const ErrorBeforeMessageSaving();
            return;
          }
          stateForLastMessage = SentMessageState.sendingError;
        } else {
          stateForLastMessage = lastSentMessage?.sentMessageState;
        }
    }

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

    final currentUserKeys = await messageKeyManager.generateOrLoadMessageKeys().ok();
    if (currentUserKeys == null) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }
    PublicKey receiverPublicKey;
    final receiverPublicKeyOrNull = await _getPublicKeyForForeignAccount(accountId, forceDownload: false).ok();
    if (receiverPublicKeyOrNull == null) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }
    receiverPublicKey = receiverPublicKeyOrNull;

    final messageBytes = MessageConverter().textToBytes(message).ok();
    if (messageBytes == null) {
      yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.messageTooLarge);
      return;
    }

    final (encryptedMessage, encryptingResult) = encryptMessage(
      currentUserKeys.private.data,
      receiverPublicKey.data.data,
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
    var publicKeyRefreshTried = false;
    var messageSenderIdUpdateTried = false;
    while (true) {
      final result = await api.chat((api) => api.postSendMessage(
        accountId.aid,
        receiverPublicKey.id.id,
        receiverPublicKey.version.version,
        0,
        0,
        MultipartFile.fromBytes("", dataIdentifierAndEncryptedMessage),
      )).ok();
      if (result == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      // TODO(prod): Handle acknowledgement count errors
      // if (result.errorTooManyPendingMessages) {
      //   yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.tooManyPendingMessages);
      //   return;
      // }

      if (result.errorReceiverPublicKeyOutdated) {
        if (publicKeyRefreshTried) {
          yield ErrorAfterMessageSaving(localId);
          return;
        } else {
          publicKeyRefreshTried = true;

          // Retry once after public key refresh
          log.error("Send message error: public key outdated");

          final receiverPublicKeyOrNull = await _getPublicKeyForForeignAccount(accountId, forceDownload: true).ok();
          if (receiverPublicKeyOrNull == null) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }
          receiverPublicKey = receiverPublicKeyOrNull;
          continue;
        }
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
  }

  /// If PublicKey is null then PublicKey for that account does not exist.
  Future<Result<PublicKey?, void>> _getPublicKeyForForeignAccount(
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
    return await api.chat((api) => api.getPublicKey(accountId.aid, 1))
      .andThen((key) => db.accountAction((db) => db.daoConversations.updatePublicKey(accountId, key.key)))
      .mapErr((_) => null);
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.daoMatches.isInMatches(accountId)).ok() ?? false;
  }

  Future<Result<void, DeleteSendFailedError>> _deleteSendFailedMessage(
    AccountId receiverAccount,
    LocalMessageId localId,
    {
      bool sendUiEvent = true,
    }
  ) async {
    if (kIsWeb) {
      // Messages are not supported on web
      return const Err(DeleteSendFailedError.unspecifiedError);
    }

    final lastSentMessageResult = await db.accountData((db) => db.daoMessages.getLatestSentMessage(
      currentUser,
      receiverAccount,
    ));
    final MessageEntry? lastSentMessage;
    switch (lastSentMessageResult) {
      case Err():
        return const Err(DeleteSendFailedError.unspecifiedError);
      case Ok(:final v):
        lastSentMessage = v;
    }

    final toBeRemoved = await db.accountData((db) => db.daoMessages.getMessageUsingLocalMessageId(
      localId,
    )).ok();
    if (toBeRemoved == null) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    }

    if (toBeRemoved.sentMessageState != SentMessageState.sendingError) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    }

    // final toBeRemovedSenderMessageId = toBeRemoved.senderMessageId;
    // if (toBeRemovedSenderMessageId != null && lastSentMessage?.localId == localId) {
      // Error correction check is possible to do

      // TODO(prod): Update error correction
    // }

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

  Future<Result<void, DeleteSendFailedError>> _resendSendFailedMessage(
    AccountId receiverAccount,
    LocalMessageId localId,
  ) async {
    if (kIsWeb) {
      // Messages are not supported on web
      return const Err(DeleteSendFailedError.unspecifiedError);
    }

    final toBeResent = await db.accountData((db) => db.daoMessages.getMessageUsingLocalMessageId(
      localId,
    )).ok();
    if (toBeResent == null) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    }

    // TODO(prod): Change delete to happen after sending in the future.
    // TODO(prod): Change error type to include MessageSendingErrorDetails
    //             cases.

    final deleteResult = await _deleteSendFailedMessage(receiverAccount, localId, sendUiEvent: false);
    switch (deleteResult) {
      case Err(:final e):
        return Err(e);
      case Ok():
        ();
    }

    var sendError = false;
    await for (var e in _sendMessageTo(receiverAccount, toBeResent.messageText, sendUiEvent: false)) {
      switch (e) {
        case SavedToLocalDb():
          ();
        case ErrorBeforeMessageSaving():
          sendError = true;
        case ErrorAfterMessageSaving():
          sendError = true;
      }
    }

    if (sendError) {
      profile.sendProfileChange(ConversationChanged(toBeResent.remoteAccountId, ConversationChangeType.messageRemoved));
      return const Err(DeleteSendFailedError.unspecifiedError);
    } else {
      profile.sendProfileChange(ConversationChanged(toBeResent.remoteAccountId, ConversationChangeType.messageResent));
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
}

enum DeleteSendFailedError {
  unspecifiedError,
  isActuallySentSuccessfully,
}
