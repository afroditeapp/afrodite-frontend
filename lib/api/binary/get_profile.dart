import 'dart:convert';
import 'dart:typed_data';

import 'package:app/api/binary/utils.dart';
import 'package:openapi/api.dart';

const int _variantEmpty = 0;
const int _variantVersionOnly = 1;
const int _variantProfileWithVersion = 2;

GetProfileResult? parseGetProfileBinary(Uint8List bytes) {
  try {
    final reader = ByteReader(bytes);
    final variant = reader.readU8();
    if (variant == null) {
      return null;
    }

    switch (variant) {
      case _variantEmpty:
        return GetProfileResult();
      case _variantVersionOnly:
        final versionBytes = reader.readBytes(16);
        final lastSeenTimeMarker = reader.readU8();
        if (lastSeenTimeMarker == null) return null;
        final int? lastSeenTime;
        if (lastSeenTimeMarker == 0) {
          lastSeenTime = null;
        } else {
          lastSeenTime = reader.readMinimalI64WithKnownByteCount(lastSeenTimeMarker);
          if (lastSeenTime == null) return null;
        }
        if (versionBytes == null) {
          return null;
        }
        return GetProfileResult(
          profileVersion: ProfileVersion(v: toIdString(versionBytes)),
          lastSeenTime: lastSeenTime,
        );
      case _variantProfileWithVersion:
        final versionBytes = reader.readBytes(16);
        final lastSeenTimeMarker = reader.readU8();
        if (lastSeenTimeMarker == null) return null;
        final int? lastSeenTime;
        if (lastSeenTimeMarker == 0) {
          lastSeenTime = null;
        } else {
          lastSeenTime = reader.readMinimalI64WithKnownByteCount(lastSeenTimeMarker);
          if (lastSeenTime == null) return null;
        }
        final profile = _readProfile(reader);
        if (versionBytes == null || profile == null) {
          return null;
        }
        return GetProfileResult(
          profileVersion: ProfileVersion(v: toIdString(versionBytes)),
          lastSeenTime: lastSeenTime,
          profile: profile,
        );
      default:
        return null;
    }
  } on FormatException {
    return null;
  }
}

Profile? _readProfile(ByteReader reader) {
  final nameLength = reader.readU8();
  if (nameLength == null) {
    return null;
  }
  String? name;
  if (nameLength > 0) {
    final nameBytes = reader.readBytes(nameLength);
    if (nameBytes == null) {
      return null;
    }
    name = utf8.decode(nameBytes);
  }

  final profileTextLength = reader.readU16LE();
  if (profileTextLength == null) {
    return null;
  }
  String? profileText;
  if (profileTextLength > 0) {
    final profileTextBytes = reader.readBytes(profileTextLength);
    if (profileTextBytes == null) {
      return null;
    }
    profileText = utf8.decode(profileTextBytes);
  }

  final age = reader.readU8();
  final attributeCount = reader.readU16LE();
  if (age == null || attributeCount == null) {
    return null;
  }

  final attributes = <ProfileAttributeValue>[];
  for (var i = 0; i < attributeCount; i++) {
    final packedAttributeId = reader.readU16LE();
    final valueCount = reader.readU8();
    if (packedAttributeId == null || valueCount == null) {
      return null;
    }

    final useU32Values = (packedAttributeId & 0x8000) != 0;
    final attributeId = packedAttributeId & 0x7FFF;
    final values = <int>[];
    for (var j = 0; j < valueCount; j++) {
      final value = useU32Values ? reader.readU32LE() : reader.readU16LE();
      if (value == null) {
        return null;
      }
      values.add(value);
    }

    attributes.add(ProfileAttributeValue(id: attributeId, v: values));
  }

  final profileFlags = reader.readU8();
  final verificationStatus = reader.readI16LE();
  if (profileFlags == null || verificationStatus == null) {
    return null;
  }
  if ((profileFlags & 0xF8) != 0) {
    return null;
  }

  return Profile(
    age: age,
    attributes: attributes,
    name: name,
    unlimitedLikes: (profileFlags & 0x01) != 0,
    nameAccepted: (profileFlags & 0x02) != 0,
    ptext: profileText,
    ptextAccepted: (profileFlags & 0x04) != 0,
    verificationStatus: ProfileVerificationStatus(v: verificationStatus),
  );
}
