//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DataExportState {
  /// Returns a new [DataExportState] instance.
  DataExportState({
    this.name,
    required this.state,
  });

  /// Available when current state is [DataExportStateType::Done].
  DataExportName? name;

  DataExportStateType state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DataExportState &&
    other.name == name &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'DataExportState[name=$name, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [DataExportState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DataExportState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DataExportState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DataExportState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DataExportState(
        name: DataExportName.fromJson(json[r'name']),
        state: DataExportStateType.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<DataExportState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DataExportState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DataExportState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DataExportState> mapFromJson(dynamic json) {
    final map = <String, DataExportState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DataExportState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DataExportState-objects as value to a dart map
  static Map<String, List<DataExportState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DataExportState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DataExportState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'state',
  };
}

