//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DynamicServerConfig {
  /// Returns a new [DynamicServerConfig] instance.
  DynamicServerConfig({
    this.accountLoginPlatforms,
    this.accountRegistrationPlatforms,
    this.emailRegistrationDomainLists,
    this.emailRegistrationPlatforms,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountLoginPlatforms? accountLoginPlatforms;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountRegistrationPlatforms? accountRegistrationPlatforms;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailRegistrationDomainLists? emailRegistrationDomainLists;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  EmailRegistrationPlatforms? emailRegistrationPlatforms;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DynamicServerConfig &&
    other.accountLoginPlatforms == accountLoginPlatforms &&
    other.accountRegistrationPlatforms == accountRegistrationPlatforms &&
    other.emailRegistrationDomainLists == emailRegistrationDomainLists &&
    other.emailRegistrationPlatforms == emailRegistrationPlatforms;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountLoginPlatforms == null ? 0 : accountLoginPlatforms!.hashCode) +
    (accountRegistrationPlatforms == null ? 0 : accountRegistrationPlatforms!.hashCode) +
    (emailRegistrationDomainLists == null ? 0 : emailRegistrationDomainLists!.hashCode) +
    (emailRegistrationPlatforms == null ? 0 : emailRegistrationPlatforms!.hashCode);

  @override
  String toString() => 'DynamicServerConfig[accountLoginPlatforms=$accountLoginPlatforms, accountRegistrationPlatforms=$accountRegistrationPlatforms, emailRegistrationDomainLists=$emailRegistrationDomainLists, emailRegistrationPlatforms=$emailRegistrationPlatforms]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accountLoginPlatforms != null) {
      json[r'account_login_platforms'] = this.accountLoginPlatforms;
    } else {
      json[r'account_login_platforms'] = null;
    }
    if (this.accountRegistrationPlatforms != null) {
      json[r'account_registration_platforms'] = this.accountRegistrationPlatforms;
    } else {
      json[r'account_registration_platforms'] = null;
    }
    if (this.emailRegistrationDomainLists != null) {
      json[r'email_registration_domain_lists'] = this.emailRegistrationDomainLists;
    } else {
      json[r'email_registration_domain_lists'] = null;
    }
    if (this.emailRegistrationPlatforms != null) {
      json[r'email_registration_platforms'] = this.emailRegistrationPlatforms;
    } else {
      json[r'email_registration_platforms'] = null;
    }
    return json;
  }

  /// Returns a new [DynamicServerConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DynamicServerConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return DynamicServerConfig(
        accountLoginPlatforms: AccountLoginPlatforms.fromJson(json[r'account_login_platforms']),
        accountRegistrationPlatforms: AccountRegistrationPlatforms.fromJson(json[r'account_registration_platforms']),
        emailRegistrationDomainLists: EmailRegistrationDomainLists.fromJson(json[r'email_registration_domain_lists']),
        emailRegistrationPlatforms: EmailRegistrationPlatforms.fromJson(json[r'email_registration_platforms']),
      );
    }
    return null;
  }

  static List<DynamicServerConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DynamicServerConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DynamicServerConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DynamicServerConfig> mapFromJson(dynamic json) {
    final map = <String, DynamicServerConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DynamicServerConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DynamicServerConfig-objects as value to a dart map
  static Map<String, List<DynamicServerConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DynamicServerConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DynamicServerConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

