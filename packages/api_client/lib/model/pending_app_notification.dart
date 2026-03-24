//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingAppNotification {
  /// Returns a new [PendingAppNotification] instance.
  PendingAppNotification({
    this.dataInteger,
    required this.notificationType,
    this.pushNotificationSent = false,
  });

  int? dataInteger;

  PendingAppNotificationType notificationType;

  bool pushNotificationSent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingAppNotification &&
    other.dataInteger == dataInteger &&
    other.notificationType == notificationType &&
    other.pushNotificationSent == pushNotificationSent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dataInteger == null ? 0 : dataInteger!.hashCode) +
    (notificationType.hashCode) +
    (pushNotificationSent.hashCode);

  @override
  String toString() => 'PendingAppNotification[dataInteger=$dataInteger, notificationType=$notificationType, pushNotificationSent=$pushNotificationSent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.dataInteger != null) {
      json[r'data_integer'] = this.dataInteger;
    } else {
      json[r'data_integer'] = null;
    }
      json[r'notification_type'] = this.notificationType;
      json[r'push_notification_sent'] = this.pushNotificationSent;
    return json;
  }

  /// Returns a new [PendingAppNotification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingAppNotification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingAppNotification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingAppNotification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingAppNotification(
        dataInteger: mapValueOfType<int>(json, r'data_integer'),
        notificationType: PendingAppNotificationType.fromJson(json[r'notification_type'])!,
        pushNotificationSent: mapValueOfType<bool>(json, r'push_notification_sent') ?? false,
      );
    }
    return null;
  }

  static List<PendingAppNotification> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingAppNotification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingAppNotification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingAppNotification> mapFromJson(dynamic json) {
    final map = <String, PendingAppNotification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingAppNotification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingAppNotification-objects as value to a dart map
  static Map<String, List<PendingAppNotification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingAppNotification>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PendingAppNotification.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'notification_type',
  };
}

