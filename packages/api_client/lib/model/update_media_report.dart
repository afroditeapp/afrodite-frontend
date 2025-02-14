//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateMediaReport {
  /// Returns a new [UpdateMediaReport] instance.
  UpdateMediaReport({
    required this.content,
    required this.target,
  });

  MediaReportContent content;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateMediaReport &&
    other.content == content &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateMediaReport[content=$content, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateMediaReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateMediaReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateMediaReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateMediaReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateMediaReport(
        content: MediaReportContent.fromJson(json[r'content'])!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateMediaReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateMediaReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateMediaReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateMediaReport> mapFromJson(dynamic json) {
    final map = <String, UpdateMediaReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateMediaReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateMediaReport-objects as value to a dart map
  static Map<String, List<UpdateMediaReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateMediaReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateMediaReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'target',
  };
}

