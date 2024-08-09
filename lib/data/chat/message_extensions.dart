

import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart' show StreamExtensions;
import 'package:database/database.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/message.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/data/chat/message_converter.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/iterator.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("MessageExtensions");

/// Message receiving and sending
extension MessageExtensions on ChatRepository {

  Future<void> receiveNewMessages() async {
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

    final newMessages = parsePendingMessagesResponse(newMessageBytes);
    if (newMessages == null) {
      return;
    }

    final toBeDeleted = <PendingMessageId>[];

    for (final (message, messageBytes) in newMessages) {
      final isMatch = await isInMatches(message.id.accountIdSender);
      if (!isMatch) {
        await db.profileAction((db) => db.setMatchStatus(message.id.accountIdSender, true));
        ProfileRepository.getInstance().sendProfileChange(MatchesChanged());
      }

      // TODO: Store some error state to database
      //       instead of the error text.
      final decryptedMessage = await _decryptReceivedMessage(allKeys, message, messageBytes).ok() ?? "Message decrypting failed";

      final r = await db.messageAction((db) => db.insertPendingMessage(currentUser, message, decryptedMessage));
      if (r.isOk()) {
        toBeDeleted.add(message.id);
        ProfileRepository.getInstance().sendProfileChange(ConversationChanged(message.id.accountIdSender, ConversationChangeType.messageReceived));
        // TODO(prod): Update with correct message count once there is
        // count of not read messages in the database.
        await NotificationMessageReceived.getInstance().updateMessageReceivedCount(message.id.accountIdSender, 1);
      }
    }

    for (final sender in newMessages.map((item) => item.$1.id.accountIdSender).toSet()) {
      await BackgroundDatabaseManager.getInstance().accountAction((db) => db.daoNewMessageNotification.setNotificationShown(sender, false));
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

  List<(PendingMessage, Uint8List)>? parsePendingMessagesResponse(Uint8List bytes) {
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
      final resultSendLike = await api.chatAction((api) => api.postSendLike(accountId));
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
    switch (await _getPublicKeyForForeignAccount(accountId, forceDownload: false)) {
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

    final dataIdentifierAndEncryptedMessage = [0];
    dataIdentifierAndEncryptedMessage.addAll(encryptedMessage);

    final result = await api.chat((api) => api.postSendMessage(
      accountId.accountId,
      receiverPublicKey.id.id,
      receiverPublicKey.version.version,
      MultipartFile.fromBytes("", dataIdentifierAndEncryptedMessage),
    )).ok();
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
      log.error("Send message error: public key outdated");
    }

    // TODO save sent status to local database
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
}
