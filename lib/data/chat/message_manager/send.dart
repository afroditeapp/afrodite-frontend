import 'dart:async';
import 'dart:convert';

import 'package:app/data/chat/backend_signed_message.dart';
import 'package:app/data/chat/message_manager/delivery_info.dart';
import 'package:app/data/chat/message_manager/public_key.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/data/chat/message_manager/utils.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';
import 'package:uuid/uuid.dart';

final _log = Logger("SendMessageUtils");

class SendMessageUtils {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountId currentUser;
  final ProfileRepository profile;
  final DeliveryInfoUtils deliveryInfoUtils;

  final PublicKeyUtils publicKeyUtils;

  SendMessageUtils(this.messageKeyManager, this.api, this.db, this.currentUser, this.profile)
    : publicKeyUtils = PublicKeyUtils(db, api, currentUser),
      deliveryInfoUtils = DeliveryInfoUtils(db, api, currentUser);

  bool allSentMessagesAcknowledgedOnce = false;

  Stream<MessageSendingEvent> sendMessageTo(
    AccountId accountId,
    Message message, {
    bool sendUiEvent = true,
  }) async* {
    await for (final e in _sendMessageToInternal(accountId, message, sendUiEvent: sendUiEvent)) {
      switch (e) {
        case SavedToLocalDb():
          yield e;
        case ErrorBeforeMessageSaving():
          yield e;
        case ErrorAfterMessageSaving(:final id):
          // The existing error is more important, so ignore
          // the state change result.
          await db.accountAction(
            (db) => db.message.updateSentMessageState(id, sentState: SentMessageState.sendingError),
          );
          yield e;
      }
    }
  }

  Stream<MessageSendingEvent> _sendMessageToInternal(
    AccountId accountId,
    Message message, {
    bool sendUiEvent = true,
  }) async* {
    final isMatch = await _isInMatches(accountId);
    if (!isMatch) {
      final resultSendLike = await api.chatAction((api) => api.postSendLike(accountId));
      if (resultSendLike.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
      final matchStatusChange = await db.accountAction(
        (db) => db.profile.setMatchStatus(accountId, true),
      );
      if (matchStatusChange.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
    }

    final lastSentMessageResult = await db.accountData(
      (db) => db.message.getLatestSentMessage(accountId),
    );
    switch (lastSentMessageResult) {
      case Err():
        yield const ErrorBeforeMessageSaving();
        return;
      case Ok(v: final lastSentMessage):
        // If previous sent message is still in pending state, then the app is
        // probably closed or crashed too early.
        if (lastSentMessage != null &&
            lastSentMessage.messageState.toSentState() == SentMessageState.pending) {
          final result = await db.accountAction(
            (db) => db.message.updateSentMessageState(
              lastSentMessage.localId,
              sentState: SentMessageState.sendingError,
            ),
          );
          if (result.isErr()) {
            yield const ErrorBeforeMessageSaving();
            return;
          }
        }
    }

    final ForeignPublicKey receiverPublicKey;
    final receiverPublicKeyOrNull = await publicKeyUtils
        .getPublicKeyForForeignAccountFromDbOrDownloadIfNotExits(accountId)
        .ok();
    if (receiverPublicKeyOrNull == null) {
      yield const ErrorBeforeMessageSaving();
      return;
    }
    receiverPublicKey = receiverPublicKeyOrNull;

    final messageId = MessageId(id: base64UrlEncode(Uuid().v4obj().toBytes()).replaceAll("=", ""));

    final saveMessageResult = await db.accountDataWrite(
      (db) => db.message.insertToBeSentMessage(accountId, messageId, message),
    );
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

    final currentUserKeys = await messageKeyManager.getKeysWhenChatIsEnabled().ok();
    if (currentUserKeys == null) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final (encryptedMessage, encryptingResult) = await encryptMessage(
      currentUserKeys.private.data,
      receiverPublicKey.data,
      message.toMessagePacket(),
    );

    if (encryptedMessage == null) {
      _log.error("Message encryption error: $encryptingResult");
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final updateSymmetricEncryptionKeyResult = await db.accountAction(
      (db) => db.message.updateSymmetricMessageEncryptionKey(localId, encryptedMessage.sessionKey),
    );
    if (updateSymmetricEncryptionKeyResult.isErr()) {
      _log.error("Updating symmetric encryption key failed");
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    UnixTime unixTimeFromServer;
    MessageId messageIdFromServer;
    MessageNumber messageNumberFromServer;
    Uint8List backendSignedPgpMessage;
    var messageSenderAcknowledgementTried = false;
    var pendingDeliveryInfoReceivingTried = false;
    while (true) {
      final requestResult = await api.chat(
        (api) => api.postSendMessage(
          currentUserKeys.publicKeyId.id,
          accountId.aid,
          receiverPublicKey.id.id,
          messageId.id,
          MultipartFile.fromBytes("", encryptedMessage.pgpMessage),
        ),
      );

      final SendMessageResult result;
      switch (requestResult) {
        case Ok(v: final v):
          result = v;
        case Err(e: final e):
          if (e.isTooManyRequests()) {
            yield ErrorAfterMessageSaving(localId, MessageSendingErrorDetails.rateLimit);
          } else {
            yield ErrorAfterMessageSaving(localId);
          }
          return;
      }

      if (result.errorReceiverBlockedSenderOrReceiverNotFound) {
        yield ErrorAfterMessageSaving(
          localId,
          MessageSendingErrorDetails.receiverBlockedSenderOrReceiverNotFound,
        );
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

          _log.error("Send message error: too many sender acknowledgements missing");

          final acknowledgeResult = await markSentMessagesAcknowledged();
          if (acknowledgeResult.isErr()) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }
          continue;
        }
      }

      if (result.errorTooManyPendingDeliveryInfosExists) {
        if (pendingDeliveryInfoReceivingTried) {
          yield ErrorAfterMessageSaving(localId);
          return;
        } else {
          pendingDeliveryInfoReceivingTried = true;

          _log.error("Send message error: too many pending delivery infos exists");

          await deliveryInfoUtils.receiveMessageDeliveryInfo();
          continue;
        }
      }

      if (result.errorSenderPublicKeyOutdated) {
        // This should not happen as client sends new public key to server
        // if needed on login.

        _log.error("Send message error: sender public key outdated");

        yield ErrorAfterMessageSaving(localId);
        return;
      }

      if (result.errorReceiverPublicKeyOutdated) {
        _log.error("Send message error: receiver public key outdated");

        await publicKeyUtils.getLatestPublicKeyForForeignAccount(accountId);
        // Show possible key change info to user
        if (sendUiEvent) {
          profile.sendProfileChange(
            ConversationChanged(accountId, ConversationChangeType.messageSent),
          );
        }
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      if (result.error) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      final remainingMessages = result.remainingMessages;
      if (remainingMessages != null &&
          (remainingMessages == 50 ||
              remainingMessages == 25 ||
              remainingMessages == 10 ||
              (remainingMessages >= 0 && remainingMessages <= 5))) {
        showSnackBar(
          R.strings.conversation_screen_remaining_daily_messages(remainingMessages.toString()),
        );
      }

      final signedPgpMessageBase64 = result.d;
      if (signedPgpMessageBase64 == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      backendSignedPgpMessage = base64Decode(signedPgpMessageBase64);

      final (backendSignedMessage, getMessageContentResult) = await getMessageContent(
        backendSignedPgpMessage,
      );
      if (backendSignedMessage == null) {
        _log.error(
          "Send message error: get message content failed, error: $getMessageContentResult",
        );
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      final data = BackendSignedMessage.parse(backendSignedMessage);
      if (data == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }
      unixTimeFromServer = data.serverTime;
      messageIdFromServer = data.messageId;
      messageNumberFromServer = data.messageNumber;
      break;
    }

    final updateSentState = await db.accountAction(
      (db) => db.message.updateSentMessageState(
        localId,
        sentState: SentMessageState.sent,
        unixTimeFromServer: unixTimeFromServer,
        messageIdFromServer: messageIdFromServer,
        messageNumberFromServer: messageNumberFromServer,
        backendSignePgpMessage: backendSignedPgpMessage,
      ),
    );
    if (updateSentState.isErr()) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    if (!allSentMessagesAcknowledgedOnce) {
      await markSentMessagesAcknowledged();
    } else {
      await api.chatAction(
        (api) => api.postAddSenderAcknowledgement(SentMessageIdList(ids: [messageId])),
      );
    }
  }

  Future<Result<(), ()>> markSentMessagesAcknowledged() async {
    final sentMessages = await api.chat((api) => api.getSentMessageIds()).ok();
    if (sentMessages == null) {
      return const Err(());
    }
    for (final sentMessageId in sentMessages.ids) {
      final currentMessage = await db
          .accountData((db) => db.message.getMessageUsingMessageIdSimple(sentMessageId))
          .ok();

      if (currentMessage == null) {
        // Sent messages are saved to DB before sending, so most likely
        // this message is sent from another device.
        continue;
      }

      final currentBackendSignedPgpMessage = await db
          .accountData((db) => db.message.getBackendSignedPgpMessage(currentMessage.localId))
          .ok();

      if ((currentMessage.messageState.toSentState()?.sendingFailed() ?? false) ||
          currentBackendSignedPgpMessage == null) {
        final r = await api.chat((api) => api.postGetSentMessage(sentMessageId)).ok();
        final base64EncodedMessage = r?.data;
        if (base64EncodedMessage == null) {
          return const Err(());
        }
        final decoded = base64Decode(base64EncodedMessage);
        final backendSignedMessage = await BackendSignedMessage.parseFromSignedPgpMessage(decoded);
        if (backendSignedMessage == null) {
          return const Err(());
        }
        final updateSentState = await db.accountAction(
          (db) => db.message.updateSentMessageState(
            currentMessage.localId,
            sentState: SentMessageState.sent,
            messageIdFromServer: backendSignedMessage.messageId,
            unixTimeFromServer: backendSignedMessage.serverTime,
            backendSignePgpMessage: decoded,
          ),
        );
        if (updateSentState.isErr()) {
          return const Err(());
        }
      }
    }

    final acknowledgeResult = await api.chatAction(
      (api) => api.postAddSenderAcknowledgement(sentMessages),
    );
    if (acknowledgeResult.isErr()) {
      return const Err(());
    }

    allSentMessagesAcknowledgedOnce = true;
    return const Ok(());
  }

  Future<bool> _isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.profile.isInMatches(accountId)).ok() ?? false;
  }
}
