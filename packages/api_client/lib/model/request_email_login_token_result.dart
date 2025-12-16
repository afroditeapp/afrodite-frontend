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
    required this.clientToken,
    required this.resendWaitSeconds,
    required this.tokenValiditySeconds,
  });

  /// Client token to be used together with the email token. Always returned to prevent email enumeration attacks.
  EmailLoginToken clientToken;

  /// Minimum wait duration between token requests in seconds
  int resendWaitSeconds;

  /// Token validity duration in seconds
  int tokenValiditySeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestEmailLoginTokenResult &&
    other.clientToken == clientToken &&
    other.resendWaitSeconds == resendWaitSeconds &&
    other.tokenValiditySeconds == tokenValiditySeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (clientToken.hashCode) +
    (resendWaitSeconds.hashCode) +
    (tokenValiditySeconds.hashCode);

  @override
  String toString() => 'RequestEmailLoginTokenResult[clientToken=$clientToken, resendWaitSeconds=$resendWaitSeconds, tokenValiditySeconds=$tokenValiditySeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'client_token'] = this.clientToken;
      json[r'resend_wait_seconds'] = this.resendWaitSeconds;
      json[r'token_validity_seconds'] = this.tokenValiditySeconds;
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
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RequestEmailLoginTokenResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RequestEmailLoginTokenResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RequestEmailLoginTokenResult(
        clientToken: EmailLoginToken.fromJson(json[r'client_token'])!,
        resendWaitSeconds: mapValueOfType<int>(json, r'resend_wait_seconds')!,
        tokenValiditySeconds: mapValueOfType<int>(json, r'token_validity_seconds')!,
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
    'client_token',
    'resend_wait_seconds',
    'token_validity_seconds',
  };
}

