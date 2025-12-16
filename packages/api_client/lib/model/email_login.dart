//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EmailLogin {
  /// Returns a new [EmailLogin] instance.
  EmailLogin({
    required this.clientInfo,
    required this.clientToken,
    required this.emailToken,
  });

  ClientInfo clientInfo;

  EmailLoginToken clientToken;

  EmailLoginToken emailToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailLogin &&
    other.clientInfo == clientInfo &&
    other.clientToken == clientToken &&
    other.emailToken == emailToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (clientInfo.hashCode) +
    (clientToken.hashCode) +
    (emailToken.hashCode);

  @override
  String toString() => 'EmailLogin[clientInfo=$clientInfo, clientToken=$clientToken, emailToken=$emailToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'client_info'] = this.clientInfo;
      json[r'client_token'] = this.clientToken;
      json[r'email_token'] = this.emailToken;
    return json;
  }

  /// Returns a new [EmailLogin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailLogin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EmailLogin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EmailLogin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EmailLogin(
        clientInfo: ClientInfo.fromJson(json[r'client_info'])!,
        clientToken: EmailLoginToken.fromJson(json[r'client_token'])!,
        emailToken: EmailLoginToken.fromJson(json[r'email_token'])!,
      );
    }
    return null;
  }

  static List<EmailLogin> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailLogin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailLogin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailLogin> mapFromJson(dynamic json) {
    final map = <String, EmailLogin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailLogin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailLogin-objects as value to a dart map
  static Map<String, List<EmailLogin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailLogin>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailLogin.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'client_info',
    'client_token',
    'email_token',
  };
}

