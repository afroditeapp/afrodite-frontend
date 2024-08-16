//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PerfHistoryQueryResult {
  /// Returns a new [PerfHistoryQueryResult] instance.
  PerfHistoryQueryResult({
    this.counters = const [],
  });

  List<PerfHistoryValue> counters;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PerfHistoryQueryResult &&
    _deepEquality.equals(other.counters, counters);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (counters.hashCode);

  @override
  String toString() => 'PerfHistoryQueryResult[counters=$counters]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'counters'] = this.counters;
    return json;
  }

  /// Returns a new [PerfHistoryQueryResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PerfHistoryQueryResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PerfHistoryQueryResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PerfHistoryQueryResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PerfHistoryQueryResult(
        counters: PerfHistoryValue.listFromJson(json[r'counters']),
      );
    }
    return null;
  }

  static List<PerfHistoryQueryResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PerfHistoryQueryResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PerfHistoryQueryResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PerfHistoryQueryResult> mapFromJson(dynamic json) {
    final map = <String, PerfHistoryQueryResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PerfHistoryQueryResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PerfHistoryQueryResult-objects as value to a dart map
  static Map<String, List<PerfHistoryQueryResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PerfHistoryQueryResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PerfHistoryQueryResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'counters',
  };
}

