//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DataTransferByteCount {
  /// Returns a new [DataTransferByteCount] instance.
  DataTransferByteCount({
    required this.byteCount,
  });

  /// Use u32 to prevent integer wrapping when checking is the value inside the current transfer budget.
  ///
  /// Minimum value: 0
  int byteCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DataTransferByteCount &&
    other.byteCount == byteCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (byteCount.hashCode);

  @override
  String toString() => 'DataTransferByteCount[byteCount=$byteCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'byte_count'] = this.byteCount;
    return json;
  }

  /// Returns a new [DataTransferByteCount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DataTransferByteCount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DataTransferByteCount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DataTransferByteCount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DataTransferByteCount(
        byteCount: mapValueOfType<int>(json, r'byte_count')!,
      );
    }
    return null;
  }

  static List<DataTransferByteCount> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DataTransferByteCount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DataTransferByteCount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DataTransferByteCount> mapFromJson(dynamic json) {
    final map = <String, DataTransferByteCount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DataTransferByteCount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DataTransferByteCount-objects as value to a dart map
  static Map<String, List<DataTransferByteCount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DataTransferByteCount>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DataTransferByteCount.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'byte_count',
  };
}

