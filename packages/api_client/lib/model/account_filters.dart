//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountFilters {
  /// Returns a new [AccountFilters] instance.
  AccountFilters({
    this.accountOnline,
    this.accountState,
    this.loginSessionBasicAppAttestationValidity,
    this.loginSessionIpCountryIsNot,
    this.profileVisibility,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? accountOnline;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountState? accountState;

  /// Includes accounts whose latest login session basic app attestation validity matches the provided value. Valid basic app attestation means valid iOS app attestation token or valid Android app and device integrity values. Accounts without a login session are included when the value is false.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? loginSessionBasicAppAttestationValidity;

  /// Includes accounts whose latest login session IP country is not the provided country code.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? loginSessionIpCountryIsNot;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ProfileVisibility? profileVisibility;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountFilters &&
    other.accountOnline == accountOnline &&
    other.accountState == accountState &&
    other.loginSessionBasicAppAttestationValidity == loginSessionBasicAppAttestationValidity &&
    other.loginSessionIpCountryIsNot == loginSessionIpCountryIsNot &&
    other.profileVisibility == profileVisibility;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountOnline == null ? 0 : accountOnline!.hashCode) +
    (accountState == null ? 0 : accountState!.hashCode) +
    (loginSessionBasicAppAttestationValidity == null ? 0 : loginSessionBasicAppAttestationValidity!.hashCode) +
    (loginSessionIpCountryIsNot == null ? 0 : loginSessionIpCountryIsNot!.hashCode) +
    (profileVisibility == null ? 0 : profileVisibility!.hashCode);

  @override
  String toString() => 'AccountFilters[accountOnline=$accountOnline, accountState=$accountState, loginSessionBasicAppAttestationValidity=$loginSessionBasicAppAttestationValidity, loginSessionIpCountryIsNot=$loginSessionIpCountryIsNot, profileVisibility=$profileVisibility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accountOnline != null) {
      json[r'account_online'] = this.accountOnline;
    } else {
      json[r'account_online'] = null;
    }
    if (this.accountState != null) {
      json[r'account_state'] = this.accountState;
    } else {
      json[r'account_state'] = null;
    }
    if (this.loginSessionBasicAppAttestationValidity != null) {
      json[r'login_session_basic_app_attestation_validity'] = this.loginSessionBasicAppAttestationValidity;
    } else {
      json[r'login_session_basic_app_attestation_validity'] = null;
    }
    if (this.loginSessionIpCountryIsNot != null) {
      json[r'login_session_ip_country_is_not'] = this.loginSessionIpCountryIsNot;
    } else {
      json[r'login_session_ip_country_is_not'] = null;
    }
    if (this.profileVisibility != null) {
      json[r'profile_visibility'] = this.profileVisibility;
    } else {
      json[r'profile_visibility'] = null;
    }
    return json;
  }

  /// Returns a new [AccountFilters] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountFilters? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return AccountFilters(
        accountOnline: mapValueOfType<bool>(json, r'account_online'),
        accountState: AccountState.fromJson(json[r'account_state']),
        loginSessionBasicAppAttestationValidity: mapValueOfType<bool>(json, r'login_session_basic_app_attestation_validity'),
        loginSessionIpCountryIsNot: mapValueOfType<String>(json, r'login_session_ip_country_is_not'),
        profileVisibility: ProfileVisibility.fromJson(json[r'profile_visibility']),
      );
    }
    return null;
  }

  static List<AccountFilters> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountFilters>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountFilters.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountFilters> mapFromJson(dynamic json) {
    final map = <String, AccountFilters>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountFilters.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountFilters-objects as value to a dart map
  static Map<String, List<AccountFilters>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountFilters>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountFilters.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

