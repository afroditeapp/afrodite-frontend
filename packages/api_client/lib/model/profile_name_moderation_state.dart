//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileNameModerationState {
  /// Instantiate a new enum with the provided [value].
  const ProfileNameModerationState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const empty = ProfileNameModerationState._(r'Empty');
  static const waitingBotOrHumanModeration = ProfileNameModerationState._(r'WaitingBotOrHumanModeration');
  static const waitingHumanModeration = ProfileNameModerationState._(r'WaitingHumanModeration');
  static const acceptedByBot = ProfileNameModerationState._(r'AcceptedByBot');
  static const acceptedByHuman = ProfileNameModerationState._(r'AcceptedByHuman');
  static const acceptedUsingAllowlist = ProfileNameModerationState._(r'AcceptedUsingAllowlist');
  static const rejectedByBot = ProfileNameModerationState._(r'RejectedByBot');
  static const rejectedByHuman = ProfileNameModerationState._(r'RejectedByHuman');

  /// List of all possible values in this [enum][ProfileNameModerationState].
  static const values = <ProfileNameModerationState>[
    empty,
    waitingBotOrHumanModeration,
    waitingHumanModeration,
    acceptedByBot,
    acceptedByHuman,
    acceptedUsingAllowlist,
    rejectedByBot,
    rejectedByHuman,
  ];

  static ProfileNameModerationState? fromJson(dynamic value) => ProfileNameModerationStateTypeTransformer().decode(value);

  static List<ProfileNameModerationState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileNameModerationState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileNameModerationState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileNameModerationState] to String,
/// and [decode] dynamic data back to [ProfileNameModerationState].
class ProfileNameModerationStateTypeTransformer {
  factory ProfileNameModerationStateTypeTransformer() => _instance ??= const ProfileNameModerationStateTypeTransformer._();

  const ProfileNameModerationStateTypeTransformer._();

  String encode(ProfileNameModerationState data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileNameModerationState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileNameModerationState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Empty': return ProfileNameModerationState.empty;
        case r'WaitingBotOrHumanModeration': return ProfileNameModerationState.waitingBotOrHumanModeration;
        case r'WaitingHumanModeration': return ProfileNameModerationState.waitingHumanModeration;
        case r'AcceptedByBot': return ProfileNameModerationState.acceptedByBot;
        case r'AcceptedByHuman': return ProfileNameModerationState.acceptedByHuman;
        case r'AcceptedUsingAllowlist': return ProfileNameModerationState.acceptedUsingAllowlist;
        case r'RejectedByBot': return ProfileNameModerationState.rejectedByBot;
        case r'RejectedByHuman': return ProfileNameModerationState.rejectedByHuman;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileNameModerationStateTypeTransformer] instance.
  static ProfileNameModerationStateTypeTransformer? _instance;
}

