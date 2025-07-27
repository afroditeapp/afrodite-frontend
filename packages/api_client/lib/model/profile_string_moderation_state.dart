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

  static const waitingBotOrHumanModeration = ProfileStringModerationState._(r'WaitingBotOrHumanModeration');
  static const waitingHumanModeration = ProfileStringModerationState._(r'WaitingHumanModeration');
  static const acceptedByBot = ProfileStringModerationState._(r'AcceptedByBot');
  static const acceptedByHuman = ProfileStringModerationState._(r'AcceptedByHuman');
  static const acceptedByAllowlist = ProfileStringModerationState._(r'AcceptedByAllowlist');
  static const rejectedByBot = ProfileStringModerationState._(r'RejectedByBot');
  static const rejectedByHuman = ProfileStringModerationState._(r'RejectedByHuman');

  /// List of all possible values in this [enum][ProfileStringModerationState].
  static const values = <ProfileStringModerationState>[
    waitingBotOrHumanModeration,
    waitingHumanModeration,
    acceptedByBot,
    acceptedByHuman,
    acceptedByAllowlist,
    rejectedByBot,
    rejectedByHuman,
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
        case r'WaitingBotOrHumanModeration': return ProfileStringModerationState.waitingBotOrHumanModeration;
        case r'WaitingHumanModeration': return ProfileStringModerationState.waitingHumanModeration;
        case r'AcceptedByBot': return ProfileStringModerationState.acceptedByBot;
        case r'AcceptedByHuman': return ProfileStringModerationState.acceptedByHuman;
        case r'AcceptedByAllowlist': return ProfileStringModerationState.acceptedByAllowlist;
        case r'RejectedByBot': return ProfileStringModerationState.rejectedByBot;
        case r'RejectedByHuman': return ProfileStringModerationState.rejectedByHuman;
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

