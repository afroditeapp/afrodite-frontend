//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminFaceVerificationConfig {
  /// Returns a new [AdminFaceVerificationConfig] instance.
  AdminFaceVerificationConfig({
    required this.defaultAction,
    required this.llm,
    this.llmEnabled = false,
  });

  VerificationAction defaultAction;

  LlmFaceVerificationConfig llm;

  /// Large language model based face verification. Actions: reject and accept.
  bool llmEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminFaceVerificationConfig &&
    other.defaultAction == defaultAction &&
    other.llm == llm &&
    other.llmEnabled == llmEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (defaultAction.hashCode) +
    (llm.hashCode) +
    (llmEnabled.hashCode);

  @override
  String toString() => 'AdminFaceVerificationConfig[defaultAction=$defaultAction, llm=$llm, llmEnabled=$llmEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'default_action'] = this.defaultAction;
      json[r'llm'] = this.llm;
      json[r'llm_enabled'] = this.llmEnabled;
    return json;
  }

  /// Returns a new [AdminFaceVerificationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminFaceVerificationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminFaceVerificationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminFaceVerificationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminFaceVerificationConfig(
        defaultAction: VerificationAction.fromJson(json[r'default_action'])!,
        llm: LlmFaceVerificationConfig.fromJson(json[r'llm'])!,
        llmEnabled: mapValueOfType<bool>(json, r'llm_enabled') ?? false,
      );
    }
    return null;
  }

  static List<AdminFaceVerificationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminFaceVerificationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminFaceVerificationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminFaceVerificationConfig> mapFromJson(dynamic json) {
    final map = <String, AdminFaceVerificationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminFaceVerificationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminFaceVerificationConfig-objects as value to a dart map
  static Map<String, List<AdminFaceVerificationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminFaceVerificationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminFaceVerificationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'default_action',
    'llm',
  };
}

