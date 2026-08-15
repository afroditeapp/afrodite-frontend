import 'dart:typed_data';

import 'package:app/utils/iterator.dart';

const _powTwo32 = 0x100000000;

Uint8List encodeMinimalI64(int value) {
  final bytes = ByteData(8);

  // Write the value as two 32-bit values as dart2js doesn't support setInt64.
  // Note that arithmetic is required here as JS bitwise and shift operators
  // truncate operands to 32-bit values.
  final low = value % _powTwo32;
  final valueWithoutLowBits = value - low;
  final high = valueWithoutLowBits ~/ _powTwo32;
  bytes.setUint32(0, low, Endian.little);
  bytes.setInt32(4, high, Endian.little);

  var marker = 8;
  while (marker > 1) {
    final nextMsb = bytes.getUint8(marker - 2);
    final signExtension = (nextMsb & 0x80) == 0 ? 0x00 : 0xFF;
    if (bytes.getUint8(marker - 1) == signExtension) {
      marker -= 1;
    } else {
      break;
    }
  }

  final payload = Uint8List(1 + marker);
  payload[0] = marker;
  for (var i = 0; i < marker; i++) {
    payload[i + 1] = bytes.getUint8(i);
  }

  return payload;
}

/// The [bytes] is bytes after minimal i64 byte count byte.
int? decodeMinimalI64FromBytes(Uint8List bytes) {
  final byteCount = bytes.length;
  if (byteCount > 8) {
    return null;
  }

  if (byteCount == 0) {
    return 0;
  }

  final padded = Uint8List(8);
  padded.setRange(0, byteCount, bytes);
  if ((bytes[byteCount - 1] & 0x80) != 0) {
    padded.fillRange(byteCount, 8, 0xFF);
  }

  // Reconstruct the i64 from its 32-bit halves as dart2js doesn't support
  // getInt64. Note that arithmetic is required here as JS bitwise and
  // shift operators truncate operands to 32-bit values.
  final data = ByteData.sublistView(padded);
  final low = data.getUint32(0, Endian.little);
  final high = data.getInt32(4, Endian.little);
  return high * _powTwo32 + low;
}

/// The next iterator output must be minimal i64 byte count and bytes (0-8 bytes)
int? decodeMinimalI64FromIterator(Iterator<int> data) {
  final byteCount = data.next();
  if (byteCount == null || byteCount < 0 || byteCount > 8) {
    return null;
  }

  if (byteCount == 0) {
    return 0;
  }

  final bytes = Uint8List(byteCount);
  for (var i = 0; i < byteCount; i++) {
    final current = data.next();
    if (current == null) {
      return null;
    }
    bytes[i] = current;
  }

  return decodeMinimalI64FromBytes(bytes);
}
