//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewMessageNotificationList {
  /// Returns a new [NewMessageNotificationList] instance.
  NewMessageNotificationList({
    this.v = const [],
  });

  List<NewMessageNotification> v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewMessageNotificationList &&
    _deepEquality.equals(other.v, v);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (v.hashCode);

  @override
  String toString() => 'NewMessageNotificationList[v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'v'] = this.v;
    return json;
  }

  /// Returns a new [NewMessageNotificationList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewMessageNotificationList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewMessageNotificationList[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewMessageNotificationList[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewMessageNotificationList(
        v: NewMessageNotification.listFromJson(json[r'v']),
      );
    }
    return null;
  }

  static List<NewMessageNotificationList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewMessageNotificationList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewMessageNotificationList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewMessageNotificationList> mapFromJson(dynamic json) {
    final map = <String, NewMessageNotificationList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewMessageNotificationList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewMessageNotificationList-objects as value to a dart map
  static Map<String, List<NewMessageNotificationList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewMessageNotificationList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewMessageNotificationList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'v',
  };
}

