//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RequestEmailLoginTokenResult {
  /// Returns a new [RequestEmailLoginTokenResult] instance.
  RequestEmailLoginTokenResult({
    this.clientToken,
    this.emailLoginEmailsPerMonth,
    this.error = false,
    this.errorEmailRegistrationAllPlatformsDisabled = false,
    this.errorEmailRegistrationDomainNotAccepted = false,
    this.errorEmailRegistrationIpAddressLimitReached = false,
    this.errorEmailRegistrationLimitReached = false,
    this.errorEmailRegistrationPlatformDisabled = false,
    this.errorEmailRegistrationUnsupportedEmail = false,
    this.resendWaitSeconds,
    this.tokenValiditySeconds,
  });

  /// Client token to be used together with the email token.
  EmailLoginToken? clientToken;

  /// Maximum number of email login tokens that can be sent per month.
  int? emailLoginEmailsPerMonth;

  bool error;

  /// This is true when email registration has been disabled for all client platforms.
  bool errorEmailRegistrationAllPlatformsDisabled;

  /// This is true when the email domain is not accepted for email registration. This can happen when the domain is in the blocklist or not in the allowlist configured by the server admin.
  bool errorEmailRegistrationDomainNotAccepted;

  bool errorEmailRegistrationIpAddressLimitReached;

  /// This is true when the daily email registration limit has been reached. The client should guide the user to wait 24 hours or use another login method for account registration.
  bool errorEmailRegistrationLimitReached;

  /// This is true when email registration has been disabled for the client platform the user is using.
  bool errorEmailRegistrationPlatformDisabled;

  /// This is true when the email address is not supported for email registration. This can happen for example when the email address contains characters that are not accepted for registration.
  bool errorEmailRegistrationUnsupportedEmail;

  /// Minimum wait duration between token requests in seconds
  int? resendWaitSeconds;

  /// Token validity duration in seconds
  int? tokenValiditySeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestEmailLoginTokenResult &&
    other.clientToken == clientToken &&
    other.emailLoginEmailsPerMonth == emailLoginEmailsPerMonth &&
    other.error == error &&
    other.errorEmailRegistrationAllPlatformsDisabled == errorEmailRegistrationAllPlatformsDisabled &&
    other.errorEmailRegistrationDomainNotAccepted == errorEmailRegistrationDomainNotAccepted &&
    other.errorEmailRegistrationIpAddressLimitReached == errorEmailRegistrationIpAddressLimitReached &&
    other.errorEmailRegistrationLimitReached == errorEmailRegistrationLimitReached &&
    other.errorEmailRegistrationPlatformDisabled == errorEmailRegistrationPlatformDisabled &&
    other.errorEmailRegistrationUnsupportedEmail == errorEmailRegistrationUnsupportedEmail &&
    other.resendWaitSeconds == resendWaitSeconds &&
    other.tokenValiditySeconds == tokenValiditySeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (clientToken == null ? 0 : clientToken!.hashCode) +
    (emailLoginEmailsPerMonth == null ? 0 : emailLoginEmailsPerMonth!.hashCode) +
    (error.hashCode) +
    (errorEmailRegistrationAllPlatformsDisabled.hashCode) +
    (errorEmailRegistrationDomainNotAccepted.hashCode) +
    (errorEmailRegistrationIpAddressLimitReached.hashCode) +
    (errorEmailRegistrationLimitReached.hashCode) +
    (errorEmailRegistrationPlatformDisabled.hashCode) +
    (errorEmailRegistrationUnsupportedEmail.hashCode) +
    (resendWaitSeconds == null ? 0 : resendWaitSeconds!.hashCode) +
    (tokenValiditySeconds == null ? 0 : tokenValiditySeconds!.hashCode);

  @override
  String toString() => 'RequestEmailLoginTokenResult[clientToken=$clientToken, emailLoginEmailsPerMonth=$emailLoginEmailsPerMonth, error=$error, errorEmailRegistrationAllPlatformsDisabled=$errorEmailRegistrationAllPlatformsDisabled, errorEmailRegistrationDomainNotAccepted=$errorEmailRegistrationDomainNotAccepted, errorEmailRegistrationIpAddressLimitReached=$errorEmailRegistrationIpAddressLimitReached, errorEmailRegistrationLimitReached=$errorEmailRegistrationLimitReached, errorEmailRegistrationPlatformDisabled=$errorEmailRegistrationPlatformDisabled, errorEmailRegistrationUnsupportedEmail=$errorEmailRegistrationUnsupportedEmail, resendWaitSeconds=$resendWaitSeconds, tokenValiditySeconds=$tokenValiditySeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.clientToken != null) {
      json[r'client_token'] = this.clientToken;
    } else {
      json[r'client_token'] = null;
    }
    if (this.emailLoginEmailsPerMonth != null) {
      json[r'email_login_emails_per_month'] = this.emailLoginEmailsPerMonth;
    } else {
      json[r'email_login_emails_per_month'] = null;
    }
      json[r'error'] = this.error;
      json[r'error_email_registration_all_platforms_disabled'] = this.errorEmailRegistrationAllPlatformsDisabled;
      json[r'error_email_registration_domain_not_accepted'] = this.errorEmailRegistrationDomainNotAccepted;
      json[r'error_email_registration_ip_address_limit_reached'] = this.errorEmailRegistrationIpAddressLimitReached;
      json[r'error_email_registration_limit_reached'] = this.errorEmailRegistrationLimitReached;
      json[r'error_email_registration_platform_disabled'] = this.errorEmailRegistrationPlatformDisabled;
      json[r'error_email_registration_unsupported_email'] = this.errorEmailRegistrationUnsupportedEmail;
    if (this.resendWaitSeconds != null) {
      json[r'resend_wait_seconds'] = this.resendWaitSeconds;
    } else {
      json[r'resend_wait_seconds'] = null;
    }
    if (this.tokenValiditySeconds != null) {
      json[r'token_validity_seconds'] = this.tokenValiditySeconds;
    } else {
      json[r'token_validity_seconds'] = null;
    }
    return json;
  }

  /// Returns a new [RequestEmailLoginTokenResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RequestEmailLoginTokenResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return RequestEmailLoginTokenResult(
        clientToken: EmailLoginToken.fromJson(json[r'client_token']),
        emailLoginEmailsPerMonth: mapValueOfType<int>(json, r'email_login_emails_per_month'),
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorEmailRegistrationAllPlatformsDisabled: mapValueOfType<bool>(json, r'error_email_registration_all_platforms_disabled') ?? false,
        errorEmailRegistrationDomainNotAccepted: mapValueOfType<bool>(json, r'error_email_registration_domain_not_accepted') ?? false,
        errorEmailRegistrationIpAddressLimitReached: mapValueOfType<bool>(json, r'error_email_registration_ip_address_limit_reached') ?? false,
        errorEmailRegistrationLimitReached: mapValueOfType<bool>(json, r'error_email_registration_limit_reached') ?? false,
        errorEmailRegistrationPlatformDisabled: mapValueOfType<bool>(json, r'error_email_registration_platform_disabled') ?? false,
        errorEmailRegistrationUnsupportedEmail: mapValueOfType<bool>(json, r'error_email_registration_unsupported_email') ?? false,
        resendWaitSeconds: mapValueOfType<int>(json, r'resend_wait_seconds'),
        tokenValiditySeconds: mapValueOfType<int>(json, r'token_validity_seconds'),
      );
    }
    return null;
  }

  static List<RequestEmailLoginTokenResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RequestEmailLoginTokenResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RequestEmailLoginTokenResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RequestEmailLoginTokenResult> mapFromJson(dynamic json) {
    final map = <String, RequestEmailLoginTokenResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RequestEmailLoginTokenResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RequestEmailLoginTokenResult-objects as value to a dart map
  static Map<String, List<RequestEmailLoginTokenResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RequestEmailLoginTokenResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RequestEmailLoginTokenResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

