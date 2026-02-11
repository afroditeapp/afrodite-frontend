import 'dart:async';

import 'package:app/data/chat/backend_signed_message.dart';
import 'package:app/data/chat/message_manager/public_key.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/api.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/iterator.dart';
import 'package:app/utils/result.dart';

final _log = Logger("ReceiveMessgeUtils");

class ReceiveMessageUtils {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountId currentUser;
  final ProfileRepository profile;

  final PublicKeyUtils publicKeyUtils;

  ReceiveMessageUtils(this.messageKeyManager, this.api, this.db, this.currentUser, this.profile)
    : publicKeyUtils = PublicKeyUtils(db, api, currentUser);

  Future<void> receiveNewMessages() async {
    final allKeys = await messageKeyManager.getKeysWhenChatIsEnabled().ok();
    if (allKeys == null) {
      return;
    }
    final newMessageBytes = await api.chat((api) => api.getPendingMessagesFixed()).ok();
    if (newMessageBytes == null) {
      return;
    }

    final notificationHidden = newMessageBytes[0] == 1;

    final newMessages = await _parsePendingMessagesResponse(
      Uint8List.sublistView(newMessageBytes, 1),
    );
    if (newMessages == null) {
      return;
    }

    final toBeAcknowledged = <PendingMessageId>[];
    final toBeAcknowledgedAsFailed = <PendingMessageId>[];

    for (final message in newMessages) {
      final isMatch = await _isInMatches(message.parsed.sender);
      if (!isMatch) {
        await db.accountAction((db) => db.profile.setMatchStatus(message.parsed.sender, true));
      }

      final alreadyExistingMessageResult = await db.accountData(
        (db) =>
            db.message.getMessageUsingMessageId(message.parsed.sender, message.parsed.messageId),
      );
      switch (alreadyExistingMessageResult) {
        case Err():
          return;
        case Ok(v: final alreadyExistingMessage):
          if (alreadyExistingMessage != null) {
            toBeAcknowledged.add(message.parsed.toPendingMessageId());
            continue;
          }
      }

      final Message? decryptedMessage;
      final Uint8List? symmetricMessageEncryptionKey;
      final ReceivedMessageState messageState;
      switch (await decryptReceivedMessage(allKeys, message.parsed)) {
        case Err(:final e):
          decryptedMessage = null;
          symmetricMessageEncryptionKey = null;
          switch (e) {
            case ReceivedMessageError.decryptingFailed:
              messageState = ReceivedMessageState.decryptingFailed;
            case ReceivedMessageError.publicKeyDonwloadingFailed:
              messageState = ReceivedMessageState.publicKeyDownloadFailed;
          }
        case Ok(v: (final message, final symmetricKey)):
          decryptedMessage = message;
          symmetricMessageEncryptionKey = symmetricKey;
          messageState = ReceivedMessageState.received;
      }

      final r = await db.accountAction(
        (db) => db.message.insertReceivedMessage(
          message.parsed.sender,
          message.parsed.messageNumber,
          message.parsed.messageId,
          message.parsed.serverTime.toUtcDateTime(),
          message.backendPgpMessage,
          decryptedMessage,
          symmetricMessageEncryptionKey,
          messageState,
        ),
      );
      if (r.isOk()) {
        final pendingMessageId = message.parsed.toPendingMessageId();
        if (messageState == ReceivedMessageState.decryptingFailed) {
          toBeAcknowledgedAsFailed.add(pendingMessageId);
        } else {
          toBeAcknowledged.add(pendingMessageId);
        }
      }

      ConversationId? conversationId = await db
          .accountData((db) => db.chatUnreadMessagesCount.getConversationId(message.parsed.sender))
          .ok();
      if (conversationId == null) {
        final r = await api.chat((api) => api.getConversationId(message.parsed.sender.aid)).ok();
        conversationId = r?.value;
      }

      final unreadMessagesCount = await db
          .accountDataWrite(
            (db) => db.chatUnreadMessagesCount.incrementUnreadMessagesCount(message.parsed.sender),
          )
          .ok();
      if (unreadMessagesCount != null) {
        profile.sendProfileChange(
          ConversationChanged(message.parsed.sender, ConversationChangeType.messageReceived),
        );
        if (conversationId == null) {
          await NotificationMessageReceived.getInstance().showFallbackMessageReceivedNotification(
            db,
          );
        } else {
          await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
            message.parsed.sender,
            unreadMessagesCount.count,
            conversationId,
            db,
            onlyDbUpdate: notificationHidden,
          );
        }
      }
    }

    for (final sender in newMessages.map((item) => item.parsed.sender).toSet()) {
      await db.accountAction(
        (db) => db.chatUnreadMessagesCount.setNewMessageNotificationShown(sender, false),
      );
    }

    if (toBeAcknowledged.isNotEmpty) {
      final result = await api.chatAction(
        (api) => api.postAddReceiverAcknowledgement(
          PendingMessageAcknowledgementList(ids: toBeAcknowledged),
        ),
      );
      if (result.isErr()) {
        _log.error("Receive messages: acknowledging the server failed");
      }
    }

    if (toBeAcknowledgedAsFailed.isNotEmpty) {
      final result = await api.chatAction(
        (api) => api.postAddReceiverAcknowledgement(
          PendingMessageAcknowledgementList(ids: toBeAcknowledgedAsFailed, deliveryFailed: true),
        ),
      );
      if (result.isErr()) {
        _log.error("Receive messages: acknowledging failed delivery to the server failed");
      }
    }
  }

  Future<List<PendingMessageData>?> _parsePendingMessagesResponse(Uint8List bytes) async {
    final bytesIterator = bytes.iterator;
    final List<PendingMessageData> parsedData = [];
    if (bytes.isEmpty) {
      return parsedData;
    }

    while (true) {
      final count = parseMinimalI64(bytesIterator).ok();
      if (count == null) {
        return parsedData;
      }
      final signedPgpMessage = bytesIterator.takeAndAdvance(count);
      if (signedPgpMessage == null) {
        return null;
      }
      final signedPgpMessageUint8 = Uint8List.fromList(signedPgpMessage);

      final parsed = await BackendSignedMessage.parseFromSignedPgpMessage(signedPgpMessageUint8);
      if (parsed == null) {
        return null;
      }

      parsedData.add(PendingMessageData(parsed, signedPgpMessageUint8));
    }
  }

  /// Returns message and symmetric message encryption key
  Future<Result<(Message, Uint8List), ReceivedMessageError>> decryptReceivedMessage(
    AllKeyData allKeys,
    BackendSignedMessage message,
  ) async {
    final publicKey = await publicKeyUtils
        .getSpecificPublicKeyForForeignAccount(message.sender, message.senderPublicKeyId)
        .ok();
    if (publicKey == null) {
      return const Err(ReceivedMessageError.publicKeyDonwloadingFailed);
    }

    final (decryptResult, decryptingResult) = await decryptMessage(
      publicKey.data,
      allKeys.private.data,
      message.messageFromSender,
    );

    if (decryptResult == null) {
      _log.error("Received message decrypting failed, error: $decryptingResult");
      return const Err(ReceivedMessageError.decryptingFailed);
    }

    return Ok((Message.parseFromBytes(decryptResult.messageData), decryptResult.sessionKey));
  }

  Future<bool> _isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.profile.isInMatches(accountId)).ok() ?? false;
  }
}

enum ReceivedMessageError { decryptingFailed, publicKeyDonwloadingFailed }

class PendingMessageData {
  final BackendSignedMessage parsed;
  final Uint8List backendPgpMessage;

  PendingMessageData(this.parsed, this.backendPgpMessage);
}
