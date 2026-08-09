//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// App notification types  # Notification specific data  ## Admin notification  Integer payload contains the following bitflags:  * MODERATE_INITIAL_MEDIA_CONTENT_BOT = 1 << 0 * MODERATE_INITIAL_MEDIA_CONTENT_HUMAN = 1 << 1 * MODERATE_MEDIA_CONTENT_BOT = 1 << 2 * MODERATE_MEDIA_CONTENT_HUMAN = 1 << 3 * MODERATE_PROFILE_TEXTS_BOT = 1 << 4 * MODERATE_PROFILE_TEXTS_HUMAN = 1 << 5 * MODERATE_PROFILE_NAMES_BOT = 1 << 6 * MODERATE_PROFILE_NAMES_HUMAN = 1 << 7 * PROCESS_REPORTS = 1 << 8  ## News changed  Integer payload contains current unread news count.  ## Automatic profile search completed  Integer payload contains the found profile count.  ## Received likes changed  Integer payload contains current received likes count.
enum PendingAppNotificationType {
  adminNotification._(r'AdminNotification'),
  newsChanged._(r'NewsChanged'),
  profileNameModerationCompleted._(r'ProfileNameModerationCompleted'),
  profileTextModerationCompleted._(r'ProfileTextModerationCompleted'),
  automaticProfileSearchCompleted._(r'AutomaticProfileSearchCompleted'),
  mediaContentModerationAccepted._(r'MediaContentModerationAccepted'),
  mediaContentModerationRejected._(r'MediaContentModerationRejected'),
  mediaContentModerationDeleted._(r'MediaContentModerationDeleted'),
  receivedLikesChanged._(r'ReceivedLikesChanged'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const PendingAppNotificationType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [PendingAppNotificationType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static PendingAppNotificationType? fromJson(dynamic value) => PendingAppNotificationTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [PendingAppNotificationType]
  /// that were successfully decoded from the passed [JSON][json].
  static List<PendingAppNotificationType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingAppNotificationType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingAppNotificationType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PendingAppNotificationType] to String,
/// and [decode] dynamic data back to [PendingAppNotificationType].
class PendingAppNotificationTypeTypeTransformer {
  factory PendingAppNotificationTypeTypeTransformer() => _instance ??= const PendingAppNotificationTypeTypeTransformer._();

  const PendingAppNotificationTypeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(PendingAppNotificationType data) => data._value;

  /// Returns the instance of [PendingAppNotificationType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PendingAppNotificationType? decode(dynamic data, {bool allowNull = true}) {
    if (data is PendingAppNotificationType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'AdminNotification': return PendingAppNotificationType.adminNotification;
        case r'NewsChanged': return PendingAppNotificationType.newsChanged;
        case r'ProfileNameModerationCompleted': return PendingAppNotificationType.profileNameModerationCompleted;
        case r'ProfileTextModerationCompleted': return PendingAppNotificationType.profileTextModerationCompleted;
        case r'AutomaticProfileSearchCompleted': return PendingAppNotificationType.automaticProfileSearchCompleted;
        case r'MediaContentModerationAccepted': return PendingAppNotificationType.mediaContentModerationAccepted;
        case r'MediaContentModerationRejected': return PendingAppNotificationType.mediaContentModerationRejected;
        case r'MediaContentModerationDeleted': return PendingAppNotificationType.mediaContentModerationDeleted;
        case r'ReceivedLikesChanged': return PendingAppNotificationType.receivedLikesChanged;
        case r'unknown_default_open_api': return PendingAppNotificationType.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static PendingAppNotificationTypeTypeTransformer? _instance;
}

