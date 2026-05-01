import 'dart:convert';
import 'dart:typed_data';

import 'package:openapi/api.dart';

const int _variantEmpty = 0;
const int _variantVersionOnly = 1;
const int _variantContentWithVersion = 2;

GetProfileContentResult? parseGetProfileContentInfoBinary(Uint8List bytes) {
  final reader = _ByteReader(bytes);
  final variant = reader.readU8();
  if (variant == null) {
    return null;
  }

  switch (variant) {
    case _variantEmpty:
      return reader.isAtEnd ? GetProfileContentResult() : null;
    case _variantVersionOnly:
      final versionBytes = reader.readBytes(16);
      if (versionBytes == null || !reader.isAtEnd) {
        return null;
      }
      return GetProfileContentResult(version: ProfileContentVersion(v: _toIdString(versionBytes)));
    case _variantContentWithVersion:
      final versionBytes = reader.readBytes(16);
      final verificationStatus = reader.readU8();
      final contentCount = reader.readU8();
      if (versionBytes == null || verificationStatus == null || contentCount == null) {
        return null;
      }
      if (contentCount > 6) {
        return null;
      }

      final content = <ContentInfo>[];
      for (var i = 0; i < contentCount; i++) {
        final contentIdBytes = reader.readBytes(16);
        final packedInfo = reader.readU8();
        if (contentIdBytes == null || packedInfo == null) {
          return null;
        }
        final parsedContent = _parseContentInfo(contentIdBytes, packedInfo);
        if (parsedContent == null) {
          return null;
        }
        content.add(parsedContent);
      }

      final gridCropSize = reader.readF32LE();
      final gridCropX = reader.readF32LE();
      final gridCropY = reader.readF32LE();
      if (gridCropSize == null || gridCropX == null || gridCropY == null || !reader.isAtEnd) {
        return null;
      }

      return GetProfileContentResult(
        version: ProfileContentVersion(v: _toIdString(versionBytes)),
        content: ProfileContent(
          content: content,
          verificationStatus: MediaVerificationStatus(v: verificationStatus),
          gridCropSize: gridCropSize,
          gridCropX: gridCropX,
          gridCropY: gridCropY,
        ),
      );
    default:
      return null;
  }
}

ContentInfo? _parseContentInfo(Uint8List contentIdBytes, int packedInfo) {
  final faceVerifiedBits = packedInfo & 0x07;
  bool? faceVerified;
  switch (faceVerifiedBits) {
    case 0:
      faceVerified = null;
    case 1:
      faceVerified = false;
    case 2:
      faceVerified = true;
    default:
      return null;
  }

  final faceDetected = (packedInfo & 0x08) != 0;
  final accepted = (packedInfo & 0x10) != 0;
  final mediaTypeBits = (packedInfo >> 5) & 0x07;
  final ctype = _parseMediaContentType(mediaTypeBits);

  return ContentInfo(
    cid: ContentId(cid: _toIdString(contentIdBytes)),
    ctype: ctype,
    accepted: accepted,
    faceDetected: faceDetected,
    faceVerified: faceVerified,
  );
}

MediaContentType? _parseMediaContentType(int value) {
  return switch (value) {
    0 => MediaContentType.jpegImage,
    _ => null,
  };
}

String _toIdString(Uint8List value) {
  return base64UrlEncode(value).replaceAll('=', '');
}

class _ByteReader {
  final Uint8List _bytes;
  int _offset = 0;

  _ByteReader(this._bytes);

  bool get isAtEnd => _offset == _bytes.length;

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
}
