//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateCustomReportBoolean {
  /// Returns a new [UpdateCustomReportBoolean] instance.
  UpdateCustomReportBoolean({
    required this.customReportId,
    required this.target,
    required this.value,
  });

  /// Minimum value: 0
  int customReportId;

  AccountId target;

  bool value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateCustomReportBoolean &&
    other.customReportId == customReportId &&
    other.target == target &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (customReportId.hashCode) +
    (target.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'UpdateCustomReportBoolean[customReportId=$customReportId, target=$target, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'custom_report_id'] = this.customReportId;
      json[r'target'] = this.target;
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [UpdateCustomReportBoolean] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateCustomReportBoolean? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateCustomReportBoolean[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateCustomReportBoolean[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateCustomReportBoolean(
        customReportId: mapValueOfType<int>(json, r'custom_report_id')!,
        target: AccountId.fromJson(json[r'target'])!,
        value: mapValueOfType<bool>(json, r'value')!,
      );
    }
    return null;
  }

  static List<UpdateCustomReportBoolean> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateCustomReportBoolean>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateCustomReportBoolean.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateCustomReportBoolean> mapFromJson(dynamic json) {
    final map = <String, UpdateCustomReportBoolean>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateCustomReportBoolean.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateCustomReportBoolean-objects as value to a dart map
  static Map<String, List<UpdateCustomReportBoolean>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateCustomReportBoolean>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateCustomReportBoolean.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'custom_report_id',
    'target',
    'value',
  };
}

