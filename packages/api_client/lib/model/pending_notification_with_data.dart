//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingNotificationWithData {
  /// Returns a new [PendingNotificationWithData] instance.
  PendingNotificationWithData({
    this.newMessageReceivedFrom = const [],
    required this.value,
  });

  /// Data for NEW_MESSAGE notification.  List of account IDs which have sent a new message.
  List<AccountId>? newMessageReceivedFrom;

  /// Pending notification (or multiple notifications which each have different type) not yet received notifications which push notification requests client to download.  The integer is a bitflag.  - const NEW_MESSAGE = 0x1; 
  int value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingNotificationWithData &&
     other.newMessageReceivedFrom == newMessageReceivedFrom &&
     other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (newMessageReceivedFrom == null ? 0 : newMessageReceivedFrom!.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'PendingNotificationWithData[newMessageReceivedFrom=$newMessageReceivedFrom, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.newMessageReceivedFrom != null) {
      json[r'new_message_received_from'] = this.newMessageReceivedFrom;
    } else {
      json[r'new_message_received_from'] = null;
    }
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [PendingNotificationWithData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingNotificationWithData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingNotificationWithData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingNotificationWithData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingNotificationWithData(
        newMessageReceivedFrom: AccountId.listFromJson(json[r'new_message_received_from']) ?? const [],
        value: mapValueOfType<int>(json, r'value')!,
      );
    }
    return null;
  }

  static List<PendingNotificationWithData>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingNotificationWithData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingNotificationWithData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingNotificationWithData> mapFromJson(dynamic json) {
    final map = <String, PendingNotificationWithData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingNotificationWithData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingNotificationWithData-objects as value to a dart map
  static Map<String, List<PendingNotificationWithData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingNotificationWithData>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingNotificationWithData.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'value',
  };
}

