//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AgeVerificationMethodsConfig {
  /// Returns a new [AgeVerificationMethodsConfig] instance.
  AgeVerificationMethodsConfig({
    this.debug,
    this.eudi,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AgeVerificationPlatforms? debug;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AgeVerificationPlatforms? eudi;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AgeVerificationMethodsConfig &&
    other.debug == debug &&
    other.eudi == eudi;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (debug == null ? 0 : debug!.hashCode) +
    (eudi == null ? 0 : eudi!.hashCode);

  @override
  String toString() => 'AgeVerificationMethodsConfig[debug=$debug, eudi=$eudi]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.debug != null) {
      json[r'debug'] = this.debug;
    } else {
      json[r'debug'] = null;
    }
    if (this.eudi != null) {
      json[r'eudi'] = this.eudi;
    } else {
      json[r'eudi'] = null;
    }
    return json;
  }

  /// Returns a new [AgeVerificationMethodsConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AgeVerificationMethodsConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AgeVerificationMethodsConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AgeVerificationMethodsConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AgeVerificationMethodsConfig(
        debug: AgeVerificationPlatforms.fromJson(json[r'debug']),
        eudi: AgeVerificationPlatforms.fromJson(json[r'eudi']),
      );
    }
    return null;
  }

  static List<AgeVerificationMethodsConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgeVerificationMethodsConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgeVerificationMethodsConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AgeVerificationMethodsConfig> mapFromJson(dynamic json) {
    final map = <String, AgeVerificationMethodsConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AgeVerificationMethodsConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AgeVerificationMethodsConfig-objects as value to a dart map
  static Map<String, List<AgeVerificationMethodsConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AgeVerificationMethodsConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AgeVerificationMethodsConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

