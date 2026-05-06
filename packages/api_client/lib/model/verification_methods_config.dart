//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VerificationMethodsConfig {
  /// Returns a new [VerificationMethodsConfig] instance.
  VerificationMethodsConfig({
    this.account,
  });

  AccountVerificationMethodsConfig? account;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerificationMethodsConfig &&
    other.account == account;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (account == null ? 0 : account!.hashCode);

  @override
  String toString() => 'VerificationMethodsConfig[account=$account]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.account != null) {
      json[r'account'] = this.account;
    } else {
      json[r'account'] = null;
    }
    return json;
  }

  /// Returns a new [VerificationMethodsConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerificationMethodsConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "VerificationMethodsConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "VerificationMethodsConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VerificationMethodsConfig(
        account: AccountVerificationMethodsConfig.fromJson(json[r'account']),
      );
    }
    return null;
  }

  static List<VerificationMethodsConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerificationMethodsConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerificationMethodsConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerificationMethodsConfig> mapFromJson(dynamic json) {
    final map = <String, VerificationMethodsConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerificationMethodsConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerificationMethodsConfig-objects as value to a dart map
  static Map<String, List<VerificationMethodsConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerificationMethodsConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerificationMethodsConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

