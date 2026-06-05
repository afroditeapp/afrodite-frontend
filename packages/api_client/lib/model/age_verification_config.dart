//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AgeVerificationConfig {
  /// Returns a new [AgeVerificationConfig] instance.
  AgeVerificationConfig({
    this.methods,
    this.required_,
    this.verifyDuringInitialSetup,
  });

  AgeVerificationMethodsConfig? methods;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AgeVerificationPlatforms? required_;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AgeVerificationPlatforms? verifyDuringInitialSetup;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AgeVerificationConfig &&
    other.methods == methods &&
    other.required_ == required_ &&
    other.verifyDuringInitialSetup == verifyDuringInitialSetup;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (methods == null ? 0 : methods!.hashCode) +
    (required_ == null ? 0 : required_!.hashCode) +
    (verifyDuringInitialSetup == null ? 0 : verifyDuringInitialSetup!.hashCode);

  @override
  String toString() => 'AgeVerificationConfig[methods=$methods, required_=$required_, verifyDuringInitialSetup=$verifyDuringInitialSetup]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.methods != null) {
      json[r'methods'] = this.methods;
    } else {
      json[r'methods'] = null;
    }
    if (this.required_ != null) {
      json[r'required'] = this.required_;
    } else {
      json[r'required'] = null;
    }
    if (this.verifyDuringInitialSetup != null) {
      json[r'verify_during_initial_setup'] = this.verifyDuringInitialSetup;
    } else {
      json[r'verify_during_initial_setup'] = null;
    }
    return json;
  }

  /// Returns a new [AgeVerificationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AgeVerificationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AgeVerificationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AgeVerificationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AgeVerificationConfig(
        methods: AgeVerificationMethodsConfig.fromJson(json[r'methods']),
        required_: AgeVerificationPlatforms.fromJson(json[r'required']),
        verifyDuringInitialSetup: AgeVerificationPlatforms.fromJson(json[r'verify_during_initial_setup']),
      );
    }
    return null;
  }

  static List<AgeVerificationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgeVerificationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgeVerificationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AgeVerificationConfig> mapFromJson(dynamic json) {
    final map = <String, AgeVerificationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AgeVerificationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AgeVerificationConfig-objects as value to a dart map
  static Map<String, List<AgeVerificationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AgeVerificationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AgeVerificationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

