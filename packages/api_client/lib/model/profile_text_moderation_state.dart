//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileTextModerationState {
  /// Instantiate a new enum with the provided [value].
  const ProfileTextModerationState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const empty = ProfileTextModerationState._(r'Empty');
  static const waitingBotOrHumanModeration = ProfileTextModerationState._(r'WaitingBotOrHumanModeration');
  static const waitingHumanModeration = ProfileTextModerationState._(r'WaitingHumanModeration');
  static const acceptedByBot = ProfileTextModerationState._(r'AcceptedByBot');
  static const acceptedByHuman = ProfileTextModerationState._(r'AcceptedByHuman');
  static const rejectedByBot = ProfileTextModerationState._(r'RejectedByBot');
  static const rejectedByHuman = ProfileTextModerationState._(r'RejectedByHuman');

  /// List of all possible values in this [enum][ProfileTextModerationState].
  static const values = <ProfileTextModerationState>[
    empty,
    waitingBotOrHumanModeration,
    waitingHumanModeration,
    acceptedByBot,
    acceptedByHuman,
    rejectedByBot,
    rejectedByHuman,
  ];

  static ProfileTextModerationState? fromJson(dynamic value) => ProfileTextModerationStateTypeTransformer().decode(value);

  static List<ProfileTextModerationState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileTextModerationState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileTextModerationState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileTextModerationState] to String,
/// and [decode] dynamic data back to [ProfileTextModerationState].
class ProfileTextModerationStateTypeTransformer {
  factory ProfileTextModerationStateTypeTransformer() => _instance ??= const ProfileTextModerationStateTypeTransformer._();

  const ProfileTextModerationStateTypeTransformer._();

  String encode(ProfileTextModerationState data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileTextModerationState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileTextModerationState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Empty': return ProfileTextModerationState.empty;
        case r'WaitingBotOrHumanModeration': return ProfileTextModerationState.waitingBotOrHumanModeration;
        case r'WaitingHumanModeration': return ProfileTextModerationState.waitingHumanModeration;
        case r'AcceptedByBot': return ProfileTextModerationState.acceptedByBot;
        case r'AcceptedByHuman': return ProfileTextModerationState.acceptedByHuman;
        case r'RejectedByBot': return ProfileTextModerationState.rejectedByBot;
        case r'RejectedByHuman': return ProfileTextModerationState.rejectedByHuman;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileTextModerationStateTypeTransformer] instance.
  static ProfileTextModerationStateTypeTransformer? _instance;
}

