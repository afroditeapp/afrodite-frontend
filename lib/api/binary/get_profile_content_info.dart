import 'dart:typed_data';

import 'package:app/api/binary/utils.dart';
import 'package:openapi/api.dart';

const int _variantEmpty = 0;
const int _variantVersionOnly = 1;
const int _variantContentWithVersion = 2;

GetProfileContentResult? parseGetProfileContentInfoBinary(Uint8List bytes) {
  final reader = ByteReader(bytes);
  final variant = reader.readU8();
  if (variant == null) {
    return null;
  }

  switch (variant) {
    case _variantEmpty:
      return GetProfileContentResult();
    case _variantVersionOnly:
      final versionBytes = reader.readBytes(16);
      if (versionBytes == null) {
        return null;
      }
      return GetProfileContentResult(version: ProfileContentVersion(v: toIdString(versionBytes)));
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
      if (gridCropSize == null || gridCropX == null || gridCropY == null) {
        return null;
      }

      return GetProfileContentResult(
        version: ProfileContentVersion(v: toIdString(versionBytes)),
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
    cid: ContentId(cid: toIdString(contentIdBytes)),
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
