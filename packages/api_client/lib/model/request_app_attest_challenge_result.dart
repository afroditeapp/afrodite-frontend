//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RequestAppAttestChallengeResult {
  /// Returns a new [RequestAppAttestChallengeResult] instance.
  RequestAppAttestChallengeResult({
    this.appleAppAttestKeyExists,
    this.challenge,
    this.error = false,
    this.errorInvalidVerifyAppAttestationToken = false,
  });

  /// Whether the Apple App Attest key id from the request exists on the server. `None` when the request did not contain a key id.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? appleAppAttestKeyExists;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? challenge;

  bool error;

  bool errorInvalidVerifyAppAttestationToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestAppAttestChallengeResult &&
    other.appleAppAttestKeyExists == appleAppAttestKeyExists &&
    other.challenge == challenge &&
    other.error == error &&
    other.errorInvalidVerifyAppAttestationToken == errorInvalidVerifyAppAttestationToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (appleAppAttestKeyExists == null ? 0 : appleAppAttestKeyExists!.hashCode) +
    (challenge == null ? 0 : challenge!.hashCode) +
    (error.hashCode) +
    (errorInvalidVerifyAppAttestationToken.hashCode);

  @override
  String toString() => 'RequestAppAttestChallengeResult[appleAppAttestKeyExists=$appleAppAttestKeyExists, challenge=$challenge, error=$error, errorInvalidVerifyAppAttestationToken=$errorInvalidVerifyAppAttestationToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.appleAppAttestKeyExists != null) {
      json[r'apple_app_attest_key_exists'] = this.appleAppAttestKeyExists;
    } else {
      json[r'apple_app_attest_key_exists'] = null;
    }
    if (this.challenge != null) {
      json[r'challenge'] = this.challenge;
    } else {
      json[r'challenge'] = null;
    }
      json[r'error'] = this.error;
      json[r'error_invalid_verify_app_attestation_token'] = this.errorInvalidVerifyAppAttestationToken;
    return json;
  }

  /// Returns a new [RequestAppAttestChallengeResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RequestAppAttestChallengeResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return RequestAppAttestChallengeResult(
        appleAppAttestKeyExists: mapValueOfType<bool>(json, r'apple_app_attest_key_exists'),
        challenge: mapValueOfType<String>(json, r'challenge'),
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorInvalidVerifyAppAttestationToken: mapValueOfType<bool>(json, r'error_invalid_verify_app_attestation_token') ?? false,
      );
    }
    return null;
  }

  static List<RequestAppAttestChallengeResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RequestAppAttestChallengeResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RequestAppAttestChallengeResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RequestAppAttestChallengeResult> mapFromJson(dynamic json) {
    final map = <String, RequestAppAttestChallengeResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RequestAppAttestChallengeResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RequestAppAttestChallengeResult-objects as value to a dart map
  static Map<String, List<RequestAppAttestChallengeResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RequestAppAttestChallengeResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RequestAppAttestChallengeResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

