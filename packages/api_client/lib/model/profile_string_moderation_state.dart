//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProfileStringModerationState {
  waitingAdminBot._(r'WaitingAdminBot'),
  waitingAdmin._(r'WaitingAdmin'),
  acceptedByAdminBot._(r'AcceptedByAdminBot'),
  acceptedByAdmin._(r'AcceptedByAdmin'),
  acceptedByAllowlist._(r'AcceptedByAllowlist'),
  rejectedByAdminBot._(r'RejectedByAdminBot'),
  rejectedByAdmin._(r'RejectedByAdmin'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProfileStringModerationState._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProfileStringModerationState] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProfileStringModerationState? fromJson(dynamic value) => ProfileStringModerationStateTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProfileStringModerationState]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProfileStringModerationState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringModerationState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringModerationState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileStringModerationState] to String,
/// and [decode] dynamic data back to [ProfileStringModerationState].
class ProfileStringModerationStateTypeTransformer {
  factory ProfileStringModerationStateTypeTransformer() => _instance ??= const ProfileStringModerationStateTypeTransformer._();

  const ProfileStringModerationStateTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProfileStringModerationState data) => data._value;

  /// Returns the instance of [ProfileStringModerationState] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStringModerationState? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProfileStringModerationState) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'WaitingAdminBot': return ProfileStringModerationState.waitingAdminBot;
        case r'WaitingAdmin': return ProfileStringModerationState.waitingAdmin;
        case r'AcceptedByAdminBot': return ProfileStringModerationState.acceptedByAdminBot;
        case r'AcceptedByAdmin': return ProfileStringModerationState.acceptedByAdmin;
        case r'AcceptedByAllowlist': return ProfileStringModerationState.acceptedByAllowlist;
        case r'RejectedByAdminBot': return ProfileStringModerationState.rejectedByAdminBot;
        case r'RejectedByAdmin': return ProfileStringModerationState.rejectedByAdmin;
        case r'unknown_default_open_api': return ProfileStringModerationState.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProfileStringModerationStateTypeTransformer? _instance;
}

