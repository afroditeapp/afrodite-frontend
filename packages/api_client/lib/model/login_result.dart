//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginResult {
  /// Returns a new [LoginResult] instance.
  LoginResult({
    this.aid,
    this.email,
    this.errorSignInWithEmailUnverified = false,
    this.errorUnsupportedClient = false,
    this.tokens,
  });

  /// Account ID of current account. If `None`, the client is unsupported.
  AccountId? aid;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  bool errorSignInWithEmailUnverified;

  bool errorUnsupportedClient;

  /// If `None`, the client is unsupported.
  AuthPair? tokens;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginResult &&
    other.aid == aid &&
    other.email == email &&
    other.errorSignInWithEmailUnverified == errorSignInWithEmailUnverified &&
    other.errorUnsupportedClient == errorUnsupportedClient &&
    other.tokens == tokens;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid == null ? 0 : aid!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (errorSignInWithEmailUnverified.hashCode) +
    (errorUnsupportedClient.hashCode) +
    (tokens == null ? 0 : tokens!.hashCode);

  @override
  String toString() => 'LoginResult[aid=$aid, email=$email, errorSignInWithEmailUnverified=$errorSignInWithEmailUnverified, errorUnsupportedClient=$errorUnsupportedClient, tokens=$tokens]';

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
      json[r'error_sign_in_with_email_unverified'] = this.errorSignInWithEmailUnverified;
      json[r'error_unsupported_client'] = this.errorUnsupportedClient;
    if (this.tokens != null) {
      json[r'tokens'] = this.tokens;
    } else {
      json[r'tokens'] = null;
    }
    return json;
  }

  /// Returns a new [LoginResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LoginResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LoginResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LoginResult(
        aid: AccountId.fromJson(json[r'aid']),
        email: mapValueOfType<String>(json, r'email'),
        errorSignInWithEmailUnverified: mapValueOfType<bool>(json, r'error_sign_in_with_email_unverified') ?? false,
        errorUnsupportedClient: mapValueOfType<bool>(json, r'error_unsupported_client') ?? false,
        tokens: AuthPair.fromJson(json[r'tokens']),
      );
    }
    return null;
  }

  static List<LoginResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginResult> mapFromJson(dynamic json) {
    final map = <String, LoginResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginResult-objects as value to a dart map
  static Map<String, List<LoginResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

