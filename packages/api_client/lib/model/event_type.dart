//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Identifier for event.
class EventType {
  /// Instantiate a new enum with the provided [value].
  const EventType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accountStateChanged = EventType._(r'AccountStateChanged');
  static const newMessageReceived = EventType._(r'NewMessageReceived');
  static const receivedLikesChanged = EventType._(r'ReceivedLikesChanged');
  static const contentProcessingStateChanged = EventType._(r'ContentProcessingStateChanged');
  static const clientConfigChanged = EventType._(r'ClientConfigChanged');
  static const profileChanged = EventType._(r'ProfileChanged');
  static const newsCountChanged = EventType._(r'NewsCountChanged');
  static const mediaContentModerationCompleted = EventType._(r'MediaContentModerationCompleted');
  static const mediaContentChanged = EventType._(r'MediaContentChanged');
  static const dailyLikesLeftChanged = EventType._(r'DailyLikesLeftChanged');
  static const scheduledMaintenanceStatus = EventType._(r'ScheduledMaintenanceStatus');
  static const profileStringModerationCompleted = EventType._(r'ProfileStringModerationCompleted');
  static const automaticProfileSearchCompleted = EventType._(r'AutomaticProfileSearchCompleted');
  static const adminNotification = EventType._(r'AdminNotification');

  /// List of all possible values in this [enum][EventType].
  static const values = <EventType>[
    accountStateChanged,
    newMessageReceived,
    receivedLikesChanged,
    contentProcessingStateChanged,
    clientConfigChanged,
    profileChanged,
    newsCountChanged,
    mediaContentModerationCompleted,
    mediaContentChanged,
    dailyLikesLeftChanged,
    scheduledMaintenanceStatus,
    profileStringModerationCompleted,
    automaticProfileSearchCompleted,
    adminNotification,
  ];

  static EventType? fromJson(dynamic value) => EventTypeTypeTransformer().decode(value);

  static List<EventType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EventType] to String,
/// and [decode] dynamic data back to [EventType].
class EventTypeTypeTransformer {
  factory EventTypeTypeTransformer() => _instance ??= const EventTypeTypeTransformer._();

  const EventTypeTypeTransformer._();

  String encode(EventType data) => data.value;

  /// Decodes a [dynamic value][data] to a EventType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EventType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AccountStateChanged': return EventType.accountStateChanged;
        case r'NewMessageReceived': return EventType.newMessageReceived;
        case r'ReceivedLikesChanged': return EventType.receivedLikesChanged;
        case r'ContentProcessingStateChanged': return EventType.contentProcessingStateChanged;
        case r'ClientConfigChanged': return EventType.clientConfigChanged;
        case r'ProfileChanged': return EventType.profileChanged;
        case r'NewsCountChanged': return EventType.newsCountChanged;
        case r'MediaContentModerationCompleted': return EventType.mediaContentModerationCompleted;
        case r'MediaContentChanged': return EventType.mediaContentChanged;
        case r'DailyLikesLeftChanged': return EventType.dailyLikesLeftChanged;
        case r'ScheduledMaintenanceStatus': return EventType.scheduledMaintenanceStatus;
        case r'ProfileStringModerationCompleted': return EventType.profileStringModerationCompleted;
        case r'AutomaticProfileSearchCompleted': return EventType.automaticProfileSearchCompleted;
        case r'AdminNotification': return EventType.adminNotification;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EventTypeTypeTransformer] instance.
  static EventTypeTypeTransformer? _instance;
}

