//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostAgeVerificationResult {
  /// Returns a new [PostAgeVerificationResult] instance.
  PostAgeVerificationResult({
    this.error = false,
    this.errorAgeAlreadyVerified = false,
    this.errorAgeUnder18 = false,
    this.errorVerificationDataParsingFailed = false,
    this.errorVerificationDataVerificationFailed = false,
    this.errorVerificationMethodNotConfigured = false,
  });

  bool error;

  bool errorAgeAlreadyVerified;

  bool errorAgeUnder18;

  bool errorVerificationDataParsingFailed;

  bool errorVerificationDataVerificationFailed;

  bool errorVerificationMethodNotConfigured;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostAgeVerificationResult &&
    other.error == error &&
    other.errorAgeAlreadyVerified == errorAgeAlreadyVerified &&
    other.errorAgeUnder18 == errorAgeUnder18 &&
    other.errorVerificationDataParsingFailed == errorVerificationDataParsingFailed &&
    other.errorVerificationDataVerificationFailed == errorVerificationDataVerificationFailed &&
    other.errorVerificationMethodNotConfigured == errorVerificationMethodNotConfigured;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (errorAgeAlreadyVerified.hashCode) +
    (errorAgeUnder18.hashCode) +
    (errorVerificationDataParsingFailed.hashCode) +
    (errorVerificationDataVerificationFailed.hashCode) +
    (errorVerificationMethodNotConfigured.hashCode);

  @override
  String toString() => 'PostAgeVerificationResult[error=$error, errorAgeAlreadyVerified=$errorAgeAlreadyVerified, errorAgeUnder18=$errorAgeUnder18, errorVerificationDataParsingFailed=$errorVerificationDataParsingFailed, errorVerificationDataVerificationFailed=$errorVerificationDataVerificationFailed, errorVerificationMethodNotConfigured=$errorVerificationMethodNotConfigured]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
      json[r'error_age_already_verified'] = this.errorAgeAlreadyVerified;
      json[r'error_age_under_18'] = this.errorAgeUnder18;
      json[r'error_verification_data_parsing_failed'] = this.errorVerificationDataParsingFailed;
      json[r'error_verification_data_verification_failed'] = this.errorVerificationDataVerificationFailed;
      json[r'error_verification_method_not_configured'] = this.errorVerificationMethodNotConfigured;
    return json;
  }

  /// Returns a new [PostAgeVerificationResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostAgeVerificationResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostAgeVerificationResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostAgeVerificationResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostAgeVerificationResult(
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorAgeAlreadyVerified: mapValueOfType<bool>(json, r'error_age_already_verified') ?? false,
        errorAgeUnder18: mapValueOfType<bool>(json, r'error_age_under_18') ?? false,
        errorVerificationDataParsingFailed: mapValueOfType<bool>(json, r'error_verification_data_parsing_failed') ?? false,
        errorVerificationDataVerificationFailed: mapValueOfType<bool>(json, r'error_verification_data_verification_failed') ?? false,
        errorVerificationMethodNotConfigured: mapValueOfType<bool>(json, r'error_verification_method_not_configured') ?? false,
      );
    }
    return null;
  }

  static List<PostAgeVerificationResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostAgeVerificationResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostAgeVerificationResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostAgeVerificationResult> mapFromJson(dynamic json) {
    final map = <String, PostAgeVerificationResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostAgeVerificationResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostAgeVerificationResult-objects as value to a dart map
  static Map<String, List<PostAgeVerificationResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostAgeVerificationResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostAgeVerificationResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

