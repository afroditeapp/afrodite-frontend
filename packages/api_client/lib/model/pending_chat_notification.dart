//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingChatNotification {
  /// Returns a new [PendingChatNotification] instance.
  PendingChatNotification({
    required this.accountIdSender,
    required this.messageCount,
    this.pushNotificationSent = false,
  });

  AccountId accountIdSender;

  int messageCount;

  bool pushNotificationSent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingChatNotification &&
    other.accountIdSender == accountIdSender &&
    other.messageCount == messageCount &&
    other.pushNotificationSent == pushNotificationSent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountIdSender.hashCode) +
    (messageCount.hashCode) +
    (pushNotificationSent.hashCode);

  @override
  String toString() => 'PendingChatNotification[accountIdSender=$accountIdSender, messageCount=$messageCount, pushNotificationSent=$pushNotificationSent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id_sender'] = this.accountIdSender;
      json[r'message_count'] = this.messageCount;
      json[r'push_notification_sent'] = this.pushNotificationSent;
    return json;
  }

  /// Returns a new [PendingChatNotification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingChatNotification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingChatNotification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingChatNotification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingChatNotification(
        accountIdSender: AccountId.fromJson(json[r'account_id_sender'])!,
        messageCount: mapValueOfType<int>(json, r'message_count')!,
        pushNotificationSent: mapValueOfType<bool>(json, r'push_notification_sent') ?? false,
      );
    }
    return null;
  }

  static List<PendingChatNotification> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingChatNotification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingChatNotification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingChatNotification> mapFromJson(dynamic json) {
    final map = <String, PendingChatNotification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingChatNotification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingChatNotification-objects as value to a dart map
  static Map<String, List<PendingChatNotification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingChatNotification>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PendingChatNotification.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id_sender',
    'message_count',
  };
}

