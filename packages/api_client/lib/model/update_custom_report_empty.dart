//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateCustomReportEmpty {
  /// Returns a new [UpdateCustomReportEmpty] instance.
  UpdateCustomReportEmpty({
    required this.customReportId,
    required this.target,
  });

  /// Minimum value: 0
  int customReportId;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateCustomReportEmpty &&
    other.customReportId == customReportId &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (customReportId.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateCustomReportEmpty[customReportId=$customReportId, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'custom_report_id'] = this.customReportId;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateCustomReportEmpty] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateCustomReportEmpty? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateCustomReportEmpty[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateCustomReportEmpty[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateCustomReportEmpty(
        customReportId: mapValueOfType<int>(json, r'custom_report_id')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateCustomReportEmpty> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateCustomReportEmpty>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateCustomReportEmpty.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateCustomReportEmpty> mapFromJson(dynamic json) {
    final map = <String, UpdateCustomReportEmpty>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateCustomReportEmpty.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateCustomReportEmpty-objects as value to a dart map
  static Map<String, List<UpdateCustomReportEmpty>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateCustomReportEmpty>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateCustomReportEmpty.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'custom_report_id',
    'target',
  };
}

