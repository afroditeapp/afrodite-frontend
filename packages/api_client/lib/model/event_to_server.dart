//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EventToServer {
  /// Returns a new [EventToServer] instance.
  EventToServer({
    this.a,
    this.o,
    required this.t,
  });

  AccountId? a;

  /// Online status (None value is false)
  bool? o;

  EventToServerType t;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EventToServer &&
    other.a == a &&
    other.o == o &&
    other.t == t;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (a == null ? 0 : a!.hashCode) +
    (o == null ? 0 : o!.hashCode) +
    (t.hashCode);

  @override
  String toString() => 'EventToServer[a=$a, o=$o, t=$t]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.a != null) {
      json[r'a'] = this.a;
    } else {
      json[r'a'] = null;
    }
    if (this.o != null) {
      json[r'o'] = this.o;
    } else {
      json[r'o'] = null;
    }
      json[r't'] = this.t;
    return json;
  }

  /// Returns a new [EventToServer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EventToServer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EventToServer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EventToServer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EventToServer(
        a: AccountId.fromJson(json[r'a']),
        o: mapValueOfType<bool>(json, r'o'),
        t: EventToServerType.fromJson(json[r't'])!,
      );
    }
    return null;
  }

  static List<EventToServer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventToServer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventToServer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EventToServer> mapFromJson(dynamic json) {
    final map = <String, EventToServer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EventToServer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EventToServer-objects as value to a dart map
  static Map<String, List<EventToServer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EventToServer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EventToServer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    't',
  };
}

