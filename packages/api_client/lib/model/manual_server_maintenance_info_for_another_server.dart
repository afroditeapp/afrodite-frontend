//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ManualServerMaintenanceInfoForAnotherServer {
  /// Returns a new [ManualServerMaintenanceInfoForAnotherServer] instance.
  ManualServerMaintenanceInfoForAnotherServer({
    this.text,
  });

  StringResource? text;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ManualServerMaintenanceInfoForAnotherServer &&
    other.text == text;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (text == null ? 0 : text!.hashCode);

  @override
  String toString() => 'ManualServerMaintenanceInfoForAnotherServer[text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
    return json;
  }

  /// Returns a new [ManualServerMaintenanceInfoForAnotherServer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ManualServerMaintenanceInfoForAnotherServer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ManualServerMaintenanceInfoForAnotherServer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ManualServerMaintenanceInfoForAnotherServer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ManualServerMaintenanceInfoForAnotherServer(
        text: StringResource.fromJson(json[r'text']),
      );
    }
    return null;
  }

  static List<ManualServerMaintenanceInfoForAnotherServer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManualServerMaintenanceInfoForAnotherServer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManualServerMaintenanceInfoForAnotherServer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ManualServerMaintenanceInfoForAnotherServer> mapFromJson(dynamic json) {
    final map = <String, ManualServerMaintenanceInfoForAnotherServer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ManualServerMaintenanceInfoForAnotherServer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ManualServerMaintenanceInfoForAnotherServer-objects as value to a dart map
  static Map<String, List<ManualServerMaintenanceInfoForAnotherServer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ManualServerMaintenanceInfoForAnotherServer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ManualServerMaintenanceInfoForAnotherServer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

