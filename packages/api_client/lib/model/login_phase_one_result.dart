//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginPhaseOneResult {
  /// Returns a new [LoginPhaseOneResult] instance.
  LoginPhaseOneResult({
    this.aid,
    this.error = false,
    this.errorEmailAlreadyUsed = false,
    this.errorInvalidEmailLoginToken = false,
    this.errorLoginAllPlatformsDisabled = false,
    this.errorLoginPlatformDisabled = false,
    this.errorRegistrationAllPlatformsDisabled = false,
    this.errorRegistrationPlatformDisabled = false,
    this.errorSignInWithEmailUnverified = false,
    this.errorUnsupportedClient = false,
    this.verifyAppAttestationToken,
  });

  /// Account ID of current account. If `None`, the client is unsupported.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountId? aid;

  bool error;

  /// This might be true, when registering new account using sign in with login method.
  bool errorEmailAlreadyUsed;

  bool errorInvalidEmailLoginToken;

  bool errorLoginAllPlatformsDisabled;

  bool errorLoginPlatformDisabled;

  bool errorRegistrationAllPlatformsDisabled;

  bool errorRegistrationPlatformDisabled;

  bool errorSignInWithEmailUnverified;

  bool errorUnsupportedClient;

  /// When set, the login is not complete yet. The client must call `post_verify_app_attestation` with this token and a valid app attestation to complete the login.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LoginPhaseTwoToken? verifyAppAttestationToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginPhaseOneResult &&
    other.aid == aid &&
    other.error == error &&
    other.errorEmailAlreadyUsed == errorEmailAlreadyUsed &&
    other.errorInvalidEmailLoginToken == errorInvalidEmailLoginToken &&
    other.errorLoginAllPlatformsDisabled == errorLoginAllPlatformsDisabled &&
    other.errorLoginPlatformDisabled == errorLoginPlatformDisabled &&
    other.errorRegistrationAllPlatformsDisabled == errorRegistrationAllPlatformsDisabled &&
    other.errorRegistrationPlatformDisabled == errorRegistrationPlatformDisabled &&
    other.errorSignInWithEmailUnverified == errorSignInWithEmailUnverified &&
    other.errorUnsupportedClient == errorUnsupportedClient &&
    other.verifyAppAttestationToken == verifyAppAttestationToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid == null ? 0 : aid!.hashCode) +
    (error.hashCode) +
    (errorEmailAlreadyUsed.hashCode) +
    (errorInvalidEmailLoginToken.hashCode) +
    (errorLoginAllPlatformsDisabled.hashCode) +
    (errorLoginPlatformDisabled.hashCode) +
    (errorRegistrationAllPlatformsDisabled.hashCode) +
    (errorRegistrationPlatformDisabled.hashCode) +
    (errorSignInWithEmailUnverified.hashCode) +
    (errorUnsupportedClient.hashCode) +
    (verifyAppAttestationToken == null ? 0 : verifyAppAttestationToken!.hashCode);

  @override
  String toString() => 'LoginPhaseOneResult[aid=$aid, error=$error, errorEmailAlreadyUsed=$errorEmailAlreadyUsed, errorInvalidEmailLoginToken=$errorInvalidEmailLoginToken, errorLoginAllPlatformsDisabled=$errorLoginAllPlatformsDisabled, errorLoginPlatformDisabled=$errorLoginPlatformDisabled, errorRegistrationAllPlatformsDisabled=$errorRegistrationAllPlatformsDisabled, errorRegistrationPlatformDisabled=$errorRegistrationPlatformDisabled, errorSignInWithEmailUnverified=$errorSignInWithEmailUnverified, errorUnsupportedClient=$errorUnsupportedClient, verifyAppAttestationToken=$verifyAppAttestationToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.aid != null) {
      json[r'aid'] = this.aid;
    } else {
      json[r'aid'] = null;
    }
      json[r'error'] = this.error;
      json[r'error_email_already_used'] = this.errorEmailAlreadyUsed;
      json[r'error_invalid_email_login_token'] = this.errorInvalidEmailLoginToken;
      json[r'error_login_all_platforms_disabled'] = this.errorLoginAllPlatformsDisabled;
      json[r'error_login_platform_disabled'] = this.errorLoginPlatformDisabled;
      json[r'error_registration_all_platforms_disabled'] = this.errorRegistrationAllPlatformsDisabled;
      json[r'error_registration_platform_disabled'] = this.errorRegistrationPlatformDisabled;
      json[r'error_sign_in_with_email_unverified'] = this.errorSignInWithEmailUnverified;
      json[r'error_unsupported_client'] = this.errorUnsupportedClient;
    if (this.verifyAppAttestationToken != null) {
      json[r'verify_app_attestation_token'] = this.verifyAppAttestationToken;
    } else {
      json[r'verify_app_attestation_token'] = null;
    }
    return json;
  }

  /// Returns a new [LoginPhaseOneResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginPhaseOneResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return LoginPhaseOneResult(
        aid: AccountId.fromJson(json[r'aid']),
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorEmailAlreadyUsed: mapValueOfType<bool>(json, r'error_email_already_used') ?? false,
        errorInvalidEmailLoginToken: mapValueOfType<bool>(json, r'error_invalid_email_login_token') ?? false,
        errorLoginAllPlatformsDisabled: mapValueOfType<bool>(json, r'error_login_all_platforms_disabled') ?? false,
        errorLoginPlatformDisabled: mapValueOfType<bool>(json, r'error_login_platform_disabled') ?? false,
        errorRegistrationAllPlatformsDisabled: mapValueOfType<bool>(json, r'error_registration_all_platforms_disabled') ?? false,
        errorRegistrationPlatformDisabled: mapValueOfType<bool>(json, r'error_registration_platform_disabled') ?? false,
        errorSignInWithEmailUnverified: mapValueOfType<bool>(json, r'error_sign_in_with_email_unverified') ?? false,
        errorUnsupportedClient: mapValueOfType<bool>(json, r'error_unsupported_client') ?? false,
        verifyAppAttestationToken: LoginPhaseTwoToken.fromJson(json[r'verify_app_attestation_token']),
      );
    }
    return null;
  }

  static List<LoginPhaseOneResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginPhaseOneResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginPhaseOneResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginPhaseOneResult> mapFromJson(dynamic json) {
    final map = <String, LoginPhaseOneResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginPhaseOneResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginPhaseOneResult-objects as value to a dart map
  static Map<String, List<LoginPhaseOneResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginPhaseOneResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginPhaseOneResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

