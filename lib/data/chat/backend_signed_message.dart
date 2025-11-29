import 'dart:convert';
import 'dart:typed_data';

import 'package:app/utils/iterator.dart';
import 'package:app/utils/result.dart';
import 'package:native_utils/native_utils.dart';
import 'package:openapi/api.dart';

class BackendSignedMessage {
  final AccountId sender;
  final AccountId receiver;
  final MessageId messageId;
  final PublicKeyId senderPublicKeyId;
  final PublicKeyId receiverPublicKeyId;
  final MessageNumber messageNumber;
  final UnixTime serverTime;
  final Uint8List messageFromSender;

  BackendSignedMessage._({
    required this.sender,
    required this.receiver,
    required this.messageId,
    required this.senderPublicKeyId,
    required this.receiverPublicKeyId,
    required this.messageNumber,
    required this.serverTime,
    required this.messageFromSender,
  });

  static Future<BackendSignedMessage?> parseFromSignedPgpMessage(Uint8List uint8List) async {
    final (data, _) = await getMessageContent(uint8List);
    if (data == null) {
      return null;
    }

    return BackendSignedMessage.parse(data);
  }

  static BackendSignedMessage? parse(Iterable<int> data) {
    final iterator = data.iterator;

    final version = parseVersion(iterator).ok();
    final sender = parseAccountId(iterator).ok();
    final receiver = parseAccountId(iterator).ok();
    final messageId = parseMessageId(iterator).ok();
    final senderPublicKeyId = parseMinimalI64(iterator).mapOk((v) => PublicKeyId(id: v)).ok();
    final receiverPublicKeyId = parseMinimalI64(iterator).mapOk((v) => PublicKeyId(id: v)).ok();
    final messageNumber = parseMinimalI64(iterator).mapOk((v) => MessageNumber(mn: v)).ok();
    final serverTime = parseMinimalI64(iterator).mapOk((v) => UnixTime(ut: v)).ok();
    final messageFromSender = iterator.takeAllAsBytes();

    if (version != 1 ||
        sender == null ||
        receiver == null ||
        messageId == null ||
        senderPublicKeyId == null ||
        receiverPublicKeyId == null ||
        messageNumber == null ||
        serverTime == null) {
      return null;
    }

    return BackendSignedMessage._(
      sender: sender,
      receiver: receiver,
      messageId: messageId,
      senderPublicKeyId: senderPublicKeyId,
      receiverPublicKeyId: receiverPublicKeyId,
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

Result<int, ()> parseMinimalI64(Iterator<int> data) {
  final count = data.next();
  final first = data.next();
  if (count == null || first == null) {
    return const Err(());
  }
  if (count == 1) {
    final value = ByteData.view(Uint8List.fromList([first]).buffer).getInt8(0);
    return Ok(value);
  }

  final second = data.next();
  if (second == null) {
    return const Err(());
  }
  if (count == 2) {
    final value = ByteData.view(
      Uint8List.fromList([first, second]).buffer,
    ).getInt16(0, Endian.little);
    return Ok(value);
  }

  final third = data.next();
  final fourth = data.next();
  if (third == null || fourth == null) {
    return const Err(());
  }
  if (count == 4) {
    final list = Uint8List.fromList([first, second, third, fourth]);
    final value = ByteData.view(list.buffer).getInt32(0, Endian.little);
    return Ok(value);
  }

  final fift = data.next();
  final sixth = data.next();
  final sevent = data.next();
  final eight = data.next();
  if (fift == null || sixth == null || sevent == null || eight == null) {
    return const Err(());
  }
  if (count == 8) {
    final list = Uint8List.fromList([first, second, third, fourth, fift, sixth, sevent, eight]);
    final value = ByteData.view(list.buffer).getInt64(0, Endian.little);
    return Ok(value);
  }

  return const Err(());
}
