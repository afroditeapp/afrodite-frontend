import 'dart:async';

import 'package:app/data/chat/backend_signed_message.dart';
import 'package:app/data/chat/message_manager/receive.dart';
import 'package:app/data/chat/message_manager/send.dart';
import 'package:app/data/chat/message_manager/utils.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

sealed class MessageManagerCommand {}

class ReceiveNewMessages extends MessageManagerCommand {
  final BehaviorSubject<bool> _completed = BehaviorSubject.seeded(false);

  Future<void> waitUntilReady() async {
    await _completed.where((v) {
      return v;
    }).first;
    return;
  }
}

class SendMessage extends MessageManagerCommand {
  final ReplaySubject<MessageSendingEvent?> _events = ReplaySubject();
  final AccountId receiverAccount;
  final Message message;
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
  final BehaviorSubject<Result<(), DeleteSendFailedError>?> _completed = BehaviorSubject.seeded(
    null,
  );
  final LocalMessageId localId;
  DeleteSendFailedMessage(this.localId);

  Future<Result<(), DeleteSendFailedError>> waitUntilReady() async {
    return await _completed.whereNotNull().first;
  }
}

class ResendSendFailedMessage extends MessageManagerCommand {
  final BehaviorSubject<Result<(), ResendFailedError>?> _completed = BehaviorSubject.seeded(null);
  final LocalMessageId localId;
  ResendSendFailedMessage(this.localId);

  Future<Result<(), ResendFailedError>> waitUntilReady() async {
    return await _completed.whereNotNull().first;
  }
}

class RetryPublicKeyDownload extends MessageManagerCommand {
  final BehaviorSubject<Result<(), RetryPublicKeyDownloadError>?> _completed =
      BehaviorSubject.seeded(null);
  final LocalMessageId localId;
  RetryPublicKeyDownload(this.localId);

  Future<Result<(), RetryPublicKeyDownloadError>> waitUntilReady() async {
    return await _completed.whereNotNull().first;
  }
}

/// Synchronized message actions
class MessageManager extends LifecycleMethods {
  final MessageKeyManager messageKeyManager;
  final ClientIdManager clientIdManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;

  final ReceiveMessageUtils receiveMessageUtils;
  final SendMessageUtils sendMessageUtils;

  MessageManager(
    this.messageKeyManager,
    this.clientIdManager,
    this.api,
    this.db,
    this.profile,
    this.accountBackgroundDb,
    this.currentUser,
  ) : receiveMessageUtils = ReceiveMessageUtils(
        messageKeyManager,
        api,
        db,
        accountBackgroundDb,
        currentUser,
        profile,
      ),
      sendMessageUtils = SendMessageUtils(
        messageKeyManager,
        clientIdManager,
        api,
        db,
        currentUser,
        profile,
      );

  final PublishSubject<MessageManagerCommand> _commands = PublishSubject();
  StreamSubscription<void>? _commandsSubscription;

  @override
  Future<void> init() async {
    _commandsSubscription = _commands
        .asyncMap((cmd) async {
          switch (cmd) {
            case ReceiveNewMessages(:final _completed):
              await receiveMessageUtils.receiveNewMessages();
              _completed.add(true);
            case SendMessage(:final _events, :final receiverAccount, :final message):
              await for (final event in sendMessageUtils.sendMessageTo(receiverAccount, message)) {
                _events.add(event);
              }
              _events.add(null);
            case DeleteSendFailedMessage(:final _completed, :final localId):
              _completed.add(await _deleteSendFailedMessage(localId));
            case ResendSendFailedMessage(:final _completed, :final localId):
              _completed.add(await _resendSendFailedMessage(localId));
            case RetryPublicKeyDownload(:final _completed, :final localId):
              _completed.add(await _retryPublicKeyDownload(localId));
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

  Future<Result<(), DeleteSendFailedError>> _deleteSendFailedMessage(
    LocalMessageId localId, {
    bool sendUiEvent = true,
    bool actuallySentMessageCheck = true,
  }) async {
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
      final acknowledgeResult = await sendMessageUtils.markSentMessagesAcknowledged(clientId);
      if (acknowledgeResult.isErr()) {
        return const Err(DeleteSendFailedError.unspecifiedError);
      }
    }

    final toBeRemoved = await db
        .accountData((db) => db.message.getMessageUsingLocalMessageId(localId))
        .ok();
    if (toBeRemoved == null) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    }
    if (toBeRemoved.messageState.toSentState() != SentMessageState.sendingError) {
      return const Err(DeleteSendFailedError.isActuallySentSuccessfully);
    }

    final deleteResult = await db.accountDataWrite((db) => db.message.deleteMessage(localId));
    if (deleteResult.isErr()) {
      return const Err(DeleteSendFailedError.unspecifiedError);
    } else {
      if (sendUiEvent) {
        profile.sendProfileChange(
          ConversationChanged(toBeRemoved.remoteAccountId, ConversationChangeType.messageRemoved),
        );
      }
      return const Ok(());
    }
  }

  Future<Result<(), ResendFailedError>> _resendSendFailedMessage(LocalMessageId localId) async {
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
    final acknowledgeResult = await sendMessageUtils.markSentMessagesAcknowledged(clientId);
    if (acknowledgeResult.isErr()) {
      return const Err(ResendFailedError.unspecifiedError);
    }

    final toBeResent = await db
        .accountData((db) => db.message.getMessageUsingLocalMessageId(localId))
        .ok();
    final toBeResentMessage = toBeResent?.message;
    if (toBeResent == null || toBeResentMessage == null) {
      return const Err(ResendFailedError.unspecifiedError);
    }
    if (toBeResent.messageState.toSentState() != SentMessageState.sendingError) {
      return const Err(ResendFailedError.isActuallySentSuccessfully);
    }
    final receiverAccount = toBeResent.remoteAccountId;

    ResendFailedError? sendingError;
    ResendFailedError? deleteError;
    await for (var e in sendMessageUtils.sendMessageTo(
      receiverAccount,
      toBeResentMessage,
      sendUiEvent: false,
    )) {
      switch (e) {
        case SavedToLocalDb():
          // actuallySentMessageCheck is false because the check is already done
          final deleteResult = await _deleteSendFailedMessage(
            localId,
            sendUiEvent: false,
            actuallySentMessageCheck: false,
          );
          switch (deleteResult) {
            case Err(:final e):
              deleteError = e.toResendFailedError();
            case Ok():
              ();
          }
          profile.sendProfileChange(
            ConversationChanged(toBeResent.remoteAccountId, ConversationChangeType.messageResent),
          );
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
    return const Ok(());
  }

  Future<Result<(), RetryPublicKeyDownloadError>> _retryPublicKeyDownload(
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

    final toBeDecrypted = await db
        .accountData((db) => db.message.getMessageUsingLocalMessageId(localId))
        .ok();
    if (toBeDecrypted == null ||
        toBeDecrypted.messageState != MessageState.receivedAndPublicKeyDownloadFailed) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    }
    final backendSignedPgpMessage = await db
        .accountData((db) => db.message.getBackendSignedPgpMessage(localId))
        .ok();
    if (backendSignedPgpMessage == null) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    }
    final backendSignedMessage = BackendSignedMessage.parseFromSignedPgpMessage(
      backendSignedPgpMessage,
    );
    if (backendSignedMessage == null) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    }

    final Message? decryptedMessage;
    final Uint8List? symmetricMessageEncryptionKey;
    final ReceivedMessageState messageState;
    switch (await receiveMessageUtils.decryptReceivedMessage(allKeys, backendSignedMessage)) {
      case Err(:final e):
        decryptedMessage = null;
        symmetricMessageEncryptionKey = null;
        switch (e) {
          case ReceivedMessageError.decryptingFailed:
            messageState = ReceivedMessageState.decryptingFailed;
          case ReceivedMessageError.publicKeyDonwloadingFailed:
            return const Err(RetryPublicKeyDownloadError.unspecifiedError);
        }
      case Ok(v: (final message, final symmetricKey)):
        decryptedMessage = message;
        symmetricMessageEncryptionKey = symmetricKey;
        messageState = ReceivedMessageState.received;
    }

    final r = await db.accountAction(
      (db) => db.message.updateReceivedMessageState(
        localId,
        messageState,
        messageValue: decryptedMessage,
        symmetricMessageEncryptionKey: symmetricMessageEncryptionKey,
      ),
    );
    if (r.isErr()) {
      return const Err(RetryPublicKeyDownloadError.unspecifiedError);
    } else {
      return const Ok(());
    }
  }
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

enum RetryPublicKeyDownloadError { unspecifiedError }
