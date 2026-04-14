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
class PendingAppNotificationType {
  /// Instantiate a new enum with the provided [value].
  const PendingAppNotificationType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const adminNotification = PendingAppNotificationType._(r'AdminNotification');
  static const newsChanged = PendingAppNotificationType._(r'NewsChanged');
  static const profileNameModerationCompleted = PendingAppNotificationType._(r'ProfileNameModerationCompleted');
  static const profileTextModerationCompleted = PendingAppNotificationType._(r'ProfileTextModerationCompleted');
  static const automaticProfileSearchCompleted = PendingAppNotificationType._(r'AutomaticProfileSearchCompleted');
  static const mediaContentModerationAccepted = PendingAppNotificationType._(r'MediaContentModerationAccepted');
  static const mediaContentModerationRejected = PendingAppNotificationType._(r'MediaContentModerationRejected');
  static const mediaContentModerationDeleted = PendingAppNotificationType._(r'MediaContentModerationDeleted');
  static const receivedLikesChanged = PendingAppNotificationType._(r'ReceivedLikesChanged');

  /// List of all possible values in this [enum][PendingAppNotificationType].
  static const values = <PendingAppNotificationType>[
    adminNotification,
    newsChanged,
    profileNameModerationCompleted,
    profileTextModerationCompleted,
    automaticProfileSearchCompleted,
    mediaContentModerationAccepted,
    mediaContentModerationRejected,
    mediaContentModerationDeleted,
    receivedLikesChanged,
  ];

  static PendingAppNotificationType? fromJson(dynamic value) => PendingAppNotificationTypeTypeTransformer().decode(value);

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

  String encode(PendingAppNotificationType data) => data.value;

  /// Decodes a [dynamic value][data] to a PendingAppNotificationType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PendingAppNotificationType? decode(dynamic data, {bool allowNull = true}) {
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
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PendingAppNotificationTypeTypeTransformer] instance.
  static PendingAppNotificationTypeTypeTransformer? _instance;
}

