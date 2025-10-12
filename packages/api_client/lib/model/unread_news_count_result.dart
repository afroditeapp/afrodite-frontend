//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UnreadNewsCountResult {
  /// Returns a new [UnreadNewsCountResult] instance.
  UnreadNewsCountResult({
    required this.c,
    this.h = false,
    required this.v,
  });

  UnreadNewsCount c;

  /// If true, client should not show the notification
  bool h;

  NewsSyncVersion v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UnreadNewsCountResult &&
    other.c == c &&
    other.h == h &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (h.hashCode) +
    (v.hashCode);

  @override
  String toString() => 'UnreadNewsCountResult[c=$c, h=$h, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
      json[r'h'] = this.h;
      json[r'v'] = this.v;
    return json;
  }

  /// Returns a new [UnreadNewsCountResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UnreadNewsCountResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UnreadNewsCountResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UnreadNewsCountResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UnreadNewsCountResult(
        c: UnreadNewsCount.fromJson(json[r'c'])!,
        h: mapValueOfType<bool>(json, r'h') ?? false,
        v: NewsSyncVersion.fromJson(json[r'v'])!,
      );
    }
    return null;
  }

  static List<UnreadNewsCountResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UnreadNewsCountResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UnreadNewsCountResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UnreadNewsCountResult> mapFromJson(dynamic json) {
    final map = <String, UnreadNewsCountResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UnreadNewsCountResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UnreadNewsCountResult-objects as value to a dart map
  static Map<String, List<UnreadNewsCountResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UnreadNewsCountResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UnreadNewsCountResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
    'v',
  };
}

