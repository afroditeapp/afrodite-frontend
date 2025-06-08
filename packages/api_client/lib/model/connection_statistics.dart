//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConnectionStatistics {
  /// Returns a new [ConnectionStatistics] instance.
  ConnectionStatistics({
    this.all = const [],
    this.men = const [],
    this.nonbinaries = const [],
    this.women = const [],
  });

  List<int> all;

  List<int> men;

  List<int> nonbinaries;

  List<int> women;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConnectionStatistics &&
    _deepEquality.equals(other.all, all) &&
    _deepEquality.equals(other.men, men) &&
    _deepEquality.equals(other.nonbinaries, nonbinaries) &&
    _deepEquality.equals(other.women, women);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (all.hashCode) +
    (men.hashCode) +
    (nonbinaries.hashCode) +
    (women.hashCode);

  @override
  String toString() => 'ConnectionStatistics[all=$all, men=$men, nonbinaries=$nonbinaries, women=$women]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'all'] = this.all;
      json[r'men'] = this.men;
      json[r'nonbinaries'] = this.nonbinaries;
      json[r'women'] = this.women;
    return json;
  }

  /// Returns a new [ConnectionStatistics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConnectionStatistics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConnectionStatistics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConnectionStatistics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConnectionStatistics(
        all: json[r'all'] is Iterable
            ? (json[r'all'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        men: json[r'men'] is Iterable
            ? (json[r'men'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        nonbinaries: json[r'nonbinaries'] is Iterable
            ? (json[r'nonbinaries'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        women: json[r'women'] is Iterable
            ? (json[r'women'] as Iterable).cast<int>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<ConnectionStatistics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConnectionStatistics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConnectionStatistics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConnectionStatistics> mapFromJson(dynamic json) {
    final map = <String, ConnectionStatistics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConnectionStatistics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConnectionStatistics-objects as value to a dart map
  static Map<String, List<ConnectionStatistics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConnectionStatistics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConnectionStatistics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'all',
    'men',
    'nonbinaries',
    'women',
  };
}
