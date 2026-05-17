import 'dart:convert';
import 'dart:typed_data';

import 'package:app/utils/iterator.dart';
import 'package:app/utils/minimal_i64.dart';
import 'package:app/utils/result.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';

class ServerSignedMessage {
  final AccountId sender;
  final AccountId recipient;
  final MessageId messageId;
  final PublicKeyId senderPublicKeyId;
  final PublicKeyId recipientPublicKeyId;
  final MessageNumber messageNumber;
  final UnixTime serverTime;
  final Uint8List messageFromSender;

  ServerSignedMessage._({
    required this.sender,
    required this.recipient,
    required this.messageId,
    required this.senderPublicKeyId,
    required this.recipientPublicKeyId,
    required this.messageNumber,
    required this.serverTime,
    required this.messageFromSender,
  });

  static Future<ServerSignedMessage?> parseFromSignedPgpMessage(Uint8List uint8List) async {
    final (data, _) = await getMessageContent(uint8List);
    if (data == null) {
      return null;
    }

    return ServerSignedMessage.parse(data);
  }

  static ServerSignedMessage? parse(Iterable<int> data) {
    final iterator = data.iterator;

    final version = parseVersion(iterator).ok();
    final sender = parseAccountId(iterator).ok();
    final recipient = parseAccountId(iterator).ok();
    final messageId = parseMessageId(iterator).ok();
    final senderPublicKeyId = _parseMinimalI64(iterator).mapOk((v) => PublicKeyId(id: v)).ok();
    final recipientPublicKeyId = _parseMinimalI64(iterator).mapOk((v) => PublicKeyId(id: v)).ok();
    final messageNumber = _parseMinimalI64(iterator).mapOk((v) => MessageNumber(mn: v)).ok();
    final serverTime = _parseMinimalI64(iterator).mapOk((v) => UnixTime(ut: v)).ok();
    final messageFromSender = iterator.takeAllAsBytes();

    if (version != 1 ||
        sender == null ||
        recipient == null ||
        messageId == null ||
        senderPublicKeyId == null ||
        recipientPublicKeyId == null ||
        messageNumber == null ||
        serverTime == null) {
      return null;
    }

    return ServerSignedMessage._(
      sender: sender,
      recipient: recipient,
      messageId: messageId,
      senderPublicKeyId: senderPublicKeyId,
      recipientPublicKeyId: recipientPublicKeyId,
      messageNumber: messageNumber,
      serverTime: serverTime,
      messageFromSender: messageFromSender,
    );
  }

  PendingMessageId toPendingMessageId() => PendingMessageId(sender: sender, id: messageId);
}

Result<int, ()> parseVersion(Iterator<int> data) {
  final first = data.next();
  if (first == null) {
    return const Err(());
  }
  final value = ByteData.view(Uint8List.fromList([first]).buffer).getInt8(0);
  return Ok(value);
}

Result<AccountId, ()> parseAccountId(Iterator<int> data) {
  final uuidBytes = data.takeAndAdvance(16);
  if (uuidBytes == null) {
    return const Err(());
  }
  final base64UrlsNoPadding = base64UrlEncode(uuidBytes).replaceAll("=", "");
  return Ok(AccountId(aid: base64UrlsNoPadding));
}

Result<MessageId, ()> parseMessageId(Iterator<int> data) {
  final uuidBytes = data.takeAndAdvance(16);
  if (uuidBytes == null) {
    return const Err(());
  }
  final base64UrlsNoPadding = base64UrlEncode(uuidBytes).replaceAll("=", "");
  return Ok(MessageId(id: base64UrlsNoPadding));
}

Result<int, ()> _parseMinimalI64(Iterator<int> data) {
  final value = decodeMinimalI64FromIterator(data);
  if (value == null) {
    return const Err(());
  }
  return Ok(value);
}
