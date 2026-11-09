//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountExtraInfoSettings {
  /// Returns a new [AccountExtraInfoSettings] instance.
  AccountExtraInfoSettings({
    this.accountOnline = false,
    this.accountState = false,
    this.emailAddress = false,
    this.loginSessionAppAttestationInfo = false,
    this.loginSessionClientType = false,
    this.loginSessionIpCountry = false,
    this.loginSessionLoginMethod = false,
    this.profileVisibility = false,
  });

  bool accountOnline;

  bool accountState;

  bool emailAddress;

  bool loginSessionAppAttestationInfo;

  bool loginSessionClientType;

  bool loginSessionIpCountry;

  bool loginSessionLoginMethod;

  bool profileVisibility;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountExtraInfoSettings &&
    other.accountOnline == accountOnline &&
    other.accountState == accountState &&
    other.emailAddress == emailAddress &&
    other.loginSessionAppAttestationInfo == loginSessionAppAttestationInfo &&
    other.loginSessionClientType == loginSessionClientType &&
    other.loginSessionIpCountry == loginSessionIpCountry &&
    other.loginSessionLoginMethod == loginSessionLoginMethod &&
    other.profileVisibility == profileVisibility;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountOnline.hashCode) +
    (accountState.hashCode) +
    (emailAddress.hashCode) +
    (loginSessionAppAttestationInfo.hashCode) +
    (loginSessionClientType.hashCode) +
    (loginSessionIpCountry.hashCode) +
    (loginSessionLoginMethod.hashCode) +
    (profileVisibility.hashCode);

  @override
  String toString() => 'AccountExtraInfoSettings[accountOnline=$accountOnline, accountState=$accountState, emailAddress=$emailAddress, loginSessionAppAttestationInfo=$loginSessionAppAttestationInfo, loginSessionClientType=$loginSessionClientType, loginSessionIpCountry=$loginSessionIpCountry, loginSessionLoginMethod=$loginSessionLoginMethod, profileVisibility=$profileVisibility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_online'] = this.accountOnline;
      json[r'account_state'] = this.accountState;
      json[r'email_address'] = this.emailAddress;
      json[r'login_session_app_attestation_info'] = this.loginSessionAppAttestationInfo;
      json[r'login_session_client_type'] = this.loginSessionClientType;
      json[r'login_session_ip_country'] = this.loginSessionIpCountry;
      json[r'login_session_login_method'] = this.loginSessionLoginMethod;
      json[r'profile_visibility'] = this.profileVisibility;
    return json;
  }

  /// Returns a new [AccountExtraInfoSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountExtraInfoSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return AccountExtraInfoSettings(
        accountOnline: mapValueOfType<bool>(json, r'account_online') ?? false,
        accountState: mapValueOfType<bool>(json, r'account_state') ?? false,
        emailAddress: mapValueOfType<bool>(json, r'email_address') ?? false,
        loginSessionAppAttestationInfo: mapValueOfType<bool>(json, r'login_session_app_attestation_info') ?? false,
        loginSessionClientType: mapValueOfType<bool>(json, r'login_session_client_type') ?? false,
        loginSessionIpCountry: mapValueOfType<bool>(json, r'login_session_ip_country') ?? false,
        loginSessionLoginMethod: mapValueOfType<bool>(json, r'login_session_login_method') ?? false,
        profileVisibility: mapValueOfType<bool>(json, r'profile_visibility') ?? false,
      );
    }
    return null;
  }

  static List<AccountExtraInfoSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountExtraInfoSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountExtraInfoSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountExtraInfoSettings> mapFromJson(dynamic json) {
    final map = <String, AccountExtraInfoSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountExtraInfoSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountExtraInfoSettings-objects as value to a dart map
  static Map<String, List<AccountExtraInfoSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountExtraInfoSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountExtraInfoSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

