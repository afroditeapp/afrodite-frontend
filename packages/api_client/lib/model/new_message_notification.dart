//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewMessageNotification {
  /// Returns a new [NewMessageNotification] instance.
  NewMessageNotification({
    required this.a,
    required this.c,
    required this.m,
  });

  AccountId a;

  ConversationId c;

  /// Message count
  int m;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewMessageNotification &&
    other.a == a &&
    other.c == c &&
    other.m == m;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (a.hashCode) +
    (c.hashCode) +
    (m.hashCode);

  @override
  String toString() => 'NewMessageNotification[a=$a, c=$c, m=$m]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'a'] = this.a;
      json[r'c'] = this.c;
      json[r'm'] = this.m;
    return json;
  }

  /// Returns a new [NewMessageNotification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewMessageNotification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewMessageNotification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewMessageNotification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewMessageNotification(
        a: AccountId.fromJson(json[r'a'])!,
        c: ConversationId.fromJson(json[r'c'])!,
        m: mapValueOfType<int>(json, r'm')!,
      );
    }
    return null;
  }

  static List<NewMessageNotification> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewMessageNotification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewMessageNotification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewMessageNotification> mapFromJson(dynamic json) {
    final map = <String, NewMessageNotification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewMessageNotification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewMessageNotification-objects as value to a dart map
  static Map<String, List<NewMessageNotification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewMessageNotification>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewMessageNotification.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'a',
    'c',
    'm',
  };
}
