import 'dart:async';
import 'dart:convert';

import 'package:app/data/chat/backend_signed_message.dart';
import 'package:app/data/chat/message_manager/public_key.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account/client_id_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/api.dart';
import 'package:app/data/chat/message_manager/utils.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';

final log = Logger("SendMessageUtils");

class SendMessageUtils {
  final MessageKeyManager messageKeyManager;
  final ClientIdManager clientIdManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountId currentUser;
  final ProfileRepository profile;

  final PublicKeyUtils publicKeyUtils;

  SendMessageUtils(
    this.messageKeyManager,
    this.clientIdManager,
    this.api,
    this.db,
    this.currentUser,
    this.profile,
  ) : publicKeyUtils = PublicKeyUtils(db, api, currentUser);

  bool allSentMessagesAcknowledgedOnce = false;

  Stream<MessageSendingEvent> sendMessageTo(
    AccountId accountId,
    Message message, {
    bool sendUiEvent = true,
  }) async* {
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

    if (!await _isInConversationList(accountId)) {
      final r = await db.accountAction(
        (db) => db.conversationList.setConversationListVisibility(accountId, true),
      );
      if (r.isErr()) {
        yield const ErrorBeforeMessageSaving();
        return;
      }
    }

    final lastSentMessageResult = await db.accountData(
      (db) => db.message.getLatestSentMessage(currentUser, accountId),
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

    final saveMessageResult = await db.accountDataWrite(
      (db) => db.message.insertToBeSentMessage(currentUser, accountId, message),
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

    final (encryptedMessage, encryptingResult) = encryptMessage(
      currentUserKeys.private.data,
      receiverPublicKey.data,
      message.toMessagePacket(),
    );

    if (encryptedMessage == null) {
      log.error("Message encryption error: $encryptingResult");
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    final updateSymmetricEncryptionKeyResult = await db.accountAction(
      (db) => db.message.updateSymmetricMessageEncryptionKey(localId, encryptedMessage.sessionKey),
    );
    if (updateSymmetricEncryptionKeyResult.isErr()) {
      log.error("Updating symmetric encryption key failed");
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    UnixTime unixTimeFromServer;
    MessageId messageIdFromServer;
    Uint8List backendSignedPgpMessage;
    var messageSenderAcknowledgementTried = false;
    while (true) {
      final result = await api
          .chat(
            (api) => api.postSendMessage(
              currentUserKeys.id.id,
              accountId.aid,
              receiverPublicKey.id.id,
              clientId.id,
              localId.id,
              MultipartFile.fromBytes("", encryptedMessage.pgpMessage),
            ),
          )
          .ok();
      if (result == null) {
        yield ErrorAfterMessageSaving(localId);
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

          log.error("Send message error: too many sender acknowledgements missing");

          final acknowledgeResult = await markSentMessagesAcknowledged(clientId);
          if (acknowledgeResult.isErr()) {
            yield ErrorAfterMessageSaving(localId);
            return;
          }
          continue;
        }
      }

      if (result.errorSenderPublicKeyOutdated) {
        // This should not happen as client sends new public key to server
        // if needed on login.

        log.error("Send message error: sender public key outdated");

        yield ErrorAfterMessageSaving(localId);
        return;
      }

      if (result.errorReceiverPublicKeyOutdated) {
        log.error("Send message error: receiver public key outdated");

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

      final signedPgpMessageBase64 = result.d;
      if (signedPgpMessageBase64 == null) {
        yield ErrorAfterMessageSaving(localId);
        return;
      }

      backendSignedPgpMessage = base64Decode(signedPgpMessageBase64);

      final (backendSignedMessage, getMessageContentResult) = getMessageContent(
        backendSignedPgpMessage,
      );
      if (backendSignedMessage == null) {
        log.error(
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
      break;
    }

    final updateSentState = await db.accountAction(
      (db) => db.message.updateSentMessageState(
        localId,
        sentState: SentMessageState.sent,
        unixTimeFromServer: unixTimeFromServer,
        messageIdFromServer: messageIdFromServer,
        backendSignePgpMessage: backendSignedPgpMessage,
      ),
    );
    if (updateSentState.isErr()) {
      yield ErrorAfterMessageSaving(localId);
      return;
    }

    if (!allSentMessagesAcknowledgedOnce) {
      await markSentMessagesAcknowledged(clientId);
    } else {
      await api.chatAction(
        (api) => api.postAddSenderAcknowledgement(
          SentMessageIdList(
            ids: [
              SentMessageId(
                c: clientId,
                l: ClientLocalId(id: localId.id),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<Result<(), ()>> markSentMessagesAcknowledged(ClientId clientId) async {
    final sentMessages = await api.chat((api) => api.getSentMessageIds()).ok();
    if (sentMessages == null) {
      return const Err(());
    }
    for (final sentMessageId in sentMessages.ids) {
      if (clientId != sentMessageId.c) {
        continue;
      }
      final sentMessageLocalId = sentMessageId.l.toLocalMessageId();
      final currentMessage = await db
          .accountData((db) => db.message.getMessageUsingLocalMessageId(sentMessageLocalId))
          .ok();
      final currentBackendSignedPgpMessage = await db
          .accountData((db) => db.message.getBackendSignedPgpMessage(sentMessageLocalId))
          .ok();
      if (currentMessage?.messageState.toSentState() == SentMessageState.sendingError ||
          currentBackendSignedPgpMessage == null) {
        final r = await api.chat((api) => api.postGetSentMessage(sentMessageId)).ok();
        final base64EncodedMessage = r?.data;
        if (base64EncodedMessage == null) {
          return const Err(());
        }
        final decoded = base64Decode(base64EncodedMessage);
        final backendSignedMessage = BackendSignedMessage.parseFromSignedPgpMessage(decoded);
        if (backendSignedMessage == null) {
          return const Err(());
        }
        final updateSentState = await db.accountAction(
          (db) => db.message.updateSentMessageState(
            sentMessageLocalId,
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

  Future<bool> _isInConversationList(AccountId accountId) async {
    return await db.accountData((db) => db.conversationList.isInConversationList(accountId)).ok() ??
        false;
  }
}
