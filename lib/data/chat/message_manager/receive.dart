import 'dart:async';

import 'package:app/data/chat/backend_signed_message.dart';
import 'package:app/data/chat/message_manager/public_key.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/chat/message_key_generator.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/utils/api.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/iterator.dart';
import 'package:app/utils/result.dart';

final log = Logger("ReceiveMessgeUtils");

class ReceiveMessageUtils {
  final MessageKeyManager messageKeyManager;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;
  final AccountId currentUser;
  final ProfileRepository profile;

  final PublicKeyUtils publicKeyUtils;

  ReceiveMessageUtils(this.messageKeyManager, this.api, this.db, this.accountBackgroundDb, this.currentUser, this.profile) :
    publicKeyUtils = PublicKeyUtils(db, api, currentUser);

  Future<void> receiveNewMessages() async {
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

    for (final message in newMessages) {
      final isMatch = await _isInMatches(message.parsed.sender);
      if (!isMatch) {
        await db.accountAction((db) => db.daoProfileStates.setMatchStatus(message.parsed.sender, true));
      }

      if (!await _isInConversationList(message.parsed.sender)) {
        await db.accountAction((db) => db.daoConversationList.setConversationListVisibility(message.parsed.sender, true));
      }

      final alreadyExistingMessageResult = await db.messageData((db) => db.getMessageUsingMessageId(
        currentUser,
        message.parsed.sender,
        message.parsed.messageId
      ));
      switch (alreadyExistingMessageResult) {
        case Err():
          return;
        case Ok(v: final alreadyExistingMessage):
          if (alreadyExistingMessage != null) {
            toBeDeleted.add(message.parsed.toPendingMessageId());
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

      final r = await db.messageAction((db) => db.insertReceivedMessage(
        currentUser,
        message.parsed.sender,
        message.parsed.messageId,
        message.parsed.serverTime.toUtcDateTime(),
        message.backendPgpMessage,
        decryptedMessage,
        symmetricMessageEncryptionKey,
        messageState,
      ));
      if (r.isOk()) {
        toBeDeleted.add(message.parsed.toPendingMessageId());
      }

      ConversationId? conversationId = await accountBackgroundDb.accountData((db) => db.daoNewMessageNotificationTable.getConversationId(message.parsed.sender)).ok();
      if (conversationId == null) {
        final r = await api.chat((api) => api.getConversationId(message.parsed.sender.aid)).ok();
        conversationId = r?.value;
      }

      final unreadMessagesCount = await accountBackgroundDb.accountData((db) => db.daoConversationsBackground.incrementUnreadMessagesCount(message.parsed.sender)).ok();
      if (unreadMessagesCount != null) {
        profile.sendProfileChange(ConversationChanged(message.parsed.sender, ConversationChangeType.messageReceived));
        if (conversationId == null) {
          await NotificationMessageReceived.getInstance().showFallbackMessageReceivedNotification(accountBackgroundDb);
        } else {
          await NotificationMessageReceived.getInstance().updateMessageReceivedCount(message.parsed.sender, unreadMessagesCount.count, conversationId, accountBackgroundDb);
        }
      }
    }

    for (final sender in newMessages.map((item) => item.parsed.sender).toSet()) {
      await accountBackgroundDb.accountAction((db) => db.daoNewMessageNotificationTable.setNotificationShown(sender, false));
    }

    final toBeAcknowledgedList = PendingMessageAcknowledgementList(ids: toBeDeleted);
    final result = await api.chatAction((api) => api.postAddReceiverAcknowledgement(toBeAcknowledgedList));
    if (result.isErr()) {
      log.error("Receive messages: acknowleding the server failed");
    }
  }

  List<PendingMessageData>? _parsePendingMessagesResponse(Uint8List bytes) {
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

      final parsed = BackendSignedMessage.parseFromSignedPgpMessage(signedPgpMessageUint8);
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
    final publicKey = await publicKeyUtils.getSpecificPublicKeyForForeignAccount(message.sender, message.senderPublicKeyId).ok();
    if (publicKey == null) {
      return const Err(ReceivedMessageError.publicKeyDonwloadingFailed);
    }

    final (decryptResult, decryptingResult) = decryptMessage(
      publicKey.data,
      allKeys.private.data,
      message.messageFromSender,
    );

    if (decryptResult == null) {
      log.error("Received message decrypting failed, error: $decryptingResult");
      return const Err(ReceivedMessageError.decryptingFailed);
    }

    return Ok((Message.parseFromBytes(decryptResult.messageData), decryptResult.sessionKey));
  }

  Future<bool> _isInMatches(AccountId accountId) async {
    return await db.accountData((db) => db.daoProfileStates.isInMatches(accountId)).ok() ?? false;
  }

  Future<bool> _isInConversationList(AccountId accountId) async {
    return await db.accountData((db) => db.daoConversationList.isInConversationList(accountId)).ok() ?? false;
  }
}

enum ReceivedMessageError {
  decryptingFailed,
  publicKeyDonwloadingFailed,
}

class PendingMessageData {
  final BackendSignedMessage parsed;
  final Uint8List backendPgpMessage;

  PendingMessageData(this.parsed, this.backendPgpMessage);
}
