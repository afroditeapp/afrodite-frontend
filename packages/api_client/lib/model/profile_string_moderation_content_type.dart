//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileStringModerationContentType {
  /// Instantiate a new enum with the provided [value].
  const ProfileStringModerationContentType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const profileName = ProfileStringModerationContentType._(r'ProfileName');
  static const profileText = ProfileStringModerationContentType._(r'ProfileText');

  /// List of all possible values in this [enum][ProfileStringModerationContentType].
  static const values = <ProfileStringModerationContentType>[
    profileName,
    profileText,
  ];

  static ProfileStringModerationContentType? fromJson(dynamic value) => ProfileStringModerationContentTypeTypeTransformer().decode(value);

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

  String encode(ProfileStringModerationContentType data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileStringModerationContentType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStringModerationContentType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ProfileName': return ProfileStringModerationContentType.profileName;
        case r'ProfileText': return ProfileStringModerationContentType.profileText;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileStringModerationContentTypeTypeTransformer] instance.
  static ProfileStringModerationContentTypeTypeTransformer? _instance;
}

