import 'dart:async';

import 'package:app/data/chat/backend_signed_message.dart';
import 'package:app/data/chat/message_manager/receive.dart';
import 'package:app/data/chat/message_manager/send.dart';
import 'package:app/data/chat/message_manager/utils.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/app_error.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

sealed class BaseMessageManagerCmd {}

sealed class MessageManagerCmd<T> extends BaseMessageManagerCmd {
  final BehaviorSubject<T?> completed = BehaviorSubject.seeded(null);

  /// Can be called only once
  Future<T> waitCompletionAndDispose() async {
    final value = await completed.whereType<T>().first;
    await completed.close();
    return value;
  }
}

class ReceiveNewMessages extends MessageManagerCmd<()> {}

class SendMessage extends BaseMessageManagerCmd {
  final ReplaySubject<MessageSendingEvent?> _events = ReplaySubject();
  final AccountId receiverAccount;
  final Message message;
  SendMessage(this.receiverAccount, this.message);

  Future<void> _sendNullAndDispose() async {
    _events.add(null);
    await _events.close();
  }

  Stream<MessageSendingEvent> events() async* {
    await for (final event in _events) {
      if (event == null) {
        return;
      }
      yield event;
    }
  }
}

class DeleteSendFailedMessage extends MessageManagerCmd<Result<(), DeleteSendFailedError>> {
  final LocalMessageId localId;
  DeleteSendFailedMessage(this.localId);
}

class ResendSendFailedMessage extends MessageManagerCmd<Result<(), ResendFailedError>> {
  final LocalMessageId localId;
  ResendSendFailedMessage(this.localId);
}

class ResendDeliveryFailedMessage extends MessageManagerCmd<Result<(), ResendDeliveryFailedError>> {
  final LocalMessageId localId;
  ResendDeliveryFailedMessage(this.localId);
}

class RetryPublicKeyDownload extends MessageManagerCmd<Result<(), RetryPublicKeyDownloadError>> {
  final LocalMessageId localId;
  RetryPublicKeyDownload(this.localId);
}

sealed class ImportChatBackupError {
  const ImportChatBackupError();
}

class InvalidBackupFile extends ImportChatBackupError {
  const InvalidBackupFile();
}

class UnsupportedBackupVersion extends ImportChatBackupError {
  const UnsupportedBackupVersion();
}

class WrongAccount extends ImportChatBackupError {
  const WrongAccount();
}

class OtherImportError extends ImportChatBackupError {
  const OtherImportError();
}

class CreateChatBackupCmd extends MessageManagerCmd<Result<ChatBackupData, DatabaseError>> {}

class ImportChatBackupCmd extends MessageManagerCmd<Result<(), ImportChatBackupError>> {
  final Uint8List bytes;
  ImportChatBackupCmd(this.bytes);
}

/// Synchronized message actions
class MessageManager extends LifecycleMethods {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final ProfileRepository profile;
  final AccountId currentUser;

  final ReceiveMessageUtils receiveMessageUtils;
  final SendMessageUtils sendMessageUtils;

  MessageManager(this.messageKeyManager, this.api, this.db, this.profile, this.currentUser)
    : receiveMessageUtils = ReceiveMessageUtils(messageKeyManager, api, db, currentUser, profile),
      sendMessageUtils = SendMessageUtils(messageKeyManager, api, db, currentUser, profile);

  final PublishSubject<BaseMessageManagerCmd> _commands = PublishSubject();
  StreamSubscription<void>? _commandsSubscription;

  @override
  Future<void> init() async {
    _commandsSubscription = _commands
        .asyncMap((cmd) async {
          switch (cmd) {
            case ReceiveNewMessages():
              await receiveMessageUtils.receiveNewMessages();
              cmd.completed.add(());
            case SendMessage(:final _events, :final receiverAccount, :final message):
              await for (final event in sendMessageUtils.sendMessageTo(receiverAccount, message)) {
                _events.add(event);
              }
              await cmd._sendNullAndDispose();
            case DeleteSendFailedMessage():
              cmd.completed.add(await _deleteSendFailedMessage(cmd.localId));
            case ResendSendFailedMessage():
              cmd.completed.add(await _resendSendFailedMessage(cmd.localId));
            case ResendDeliveryFailedMessage():
              cmd.completed.add(await _resendDeliveryFailedMessage(cmd.localId));
            case RetryPublicKeyDownload():
              cmd.completed.add(await _retryPublicKeyDownload(cmd.localId));
            case CreateChatBackupCmd():
              final result = await db.accountData((db) => db.backup.createBackup(currentUser));
              cmd.completed.add(result);
            case ImportChatBackupCmd(:final bytes):
              // Parse backup file
              final parseResult = ChatBackupFile.fromBytes(bytes);
              switch (parseResult) {
                case BackupFileParseSuccess(:final file):
                  try {
                    final backupData = file.decompress();

                    // Validate that backup was created by the current account
                    if (backupData.json.metadata.accountId != currentUser) {
                      cmd.completed.add(const Err(WrongAccount()));
                      break;
                    }

                    final result = await db.accountAction(
                      (db) => db.backup.restoreBackup(backupData),
                    );
                    if (result.isErr()) {
                      cmd.completed.add(const Err(OtherImportError()));
                    } else {
                      cmd.completed.add(const Ok(()));
                    }
                  } catch (e) {
                    cmd.completed.add(const Err(OtherImportError()));
                  }
                case InvalidBackupHeader():
                case FileTooShort():
                  cmd.completed.add(const Err(InvalidBackupFile()));
                case UnsupportedBackupFileVersion():
                  cmd.completed.add(const Err(UnsupportedBackupVersion()));
              }
          }
        })
        .listen((_) {});
  }

  @override
  Future<void> dispose() async {
    await _commandsSubscription?.cancel();
    await _commands.close();
  }

  void queueCmd(BaseMessageManagerCmd cmd) {
    _commands.add(cmd);
  }

  Future<Result<(), DeleteSendFailedError>> _deleteSendFailedMessage(
    LocalMessageId localId, {
    bool sendUiEvent = true,
    bool actuallySentMessageCheck = true,
  }) async {
    if (actuallySentMessageCheck) {
      // Try to move failed messages to correct state if message sending
      // HTTP response receiving failed.
      final acknowledgeResult = await sendMessageUtils.markSentMessagesAcknowledged();
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
    if (!(toBeRemoved.messageState.toSentState()?.sendingFailed() ?? false)) {
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
    // Try to move failed messages to correct state if message sending
    // HTTP response receiving failed.
    final acknowledgeResult = await sendMessageUtils.markSentMessagesAcknowledged();
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
    if (!(toBeResent.messageState.toSentState()?.sendingFailed() ?? false)) {
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

  Future<Result<(), ResendDeliveryFailedError>> _resendDeliveryFailedMessage(
    LocalMessageId localId,
  ) async {
    final toBeResent = await db
        .accountData((db) => db.message.getMessageUsingLocalMessageId(localId))
        .ok();
    final toBeResentMessage = toBeResent?.message?.removeResentMessages();
    if (toBeResent == null || toBeResentMessage == null) {
      return const Err(ResendDeliveryFailedError.unspecifiedError);
    }
    if (toBeResent.messageState.toSentState() != SentMessageState.deliveryFailed) {
      return const Err(ResendDeliveryFailedError.unspecifiedError);
    }

    final originalMessage = toBeResentMessage;
    final messageNumber = toBeResent.messageNumber;
    final messageId = toBeResent.messageId;
    final sentUnixTime = toBeResent.sentUnixTime;

    if (messageNumber == null || messageId == null || sentUnixTime == null) {
      return const Err(ResendDeliveryFailedError.unspecifiedError);
    }

    final resentMessage = ResentMessage(
      originalMessage,
      messageNumber,
      messageId,
      sentUnixTime.toUnixTime(),
    );

    ResendDeliveryFailedError? sendingError;
    await for (var e in sendMessageUtils.sendMessageTo(
      toBeResent.remoteAccountId,
      resentMessage,
      sendUiEvent: true,
    )) {
      switch (e) {
        case SavedToLocalDb():
          ();
        case ErrorBeforeMessageSaving():
          sendingError = ResendDeliveryFailedError.unspecifiedError;
        case ErrorAfterMessageSaving():
          sendingError =
              e.details?.toResendDeliveryFailedError() ??
              ResendDeliveryFailedError.unspecifiedError;
      }
    }

    if (sendingError != null) {
      return Err(sendingError);
    }

    // Change state of original message
    await db.accountDataWrite(
      (db) => db.message.updateSentMessageState(
        localId,
        sentState: SentMessageState.deliveryFailedAndResent,
      ),
    );

    return const Ok(());
  }

  Future<Result<(), RetryPublicKeyDownloadError>> _retryPublicKeyDownload(
    LocalMessageId localId,
  ) async {
    final allKeys = await messageKeyManager.getKeysWhenChatIsEnabled().ok();
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
    final backendSignedMessage = await BackendSignedMessage.parseFromSignedPgpMessage(
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
