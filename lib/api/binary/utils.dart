import 'dart:convert';
import 'dart:typed_data';

import 'package:app/utils/minimal_i64.dart';

class ByteReader {
  final Uint8List _bytes;
  int _offset = 0;

  ByteReader(this._bytes);

  int? readU8() {
    if (_offset >= _bytes.length) {
      return null;
    }
    return _bytes[_offset++];
  }

  Uint8List? readBytes(int length) {
    if (length < 0 || _offset + length > _bytes.length) {
      return null;
    }
    final result = Uint8List.sublistView(_bytes, _offset, _offset + length);
    _offset += length;
    return result;
  }

  double? readF32LE() {
    final value = readBytes(4);
    if (value == null) {
      return null;
    }
    return ByteData.sublistView(value).getFloat32(0, Endian.little);
  }

  int? readU16LE() {
    final value = readBytes(2);
    if (value == null) {
      return null;
    }
    return ByteData.sublistView(value).getUint16(0, Endian.little);
  }

  int? readU32LE() {
    final value = readBytes(4);
    if (value == null) {
      return null;
    }
    return ByteData.sublistView(value).getUint32(0, Endian.little);
  }

  int? readI16LE() {
    final value = readBytes(2);
    if (value == null) {
      return null;
    }
    return ByteData.sublistView(value).getInt16(0, Endian.little);
  }

  int? readMinimalI64WithKnownByteCount(int byteCount) {
    final dataBytes = readBytes(byteCount);
    if (dataBytes == null) {
      return null;
    }

    return decodeMinimalI64FromBytes(dataBytes);
  }
}

String toIdString(Uint8List value) {
  return base64UrlEncode(value).replaceAll('=', '');
}
