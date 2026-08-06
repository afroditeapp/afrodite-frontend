//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomEmailId {
  /// Returns a new [CustomEmailId] instance.
  CustomEmailId({
    required this.eid,
  });

  int eid;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomEmailId &&
    other.eid == eid;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (eid.hashCode);

  @override
  String toString() => 'CustomEmailId[eid=$eid]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'eid'] = this.eid;
    return json;
  }

  /// Returns a new [CustomEmailId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomEmailId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'eid'), 'Required key "CustomEmailId[eid]" is missing from JSON.');
        assert(json[r'eid'] != null, 'Required key "CustomEmailId[eid]" has a null value in JSON.');
        return true;
      }());

      return CustomEmailId(
        eid: mapValueOfType<int>(json, r'eid')!,
      );
    }
    return null;
  }

  static List<CustomEmailId> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomEmailId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomEmailId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomEmailId> mapFromJson(dynamic json) {
    final map = <String, CustomEmailId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomEmailId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomEmailId-objects as value to a dart map
  static Map<String, List<CustomEmailId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomEmailId>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomEmailId.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'eid',
  };
}

