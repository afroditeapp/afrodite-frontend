


import 'dart:convert';
import 'dart:typed_data';

import 'package:pihka_frontend/api/server_connection.dart';
import 'package:pihka_frontend/utils/result.dart';

/// Packet type lenght is 1 byte.
enum MessagePacketType {
  /// Next data is little endian encoded 16 bit unsigned number for
  /// UTF-8 data byte count and after that is the UTF-8 data.
  text(0);

  final int number;
  const MessagePacketType(this.number);
}

const int U16_MAX_VALUE = 0xFFFF;

class MessageConverter {

  Result<Uint8List, MessageTooLarge> textToBytes(String message) {
    final textBytes = utf8.encode(message);
    if (textBytes.length > U16_MAX_VALUE) {
      return const Err(MessageTooLarge());
    }
    final textLenghtBytes = u16VersionToLittleEndianBytes(textBytes.length);

    final bytes = [
      MessagePacketType.text.number,
      ...textLenghtBytes,
      ...textBytes,
    ];

    return Ok(Uint8List.fromList(bytes));
  }

  Result<String, void> bytesToText(Uint8List bytes) {
    final numberList = bytes.toList();
    if (numberList.length < 3) {
      return const Err(null);
    }

    if (numberList[0] != MessagePacketType.text.number) {
      return const Err(null);
    }

    final littleEndianBytes = [
      numberList[1],
      numberList[2],
    ];
    final utf8Lenght = ByteData.sublistView(Uint8List.fromList(littleEndianBytes)).getUint16(0, Endian.little);

    final utf8Text = numberList.skip(3).take(utf8Lenght).toList();
    try {
      return Ok(utf8.decode(utf8Text));
    } on FormatException catch (_)  {
      return const Err(null);
    }
  }
}

class MessageTooLarge {
  const MessageTooLarge();
}
