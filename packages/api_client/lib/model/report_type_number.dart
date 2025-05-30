//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportTypeNumber {
  /// Returns a new [ReportTypeNumber] instance.
  ReportTypeNumber({
    required this.n,
  });

  /// This is i8 so that max value is 127. That makes SQLite to store the value using single byte.
  int n;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportTypeNumber &&
    other.n == n;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (n.hashCode);

  @override
  String toString() => 'ReportTypeNumber[n=$n]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'n'] = this.n;
    return json;
  }

  /// Returns a new [ReportTypeNumber] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportTypeNumber? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReportTypeNumber[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReportTypeNumber[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReportTypeNumber(
        n: mapValueOfType<int>(json, r'n')!,
      );
    }
    return null;
  }

  static List<ReportTypeNumber> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportTypeNumber>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportTypeNumber.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportTypeNumber> mapFromJson(dynamic json) {
    final map = <String, ReportTypeNumber>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportTypeNumber.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportTypeNumber-objects as value to a dart map
  static Map<String, List<ReportTypeNumber>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReportTypeNumber>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportTypeNumber.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'n',
  };
}

