//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EmailAddressStateAdmin {
  /// Returns a new [EmailAddressStateAdmin] instance.
  EmailAddressStateAdmin({
    this.email,
    this.emailChange,
    this.emailChangeVerified = false,
    this.emailLoginEnabled = true,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? emailChange;

  bool emailChangeVerified;

  bool emailLoginEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailAddressStateAdmin &&
    other.email == email &&
    other.emailChange == emailChange &&
    other.emailChangeVerified == emailChangeVerified &&
    other.emailLoginEnabled == emailLoginEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email == null ? 0 : email!.hashCode) +
    (emailChange == null ? 0 : emailChange!.hashCode) +
    (emailChangeVerified.hashCode) +
    (emailLoginEnabled.hashCode);

  @override
  String toString() => 'EmailAddressStateAdmin[email=$email, emailChange=$emailChange, emailChangeVerified=$emailChangeVerified, emailLoginEnabled=$emailLoginEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.emailChange != null) {
      json[r'email_change'] = this.emailChange;
    } else {
      json[r'email_change'] = null;
    }
      json[r'email_change_verified'] = this.emailChangeVerified;
      json[r'email_login_enabled'] = this.emailLoginEnabled;
    return json;
  }

  /// Returns a new [EmailAddressStateAdmin] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailAddressStateAdmin? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EmailAddressStateAdmin[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EmailAddressStateAdmin[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EmailAddressStateAdmin(
        email: mapValueOfType<String>(json, r'email'),
        emailChange: mapValueOfType<String>(json, r'email_change'),
        emailChangeVerified: mapValueOfType<bool>(json, r'email_change_verified') ?? false,
        emailLoginEnabled: mapValueOfType<bool>(json, r'email_login_enabled') ?? true,
      );
    }
    return null;
  }

  static List<EmailAddressStateAdmin> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailAddressStateAdmin>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailAddressStateAdmin.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailAddressStateAdmin> mapFromJson(dynamic json) {
    final map = <String, EmailAddressStateAdmin>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailAddressStateAdmin.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailAddressStateAdmin-objects as value to a dart map
  static Map<String, List<EmailAddressStateAdmin>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailAddressStateAdmin>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailAddressStateAdmin.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

