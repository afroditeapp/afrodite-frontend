
import 'dart:convert';
import 'dart:typed_data';

/// Packet type lenght is 1 byte.
enum _MessagePacketType {
  /// Next data is little endian encoded 16 bit unsigned number for
  /// UTF-8 data byte count and after that is the UTF-8 data.
  text(0);

  final int number;
  const _MessagePacketType(this.number);
}

const int _U16_MAX_VALUE = 0xFFFF;

sealed class Message {
  Uint8List toMessagePacket();
  bool isError() => false;

  static Message parseFromBytes(Uint8List bytes) {
    final numberList = bytes.toList();
    if (numberList.length < 3) {
      return UnsupportedMessage(bytes);
    }

    final messageTypeNumber = numberList[0];

    if (messageTypeNumber == _MessagePacketType.text.number) {
      final littleEndianBytes = [
        numberList[1],
        numberList[2],
      ];
      final utf8Lenght = ByteData.sublistView(Uint8List.fromList(littleEndianBytes)).getUint16(0, Endian.little);
      final utf8Text = numberList.skip(3).take(utf8Lenght).toList();
      try {
        final textMessage = TextMessage.create(utf8.decode(utf8Text));
        if (textMessage == null) {
          return UnsupportedMessage(bytes);
        } else {
          return textMessage;
        }
      } on FormatException catch (_)  {
        return UnsupportedMessage(bytes);
      }
    } else {
      return UnsupportedMessage(bytes);
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

    final textLenghtBytes = u16ToLittleEndianBytes(textBytes.length);

    final bytes = [
      _MessagePacketType.text.number,
      ...textLenghtBytes,
      ...textBytes,
    ];

    return Uint8List.fromList(bytes);
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
