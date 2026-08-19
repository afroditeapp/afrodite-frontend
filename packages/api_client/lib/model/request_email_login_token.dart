//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RequestEmailLoginToken {
  /// Returns a new [RequestEmailLoginToken] instance.
  RequestEmailLoginToken({
    required this.clientType,
    required this.email,
    this.language,
    this.loginOnly = false,
  });

  ClientType clientType;

  String email;

  /// Preferred language for token emails. If `None`, the default language is used.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ClientLanguage? language;

  /// Use this to bypass [LoginResult::error_email_registration_ip_address_limit_reached] when user wants to login to existing account.
  bool loginOnly;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestEmailLoginToken &&
    other.clientType == clientType &&
    other.email == email &&
    other.language == language &&
    other.loginOnly == loginOnly;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (clientType.hashCode) +
    (email.hashCode) +
    (language == null ? 0 : language!.hashCode) +
    (loginOnly.hashCode);

  @override
  String toString() => 'RequestEmailLoginToken[clientType=$clientType, email=$email, language=$language, loginOnly=$loginOnly]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'client_type'] = this.clientType;
      json[r'email'] = this.email;
    if (this.language != null) {
      json[r'language'] = this.language;
    } else {
      json[r'language'] = null;
    }
      json[r'login_only'] = this.loginOnly;
    return json;
  }

  /// Returns a new [RequestEmailLoginToken] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RequestEmailLoginToken? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'client_type'), 'Required key "RequestEmailLoginToken[client_type]" is missing from JSON.');
        assert(json[r'client_type'] != null, 'Required key "RequestEmailLoginToken[client_type]" has a null value in JSON.');
        assert(json.containsKey(r'email'), 'Required key "RequestEmailLoginToken[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "RequestEmailLoginToken[email]" has a null value in JSON.');
        return true;
      }());

      return RequestEmailLoginToken(
        clientType: ClientType.fromJson(json[r'client_type'])!,
        email: mapValueOfType<String>(json, r'email')!,
        language: ClientLanguage.fromJson(json[r'language']),
        loginOnly: mapValueOfType<bool>(json, r'login_only') ?? false,
      );
    }
    return null;
  }

  static List<RequestEmailLoginToken> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RequestEmailLoginToken>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RequestEmailLoginToken.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RequestEmailLoginToken> mapFromJson(dynamic json) {
    final map = <String, RequestEmailLoginToken>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RequestEmailLoginToken.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RequestEmailLoginToken-objects as value to a dart map
  static Map<String, List<RequestEmailLoginToken>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RequestEmailLoginToken>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RequestEmailLoginToken.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'client_type',
    'email',
  };
}

