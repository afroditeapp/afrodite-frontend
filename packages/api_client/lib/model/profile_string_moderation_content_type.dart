//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProfileStringModerationContentType {
  profileName._(r'ProfileName'),
  profileText._(r'ProfileText'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProfileStringModerationContentType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProfileStringModerationContentType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProfileStringModerationContentType? fromJson(dynamic value) => ProfileStringModerationContentTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProfileStringModerationContentType]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProfileStringModerationContentType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringModerationContentType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringModerationContentType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileStringModerationContentType] to String,
/// and [decode] dynamic data back to [ProfileStringModerationContentType].
class ProfileStringModerationContentTypeTypeTransformer {
  factory ProfileStringModerationContentTypeTypeTransformer() => _instance ??= const ProfileStringModerationContentTypeTypeTransformer._();

  const ProfileStringModerationContentTypeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProfileStringModerationContentType data) => data._value;

  /// Returns the instance of [ProfileStringModerationContentType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStringModerationContentType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProfileStringModerationContentType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ProfileName': return ProfileStringModerationContentType.profileName;
        case r'ProfileText': return ProfileStringModerationContentType.profileText;
        case r'unknown_default_open_api': return ProfileStringModerationContentType.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProfileStringModerationContentTypeTypeTransformer? _instance;
}

