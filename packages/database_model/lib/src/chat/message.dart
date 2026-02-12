import 'dart:convert';
import 'dart:typed_data';

import 'package:openapi/api.dart';

/// Packet type length is 1 byte.
enum _MessagePacketType {
  /// Next data is little endian encoded 16 bit unsigned number for
  /// UTF-8 data byte count and after that is the UTF-8 data.
  text(0),
  videoCallInvitation(1),

  /// Text message with reference to another message.
  /// Next data is little endian encoded 16 bit unsigned number for
  /// UTF-8 text byte count, then UTF-8 text data, then referenced message ID as UTF-8 string.
  messageWithReference(2),

  /// Message that was resent.
  /// Next data is 8 bytes for message number (i64), then 8 bytes for sent unix time (i64),
  /// then 1 byte for message ID length, then message ID bytes, and finally the original message bytes.
  resentMessage(3);

  final int number;
  const _MessagePacketType(this.number);
}

const int _U16_MAX_VALUE = 0xFFFF;

sealed class Message {
  Uint8List toMessagePacket();
  bool isError() => false;

  static Message parseFromBytes(Uint8List bytes) {
    final numberList = bytes.toList();
    if (numberList.isEmpty) {
      return UnsupportedMessage(bytes);
    }

    final messageTypeNumber = numberList[0];

    if (messageTypeNumber == _MessagePacketType.text.number) {
      if (numberList.length < 3) {
        return UnsupportedMessage(bytes);
      }
      final littleEndianBytes = [numberList[1], numberList[2]];
      final utf8Length = ByteData.sublistView(
        Uint8List.fromList(littleEndianBytes),
      ).getUint16(0, Endian.little);
      final utf8Text = numberList.skip(3).take(utf8Length).toList();
      try {
        final textMessage = TextMessage.create(utf8.decode(utf8Text));
        if (textMessage == null) {
          return UnsupportedMessage(bytes);
        } else {
          return textMessage;
        }
      } on FormatException catch (_) {
        return UnsupportedMessage(bytes);
      }
    } else if (messageTypeNumber == _MessagePacketType.videoCallInvitation.number) {
      return VideoCallInvitation();
    } else if (messageTypeNumber == _MessagePacketType.messageWithReference.number) {
      if (numberList.length < 3) {
        return UnsupportedMessage(bytes);
      }
      final littleEndianBytes = [numberList[1], numberList[2]];
      final utf8Length = ByteData.sublistView(
        Uint8List.fromList(littleEndianBytes),
      ).getUint16(0, Endian.little);
      if (numberList.length < 3 + utf8Length) {
        return UnsupportedMessage(bytes);
      }
      final utf8Text = numberList.skip(3).take(utf8Length).toList();
      final messageIdBytes = numberList.skip(3 + utf8Length).toList();
      try {
        final text = utf8.decode(utf8Text);
        final messageId = utf8.decode(messageIdBytes);
        final messageWithReference = MessageWithReference.create(text, messageId);
        if (messageWithReference == null) {
          return UnsupportedMessage(bytes);
        } else {
          return messageWithReference;
        }
      } on FormatException catch (_) {
        return UnsupportedMessage(bytes);
      }
    } else if (messageTypeNumber == _MessagePacketType.resentMessage.number) {
      if (numberList.length < 18) {
        return UnsupportedMessage(bytes);
      }
      final data = ByteData.sublistView(bytes, 1, 17);
      final messageNumber = MessageNumber(mn: data.getInt64(0, Endian.little));
      final sentUnixTime = UnixTime(ut: data.getInt64(8, Endian.little));
      final messageIdLength = numberList[17];
      if (numberList.length < 18 + messageIdLength) {
        return UnsupportedMessage(bytes);
      }
      final MessageId messageId;
      try {
        final messageIdBytes = numberList.skip(18).take(messageIdLength).toList();
        messageId = MessageId(id: utf8.decode(messageIdBytes));
      } on FormatException catch (_) {
        return UnsupportedMessage(bytes);
      }
      final originalMessageBytes = numberList.skip(18 + messageIdLength).toList();
      final originalMessage = Message.parseFromBytes(Uint8List.fromList(originalMessageBytes));
      return ResentMessage(originalMessage, messageNumber, messageId, sentUnixTime);
    } else {
      return UnsupportedMessage(bytes);
    }
  }

  Message removeResentMessages() {
    var currentMessage = this;
    while (true) {
      final current = currentMessage;
      if (current is ResentMessage) {
        currentMessage = current.message;
      } else {
        return currentMessage;
      }
    }
  }
}

class TextMessage extends Message {
  final String text;
  TextMessage._(this.text);

  /// Returns null if text byte count is too large
  static TextMessage? create(String text) {
    final textBytes = utf8.encode(text);
    if (textBytes.length > _U16_MAX_VALUE) {
      return null;
    }
    return TextMessage._(text);
  }

  @override
  Uint8List toMessagePacket() {
    final textBytes = utf8.encode(text);

    final textLengthBytes = u16ToLittleEndianBytes(textBytes.length);

    final bytes = [_MessagePacketType.text.number, ...textLengthBytes, ...textBytes];

    return Uint8List.fromList(bytes);
  }
}

class VideoCallInvitation extends Message {
  @override
  Uint8List toMessagePacket() {
    return Uint8List.fromList([_MessagePacketType.videoCallInvitation.number]);
  }
}

class MessageWithReference extends Message {
  final String text;
  final String messageId;
  MessageWithReference._(this.text, this.messageId);

  /// Returns null if text byte count is too large
  static MessageWithReference? create(String text, String messageId) {
    final textBytes = utf8.encode(text);
    if (textBytes.length > _U16_MAX_VALUE) {
      return null;
    }
    return MessageWithReference._(text, messageId);
  }

  @override
  Uint8List toMessagePacket() {
    final textBytes = utf8.encode(text);
    final messageIdBytes = utf8.encode(messageId);

    final textLengthBytes = u16ToLittleEndianBytes(textBytes.length);

    final bytes = [
      _MessagePacketType.messageWithReference.number,
      ...textLengthBytes,
      ...textBytes,
      ...messageIdBytes,
    ];

    return Uint8List.fromList(bytes);
  }
}

class ResentMessage extends Message {
  final Message message;
  final MessageNumber messageNumber;
  final MessageId messageId;
  final UnixTime sentUnixTime;
  ResentMessage(this.message, this.messageNumber, this.messageId, this.sentUnixTime);

  @override
  Uint8List toMessagePacket() {
    final originalBytes = message.toMessagePacket();
    final messageIdBytes = utf8.encode(messageId.id);

    final builder = BytesBuilder();
    builder.addByte(_MessagePacketType.resentMessage.number);

    final data = ByteData(16);
    data.setInt64(0, messageNumber.mn, Endian.little);
    data.setInt64(8, sentUnixTime.ut, Endian.little);
    builder.add(data.buffer.asUint8List());

    builder.addByte(messageIdBytes.length);
    builder.add(messageIdBytes);

    builder.add(originalBytes);

    return builder.toBytes();
  }
}

class UnsupportedMessage extends Message {
  final Uint8List messageBytes;
  UnsupportedMessage(this.messageBytes);

  @override
  Uint8List toMessagePacket() => messageBytes;

  @override
  bool isError() => true;
}

/// Throws ArgumentError exception if version is too large.
Uint8List u16ToLittleEndianBytes(int version) {
  final buffer = ByteData(2);
  if (version < 0 || version > _U16_MAX_VALUE) {
    throw ArgumentError("Version must be 16 bit integer");
  }
  buffer.setUint16(0, version, Endian.little);
  return buffer.buffer.asUint8List();
}
