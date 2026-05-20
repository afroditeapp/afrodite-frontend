//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountVerificationConfig {
  /// Returns a new [AccountVerificationConfig] instance.
  AccountVerificationConfig({
    this.methods,
    this.scopes,
  });

  AccountVerificationMethodsConfig? methods;

  AccountVerificationScopesConfig? scopes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountVerificationConfig &&
    other.methods == methods &&
    other.scopes == scopes;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (methods == null ? 0 : methods!.hashCode) +
    (scopes == null ? 0 : scopes!.hashCode);

  @override
  String toString() => 'AccountVerificationConfig[methods=$methods, scopes=$scopes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.methods != null) {
      json[r'methods'] = this.methods;
    } else {
      json[r'methods'] = null;
    }
    if (this.scopes != null) {
      json[r'scopes'] = this.scopes;
    } else {
      json[r'scopes'] = null;
    }
    return json;
  }

  /// Returns a new [AccountVerificationConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountVerificationConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountVerificationConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountVerificationConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountVerificationConfig(
        methods: AccountVerificationMethodsConfig.fromJson(json[r'methods']),
        scopes: AccountVerificationScopesConfig.fromJson(json[r'scopes']),
      );
    }
    return null;
  }

  static List<AccountVerificationConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountVerificationConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountVerificationConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountVerificationConfig> mapFromJson(dynamic json) {
    final map = <String, AccountVerificationConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountVerificationConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountVerificationConfig-objects as value to a dart map
  static Map<String, List<AccountVerificationConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountVerificationConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountVerificationConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

