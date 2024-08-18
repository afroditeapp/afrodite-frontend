

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart' show StreamExtensions;
import 'package:database/database.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/message.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/chat/message_converter.dart';
import 'package:pihka_frontend/data/chat/message_key_generator.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/iterator.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("MessageExtensions");

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

/// Synchronized message actions
class MessageManager extends LifecycleMethods {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;

  MessageManager(this.messageKeyManager, this.api, this.db, this.profile, this.accountBackgroundDb);

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
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      return;
    }
    final allKeys = await messageKeyManager.generateOrLoadMessageKeys(currentUser).ok();
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
      final isMatch = await isInMatches(message.id.accountIdSender);
      if (!isMatch) {
        await db.profileAction((db) => db.setMatchStatus(message.id.accountIdSender, true));
        profile.sendProfileChange(MatchesChanged());
      }

      // TODO: Check if the message is already in DB (use message number
      // and account IDs as together those are unique).

      // TODO: Store some error state to database
      //       instead of the error text.
      final decryptedMessage = await _decryptReceivedMessage(allKeys, message, messageBytes).ok() ?? "Message decrypting failed";

      final r = await db.messageAction((db) => db.insertReceivedMessage(currentUser, message, decryptedMessage));
      if (r.isOk()) {
        toBeDeleted.add(message.id);
        profile.sendProfileChange(ConversationChanged(message.id.accountIdSender, ConversationChangeType.messageReceived));
        // TODO(prod): Update with correct message count once there is
        // count of not read messages in the database.
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(message.id.accountIdSender, 1, accountBackgroundDb);
      }
    }

    for (final sender in newMessages.map((item) => item.$1.id.accountIdSender).toSet()) {
      await accountBackgroundDb.accountAction((db) => db.daoNewMessageNotification.setNotificationShown(sender, false));
    }

    final toBeDeletedList = PendingMessageDeleteList(messagesIds: toBeDeleted);
    final result = await api.chatAction((api) => api.deletePendingMessages(toBeDeletedList));
    if (result.isOk()) {
      for (final (message, _) in newMessages) {
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

  Future<Result<String, void>> _decryptReceivedMessage(AllKeyData allKeys, PendingMessage message, Uint8List messageBytesFromServer) async {
    final publicKey = await _getPublicKeyForForeignAccount(message.id.accountIdSender, forceDownload: false).ok();
    if (publicKey == null) {
      return const Err(null);
    }

    // 0 is PGP message
    if (messageBytesFromServer.isEmpty || messageBytesFromServer.first != 0) {
      return const Err(null);
    }
    final encryptedMessageBytes = Uint8List.fromList(messageBytesFromServer.skip(1).toList());

    final (messageBytes, decryptingResult) = decryptMessage(
      publicKey.data.data,
      allKeys.private.data,
      encryptedMessageBytes,
    );

    if (messageBytes == null) {
      // TODO: try again with downloaded public key
      log.error("TODO: try again public key downloading, error: $decryptingResult");
      return const Err(null);
    }

    return MessageConverter().bytesToText(messageBytes);
  }

  Stream<MessageSendingEvent> _sendMessageTo(AccountId accountId, String message) async* {
      await for (final e in _sendMessageToInternal(accountId, message)) {
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

  Stream<MessageSendingEvent> _sendMessageToInternal(AccountId accountId, String message) async* {
    final currentUser = await LoginRepository.getInstance().accountId.firstOrNull;
    if (currentUser == null) {
      yield const ErrorBeforeMessageSaving();
      return;
    }

    final isMatch = await isInMatches(accountId);
    if (!isMatch) {
      final resultSendLike = await api.chatAction((api) => api.postSendLike(accountId));
      if (resultSendLike.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      final matchStatusChange = await db.profileAction((db) => db.setMatchStatus(accountId, true));
      if (matchStatusChange.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      profile.sendProfileChange(MatchesChanged());
      // TODO: Remove received likes status change once those are changed
      //       to server side iterator. This will be removed so it does not
      //       matter that this is not a transaction. And it is unlikely
      //       that this would return an error.
      final likeStatusChange = await db.profileAction((db) => db.setReceivedLikeStatus(accountId, false));
      if (likeStatusChange.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      profile.sendProfileChange(LikesChanged());
    }

    final nextExpectedIdResult = await db.accountData((db) => db.daoProfiles.getNextSenderMessageId(
      accountId,
    ));
    SenderMessageId nextSenderMessageId;
    switch (nextExpectedIdResult) {
      case Err():
        yield const ErrorBeforeMessageSaving();
        return;
      case Ok(:final v):
        if (v == null) {
          final initialId = SenderMessageId(id: 0);
          final senderMessageIdResult = await api.chatAction((api) => api.postSenderMessageId(
            accountId.accountId,
            initialId,
          ));
          if (senderMessageIdResult.isErr()) {
            yield const ErrorBeforeMessageSaving();
            return;
          }
          final dbResult = await db.accountAction((db) => db.daoProfiles.setNextSenderMessageId(
            accountId,
            initialId,
          ));
          if (dbResult.isErr()) {
            yield const ErrorBeforeMessageSaving();
            return;
          }
          nextSenderMessageId = initialId;
        } else {
          nextSenderMessageId = v;
        }
    }

    final saveMessageResult = await db.messageData((db) => db.insertToBeSentMessage(
      currentUser,
      accountId,
      message,
      nextSenderMessageId,
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

    profile.sendProfileChange(ConversationChanged(accountId, ConversationChangeType.messageSent));

    final currentUserKeys = await messageKeyManager.generateOrLoadMessageKeys(currentUser).ok();
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

    final lastSentMessageResult = await db.accountData((db) => db.daoMessages.getLatestSentMessage(
      currentUser,
      accountId,
    ));
    final LocalMessageId? lastSentMessageLocalId;
    final SentMessageState? lastSentMessageSentState;
    switch (lastSentMessageResult) {
      case Err():
        yield ErrorAfterMessageSaving(localId);
        return;
      case Ok(v: final lastSentMessage):
        lastSentMessageLocalId = lastSentMessage?.localId;
        final lastSentMessageLocalId2 = lastSentMessage?.localId; // Compiler null checks are not working
        // If previous sent message is still in pending state, then the app is
        // probably closed or crashed too early.
        if (lastSentMessage != null && lastSentMessageLocalId2 != null && lastSentMessage.sentMessageState == SentMessageState.pending) {
          final result = await db.messageAction((db) => db.updateSentMessageState(
            lastSentMessageLocalId2,
            sentState: SentMessageState.sendingError,
          ));
          if (result.isErr()) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }
          lastSentMessageSentState = SentMessageState.sendingError;
        } else {
          lastSentMessageSentState = lastSentMessage?.sentMessageState;
        }
    }

    int unixTimeFromServer;
    int messageNumberFromServer;
    var publicKeyRefreshTried = false;
    var messageSenderIdUpdateTried = false;
    while (true) {
      final result = await api.chat((api) => api.postSendMessage(
        accountId.accountId,
        receiverPublicKey.id.id,
        receiverPublicKey.version.version,
        nextSenderMessageId.id,
        MultipartFile.fromBytes("", dataIdentifierAndEncryptedMessage),
      )).ok();
      if (result == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      if (result.errorTooManyPendingMessages) {
        yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.tooManyPendingMessages);
        return;
      }

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

      final notExpectedSenderMessageId = result.errorSenderMessageIdWasNotExpectedId;
      if (notExpectedSenderMessageId != null) {
        if (messageSenderIdUpdateTried) {
          yield ErrorAfterMessageSaving(localId);
          return;
        } else {
          messageSenderIdUpdateTried = true;

          log.error("Send message error: server assumed different sender message ID");

          final lastSentMessageLocalId2 = lastSentMessageLocalId; // Compiler workaround
          if (
            lastSentMessageLocalId2 != null &&
            lastSentMessageSentState == SentMessageState.sendingError &&
            nextSenderMessageId.id + 1 == notExpectedSenderMessageId.id
          ) {
            log.info("Send message: the previous message was actually sent successfully");
            final result = await db.messageAction((db) => db.updateSentMessageState(
              lastSentMessageLocalId2,
              sentState: SentMessageState.sent,
            ));
            if (result.isErr()) {
              yield ErrorAfterMessageSaving(localId);
              return;
            }
          }

          // Use expected sender message ID on next try
          nextSenderMessageId = notExpectedSenderMessageId;
          final dbResult = await db.accountAction((db) => db.daoProfiles.setNextSenderMessageId(
            accountId,
            nextSenderMessageId,
          ));
          if (dbResult.isErr()) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }
          final updateMessageResult = await db.messageAction((db) => db.updateSentMessageState(
            localId,
            senderMessageId: nextSenderMessageId,
          ));
          if (updateMessageResult.isErr()) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }

          continue;
        }
      }

      final unixTimeFromResult = result.unixTime;
      final messageNumberFromResult = result.messageNumber;
      if (unixTimeFromResult == null || messageNumberFromResult == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }
      unixTimeFromServer = unixTimeFromResult;
      messageNumberFromServer = messageNumberFromResult;
      break;
    }

    final setNextSenderMessasgeIdResult = await db.accountAction((db) => db.daoProfiles.setNextSenderMessageId(
      accountId,
      SenderMessageId(id: nextSenderMessageId.id + 1)
    ));
    if (setNextSenderMessasgeIdResult.isErr()) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final updateSentState = await db.messageAction((db) => db.updateSentMessageState(
      localId,
      sentState: SentMessageState.sent,
      unixTimeFromServer: unixTimeFromServer,
      messageNumberFromServer: MessageNumber(messageNumber: messageNumberFromServer),
      senderMessageId: nextSenderMessageId,
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

    switch (await db.profileData((db) => db.getPublicKey(accountId))) {
      case Ok(:final v):
        if (v == null) {
          if (await _refreshForeignPublicKey(accountId).isErr()) {
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

  Future<Result<void, void>> _refreshForeignPublicKey(AccountId accountId) async {
    return await api.chat((api) => api.getPublicKey(accountId.accountId, 1))
      .andThen((key) => db.profileAction((db) => db.updatePublicKey(accountId, key.key)))
      .mapErr((_) => null);
  }

  Future<bool> isInMatches(AccountId accountId) async {
    return await db.profileData((db) => db.isInMatches(accountId)).ok() ?? false;
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
