//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileVisibility {
  /// Instantiate a new enum with the provided [value].
  const ProfileVisibility._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const pendingPrivate = ProfileVisibility._(r'PendingPrivate');
  static const pendingPublic = ProfileVisibility._(r'PendingPublic');
  static const private = ProfileVisibility._(r'Private');
  static const public = ProfileVisibility._(r'Public');

  /// List of all possible values in this [enum][ProfileVisibility].
  static const values = <ProfileVisibility>[
    pendingPrivate,
    pendingPublic,
    private,
    public,
  ];

  static ProfileVisibility? fromJson(dynamic value) => ProfileVisibilityTypeTransformer().decode(value);

  static List<ProfileVisibility> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileVisibility>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileVisibility.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileVisibility] to String,
/// and [decode] dynamic data back to [ProfileVisibility].
class ProfileVisibilityTypeTransformer {
  factory ProfileVisibilityTypeTransformer() => _instance ??= const ProfileVisibilityTypeTransformer._();

  const ProfileVisibilityTypeTransformer._();

  String encode(ProfileVisibility data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileVisibility.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileVisibility? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PendingPrivate': return ProfileVisibility.pendingPrivate;
        case r'PendingPublic': return ProfileVisibility.pendingPublic;
        case r'Private': return ProfileVisibility.private;
        case r'Public': return ProfileVisibility.public;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileVisibilityTypeTransformer] instance.
  static ProfileVisibilityTypeTransformer? _instance;
}

