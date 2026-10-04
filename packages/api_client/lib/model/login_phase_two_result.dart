//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginPhaseTwoResult {
  /// Returns a new [LoginPhaseTwoResult] instance.
  LoginPhaseTwoResult({
    this.aid,
    this.email,
    this.error = false,
    this.errorAccountLocked = false,
    this.errorAppAttestationAppIntegrity = false,
    this.errorAppAttestationDeviceIntegrity = false,
    this.errorAppAttestationFailed = false,
    this.errorInvalidVerifyAppAttestationToken = false,
    this.tokens,
  });

  /// Account ID of current account. If `None`, the client is unsupported.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountId? aid;

  /// Current email of current account. If `None`, if email address is not set or the client version is unsupported.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  bool error;

  bool errorAccountLocked;

  bool errorAppAttestationAppIntegrity;

  bool errorAppAttestationDeviceIntegrity;

  bool errorAppAttestationFailed;

  bool errorInvalidVerifyAppAttestationToken;

  /// If `None`, the client is unsupported.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AuthPair? tokens;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginPhaseTwoResult &&
    other.aid == aid &&
    other.email == email &&
    other.error == error &&
    other.errorAccountLocked == errorAccountLocked &&
    other.errorAppAttestationAppIntegrity == errorAppAttestationAppIntegrity &&
    other.errorAppAttestationDeviceIntegrity == errorAppAttestationDeviceIntegrity &&
    other.errorAppAttestationFailed == errorAppAttestationFailed &&
    other.errorInvalidVerifyAppAttestationToken == errorInvalidVerifyAppAttestationToken &&
    other.tokens == tokens;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid == null ? 0 : aid!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (error.hashCode) +
    (errorAccountLocked.hashCode) +
    (errorAppAttestationAppIntegrity.hashCode) +
    (errorAppAttestationDeviceIntegrity.hashCode) +
    (errorAppAttestationFailed.hashCode) +
    (errorInvalidVerifyAppAttestationToken.hashCode) +
    (tokens == null ? 0 : tokens!.hashCode);

  @override
  String toString() => 'LoginPhaseTwoResult[aid=$aid, email=$email, error=$error, errorAccountLocked=$errorAccountLocked, errorAppAttestationAppIntegrity=$errorAppAttestationAppIntegrity, errorAppAttestationDeviceIntegrity=$errorAppAttestationDeviceIntegrity, errorAppAttestationFailed=$errorAppAttestationFailed, errorInvalidVerifyAppAttestationToken=$errorInvalidVerifyAppAttestationToken, tokens=$tokens]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.aid != null) {
      json[r'aid'] = this.aid;
    } else {
      json[r'aid'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
      json[r'error'] = this.error;
      json[r'error_account_locked'] = this.errorAccountLocked;
      json[r'error_app_attestation_app_integrity'] = this.errorAppAttestationAppIntegrity;
      json[r'error_app_attestation_device_integrity'] = this.errorAppAttestationDeviceIntegrity;
      json[r'error_app_attestation_failed'] = this.errorAppAttestationFailed;
      json[r'error_invalid_verify_app_attestation_token'] = this.errorInvalidVerifyAppAttestationToken;
    if (this.tokens != null) {
      json[r'tokens'] = this.tokens;
    } else {
      json[r'tokens'] = null;
    }
    return json;
  }

  /// Returns a new [LoginPhaseTwoResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginPhaseTwoResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return LoginPhaseTwoResult(
        aid: AccountId.fromJson(json[r'aid']),
        email: mapValueOfType<String>(json, r'email'),
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorAccountLocked: mapValueOfType<bool>(json, r'error_account_locked') ?? false,
        errorAppAttestationAppIntegrity: mapValueOfType<bool>(json, r'error_app_attestation_app_integrity') ?? false,
        errorAppAttestationDeviceIntegrity: mapValueOfType<bool>(json, r'error_app_attestation_device_integrity') ?? false,
        errorAppAttestationFailed: mapValueOfType<bool>(json, r'error_app_attestation_failed') ?? false,
        errorInvalidVerifyAppAttestationToken: mapValueOfType<bool>(json, r'error_invalid_verify_app_attestation_token') ?? false,
        tokens: AuthPair.fromJson(json[r'tokens']),
      );
    }
    return null;
  }

  static List<LoginPhaseTwoResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginPhaseTwoResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginPhaseTwoResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginPhaseTwoResult> mapFromJson(dynamic json) {
    final map = <String, LoginPhaseTwoResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginPhaseTwoResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginPhaseTwoResult-objects as value to a dart map
  static Map<String, List<LoginPhaseTwoResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginPhaseTwoResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginPhaseTwoResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

