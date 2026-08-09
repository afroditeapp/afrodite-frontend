//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum MediaContentModerationQueueType {
  waitingAdminBot._(r'WaitingAdminBot'),
  waitingAdmin._(r'WaitingAdmin'),
  acceptedByAdminBot._(r'AcceptedByAdminBot'),
  rejectedByAdminBot._(r'RejectedByAdminBot'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const MediaContentModerationQueueType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [MediaContentModerationQueueType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static MediaContentModerationQueueType? fromJson(dynamic value) => MediaContentModerationQueueTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [MediaContentModerationQueueType]
  /// that were successfully decoded from the passed [JSON][json].
  static List<MediaContentModerationQueueType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentModerationQueueType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentModerationQueueType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MediaContentModerationQueueType] to String,
/// and [decode] dynamic data back to [MediaContentModerationQueueType].
class MediaContentModerationQueueTypeTypeTransformer {
  factory MediaContentModerationQueueTypeTypeTransformer() => _instance ??= const MediaContentModerationQueueTypeTypeTransformer._();

  const MediaContentModerationQueueTypeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(MediaContentModerationQueueType data) => data._value;

  /// Returns the instance of [MediaContentModerationQueueType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MediaContentModerationQueueType? decode(dynamic data, {bool allowNull = true}) {
    if (data is MediaContentModerationQueueType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'WaitingAdminBot': return MediaContentModerationQueueType.waitingAdminBot;
        case r'WaitingAdmin': return MediaContentModerationQueueType.waitingAdmin;
        case r'AcceptedByAdminBot': return MediaContentModerationQueueType.acceptedByAdminBot;
        case r'RejectedByAdminBot': return MediaContentModerationQueueType.rejectedByAdminBot;
        case r'unknown_default_open_api': return MediaContentModerationQueueType.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static MediaContentModerationQueueTypeTypeTransformer? _instance;
}

