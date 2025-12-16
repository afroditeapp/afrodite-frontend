//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EventToClient {
  /// Returns a new [EventToClient] instance.
  EventToClient({
    this.adminBotNotification,
    this.checkOnlineStatusResponse,
    this.contentProcessingStateChanged,
    required this.event,
    this.scheduledMaintenanceStatus,
    this.typingStart,
    this.typingStop,
  });

  /// Data for event AdminBotNotification
  AdminBotNotificationTypes? adminBotNotification;

  /// Data for event CheckOnlineStatusResponse
  CheckOnlineStatusResponse? checkOnlineStatusResponse;

  /// Data for event ContentProcessingStateChanged
  ContentProcessingStateChanged? contentProcessingStateChanged;

  EventType event;

  /// Data for event ScheduledMaintenanceStatus
  ScheduledMaintenanceStatus? scheduledMaintenanceStatus;

  /// Data for event TypingStart
  AccountId? typingStart;

  /// Data for event TypingStop
  AccountId? typingStop;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EventToClient &&
    other.adminBotNotification == adminBotNotification &&
    other.checkOnlineStatusResponse == checkOnlineStatusResponse &&
    other.contentProcessingStateChanged == contentProcessingStateChanged &&
    other.event == event &&
    other.scheduledMaintenanceStatus == scheduledMaintenanceStatus &&
    other.typingStart == typingStart &&
    other.typingStop == typingStop;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminBotNotification == null ? 0 : adminBotNotification!.hashCode) +
    (checkOnlineStatusResponse == null ? 0 : checkOnlineStatusResponse!.hashCode) +
    (contentProcessingStateChanged == null ? 0 : contentProcessingStateChanged!.hashCode) +
    (event.hashCode) +
    (scheduledMaintenanceStatus == null ? 0 : scheduledMaintenanceStatus!.hashCode) +
    (typingStart == null ? 0 : typingStart!.hashCode) +
    (typingStop == null ? 0 : typingStop!.hashCode);

  @override
  String toString() => 'EventToClient[adminBotNotification=$adminBotNotification, checkOnlineStatusResponse=$checkOnlineStatusResponse, contentProcessingStateChanged=$contentProcessingStateChanged, event=$event, scheduledMaintenanceStatus=$scheduledMaintenanceStatus, typingStart=$typingStart, typingStop=$typingStop]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.adminBotNotification != null) {
      json[r'admin_bot_notification'] = this.adminBotNotification;
    } else {
      json[r'admin_bot_notification'] = null;
    }
    if (this.checkOnlineStatusResponse != null) {
      json[r'check_online_status_response'] = this.checkOnlineStatusResponse;
    } else {
      json[r'check_online_status_response'] = null;
    }
    if (this.contentProcessingStateChanged != null) {
      json[r'content_processing_state_changed'] = this.contentProcessingStateChanged;
    } else {
      json[r'content_processing_state_changed'] = null;
    }
      json[r'event'] = this.event;
    if (this.scheduledMaintenanceStatus != null) {
      json[r'scheduled_maintenance_status'] = this.scheduledMaintenanceStatus;
    } else {
      json[r'scheduled_maintenance_status'] = null;
    }
    if (this.typingStart != null) {
      json[r'typing_start'] = this.typingStart;
    } else {
      json[r'typing_start'] = null;
    }
    if (this.typingStop != null) {
      json[r'typing_stop'] = this.typingStop;
    } else {
      json[r'typing_stop'] = null;
    }
    return json;
  }

  /// Returns a new [EventToClient] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EventToClient? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EventToClient[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EventToClient[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EventToClient(
        adminBotNotification: AdminBotNotificationTypes.fromJson(json[r'admin_bot_notification']),
        checkOnlineStatusResponse: CheckOnlineStatusResponse.fromJson(json[r'check_online_status_response']),
        contentProcessingStateChanged: ContentProcessingStateChanged.fromJson(json[r'content_processing_state_changed']),
        event: EventType.fromJson(json[r'event'])!,
        scheduledMaintenanceStatus: ScheduledMaintenanceStatus.fromJson(json[r'scheduled_maintenance_status']),
        typingStart: AccountId.fromJson(json[r'typing_start']),
        typingStop: AccountId.fromJson(json[r'typing_stop']),
      );
    }
    return null;
  }

  static List<EventToClient> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventToClient>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventToClient.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EventToClient> mapFromJson(dynamic json) {
    final map = <String, EventToClient>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EventToClient.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EventToClient-objects as value to a dart map
  static Map<String, List<EventToClient>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EventToClient>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EventToClient.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'event',
  };
}

