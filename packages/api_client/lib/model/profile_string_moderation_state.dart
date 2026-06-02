//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileStringModerationState {
  /// Instantiate a new enum with the provided [value].
  const ProfileStringModerationState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const waitingAdminBot = ProfileStringModerationState._(r'WaitingAdminBot');
  static const waitingAdmin = ProfileStringModerationState._(r'WaitingAdmin');
  static const acceptedByAdminBot = ProfileStringModerationState._(r'AcceptedByAdminBot');
  static const acceptedByAdmin = ProfileStringModerationState._(r'AcceptedByAdmin');
  static const acceptedByAllowlist = ProfileStringModerationState._(r'AcceptedByAllowlist');
  static const rejectedByAdminBot = ProfileStringModerationState._(r'RejectedByAdminBot');
  static const rejectedByAdmin = ProfileStringModerationState._(r'RejectedByAdmin');

  /// List of all possible values in this [enum][ProfileStringModerationState].
  static const values = <ProfileStringModerationState>[
    waitingAdminBot,
    waitingAdmin,
    acceptedByAdminBot,
    acceptedByAdmin,
    acceptedByAllowlist,
    rejectedByAdminBot,
    rejectedByAdmin,
  ];

  static ProfileStringModerationState? fromJson(dynamic value) => ProfileStringModerationStateTypeTransformer().decode(value);

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

  String encode(ProfileStringModerationState data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileStringModerationState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStringModerationState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'WaitingAdminBot': return ProfileStringModerationState.waitingAdminBot;
        case r'WaitingAdmin': return ProfileStringModerationState.waitingAdmin;
        case r'AcceptedByAdminBot': return ProfileStringModerationState.acceptedByAdminBot;
        case r'AcceptedByAdmin': return ProfileStringModerationState.acceptedByAdmin;
        case r'AcceptedByAllowlist': return ProfileStringModerationState.acceptedByAllowlist;
        case r'RejectedByAdminBot': return ProfileStringModerationState.rejectedByAdminBot;
        case r'RejectedByAdmin': return ProfileStringModerationState.rejectedByAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileStringModerationStateTypeTransformer] instance.
  static ProfileStringModerationStateTypeTransformer? _instance;
}

