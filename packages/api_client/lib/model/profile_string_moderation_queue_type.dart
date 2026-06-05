//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileStringModerationQueueType {
  /// Instantiate a new enum with the provided [value].
  const ProfileStringModerationQueueType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const waitingAdminBot = ProfileStringModerationQueueType._(r'WaitingAdminBot');
  static const waitingAdmin = ProfileStringModerationQueueType._(r'WaitingAdmin');
  static const processedByAdminBot = ProfileStringModerationQueueType._(r'ProcessedByAdminBot');

  /// List of all possible values in this [enum][ProfileStringModerationQueueType].
  static const values = <ProfileStringModerationQueueType>[
    waitingAdminBot,
    waitingAdmin,
    processedByAdminBot,
  ];

  static ProfileStringModerationQueueType? fromJson(dynamic value) => ProfileStringModerationQueueTypeTypeTransformer().decode(value);

  static List<ProfileStringModerationQueueType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringModerationQueueType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringModerationQueueType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileStringModerationQueueType] to String,
/// and [decode] dynamic data back to [ProfileStringModerationQueueType].
class ProfileStringModerationQueueTypeTypeTransformer {
  factory ProfileStringModerationQueueTypeTypeTransformer() => _instance ??= const ProfileStringModerationQueueTypeTypeTransformer._();

  const ProfileStringModerationQueueTypeTypeTransformer._();

  String encode(ProfileStringModerationQueueType data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileStringModerationQueueType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStringModerationQueueType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'WaitingAdminBot': return ProfileStringModerationQueueType.waitingAdminBot;
        case r'WaitingAdmin': return ProfileStringModerationQueueType.waitingAdmin;
        case r'ProcessedByAdminBot': return ProfileStringModerationQueueType.processedByAdminBot;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileStringModerationQueueTypeTypeTransformer] instance.
  static ProfileStringModerationQueueTypeTypeTransformer? _instance;
}

