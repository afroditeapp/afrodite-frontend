//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateCustomReportString {
  /// Returns a new [UpdateCustomReportString] instance.
  UpdateCustomReportString({
    required this.content,
    required this.customReportId,
    required this.target,
  });

  /// Custom report string content.  Max 200 grapheme clusters. The value is stored as UTF-8 bytes in the database, so the max byte count is 4 times the grapheme cluster count.
  String content;

  /// Minimum value: 0
  int customReportId;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateCustomReportString &&
    other.content == content &&
    other.customReportId == customReportId &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (customReportId.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateCustomReportString[content=$content, customReportId=$customReportId, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'custom_report_id'] = this.customReportId;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateCustomReportString] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateCustomReportString? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'content'), 'Required key "UpdateCustomReportString[content]" is missing from JSON.');
        assert(json[r'content'] != null, 'Required key "UpdateCustomReportString[content]" has a null value in JSON.');
        assert(json.containsKey(r'custom_report_id'), 'Required key "UpdateCustomReportString[custom_report_id]" is missing from JSON.');
        assert(json[r'custom_report_id'] != null, 'Required key "UpdateCustomReportString[custom_report_id]" has a null value in JSON.');
        assert(json.containsKey(r'target'), 'Required key "UpdateCustomReportString[target]" is missing from JSON.');
        assert(json[r'target'] != null, 'Required key "UpdateCustomReportString[target]" has a null value in JSON.');
        return true;
      }());

      return UpdateCustomReportString(
        content: mapValueOfType<String>(json, r'content')!,
        customReportId: mapValueOfType<int>(json, r'custom_report_id')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateCustomReportString> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateCustomReportString>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateCustomReportString.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateCustomReportString> mapFromJson(dynamic json) {
    final map = <String, UpdateCustomReportString>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateCustomReportString.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateCustomReportString-objects as value to a dart map
  static Map<String, List<UpdateCustomReportString>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateCustomReportString>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateCustomReportString.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'custom_report_id',
    'target',
  };
}

