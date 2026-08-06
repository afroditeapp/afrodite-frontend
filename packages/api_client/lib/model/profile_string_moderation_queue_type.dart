//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProfileStringModerationQueueType {
  waitingAdminBot._(r'WaitingAdminBot'),
  waitingAdmin._(r'WaitingAdmin'),
  acceptedByAdminBot._(r'AcceptedByAdminBot'),
  rejectedByAdminBot._(r'RejectedByAdminBot'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProfileStringModerationQueueType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProfileStringModerationQueueType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProfileStringModerationQueueType? fromJson(dynamic value) => ProfileStringModerationQueueTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProfileStringModerationQueueType]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProfileStringModerationQueueType data) => data._value;

  /// Returns the instance of [ProfileStringModerationQueueType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStringModerationQueueType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProfileStringModerationQueueType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'WaitingAdminBot': return ProfileStringModerationQueueType.waitingAdminBot;
        case r'WaitingAdmin': return ProfileStringModerationQueueType.waitingAdmin;
        case r'AcceptedByAdminBot': return ProfileStringModerationQueueType.acceptedByAdminBot;
        case r'RejectedByAdminBot': return ProfileStringModerationQueueType.rejectedByAdminBot;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProfileStringModerationQueueTypeTypeTransformer? _instance;
}

