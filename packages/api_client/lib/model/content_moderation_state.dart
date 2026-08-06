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
enum ContentModerationState {
  inSlot._(r'InSlot'),
  waitingAdminBot._(r'WaitingAdminBot'),
  waitingAdmin._(r'WaitingAdmin'),
  acceptedByAdminBot._(r'AcceptedByAdminBot'),
  acceptedByAdmin._(r'AcceptedByAdmin'),
  rejectedByAdminBot._(r'RejectedByAdminBot'),
  rejectedByAdmin._(r'RejectedByAdmin'),
  ;

  /// Instantiate a new enum with the provided value.
  const ContentModerationState._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ContentModerationState] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ContentModerationState? fromJson(dynamic value) => ContentModerationStateTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ContentModerationState]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(ContentModerationState data) => data._value;

  /// Returns the instance of [ContentModerationState] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentModerationState? decode(dynamic data, {bool allowNull = true}) {
    if (data is ContentModerationState) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'InSlot': return ContentModerationState.inSlot;
        case r'WaitingAdminBot': return ContentModerationState.waitingAdminBot;
        case r'WaitingAdmin': return ContentModerationState.waitingAdmin;
        case r'AcceptedByAdminBot': return ContentModerationState.acceptedByAdminBot;
        case r'AcceptedByAdmin': return ContentModerationState.acceptedByAdmin;
        case r'RejectedByAdminBot': return ContentModerationState.rejectedByAdminBot;
        case r'RejectedByAdmin': return ContentModerationState.rejectedByAdmin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ContentModerationStateTypeTransformer? _instance;
}

