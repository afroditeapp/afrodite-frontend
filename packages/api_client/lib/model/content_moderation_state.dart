//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Content moderation states  The states grouped like this:  - InSlot, If user uploads new content to slot the current will be removed. - InModeration, Content is in moderation. User can not remove the content. - ModeratedAsAccepted, Content is moderated as accepted.   User can not remove the content until specific time elapses. - ModeratedAsRejected, Content is moderated as rejected.   Content deleting is possible.
class ContentModerationState {
  /// Instantiate a new enum with the provided [value].
  const ContentModerationState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const inSlot = ContentModerationState._(r'InSlot');
  static const waitingBotOrHumanModeration = ContentModerationState._(r'WaitingBotOrHumanModeration');
  static const waitingHumanModeration = ContentModerationState._(r'WaitingHumanModeration');
  static const acceptedByBot = ContentModerationState._(r'AcceptedByBot');
  static const acceptedByHuman = ContentModerationState._(r'AcceptedByHuman');
  static const rejectedByBot = ContentModerationState._(r'RejectedByBot');
  static const rejectedByHuman = ContentModerationState._(r'RejectedByHuman');

  /// List of all possible values in this [enum][ContentModerationState].
  static const values = <ContentModerationState>[
    inSlot,
    waitingBotOrHumanModeration,
    waitingHumanModeration,
    acceptedByBot,
    acceptedByHuman,
    rejectedByBot,
    rejectedByHuman,
  ];

  static ContentModerationState? fromJson(dynamic value) => ContentModerationStateTypeTransformer().decode(value);

  static List<ContentModerationState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentModerationState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentModerationState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ContentModerationState] to String,
/// and [decode] dynamic data back to [ContentModerationState].
class ContentModerationStateTypeTransformer {
  factory ContentModerationStateTypeTransformer() => _instance ??= const ContentModerationStateTypeTransformer._();

  const ContentModerationStateTypeTransformer._();

  String encode(ContentModerationState data) => data.value;

  /// Decodes a [dynamic value][data] to a ContentModerationState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentModerationState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'InSlot': return ContentModerationState.inSlot;
        case r'WaitingBotOrHumanModeration': return ContentModerationState.waitingBotOrHumanModeration;
        case r'WaitingHumanModeration': return ContentModerationState.waitingHumanModeration;
        case r'AcceptedByBot': return ContentModerationState.acceptedByBot;
        case r'AcceptedByHuman': return ContentModerationState.acceptedByHuman;
        case r'RejectedByBot': return ContentModerationState.rejectedByBot;
        case r'RejectedByHuman': return ContentModerationState.rejectedByHuman;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ContentModerationStateTypeTransformer] instance.
  static ContentModerationStateTypeTransformer? _instance;
}

