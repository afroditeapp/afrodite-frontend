//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileIteratorPageValue {
  /// Returns a new [ProfileIteratorPageValue] instance.
  ProfileIteratorPageValue({
    required this.accountId,
    this.accountOnline,
    this.accountState,
    required this.age,
    this.email,
    this.loginSession,
    this.loginSessionIpCountry,
    this.name,
    this.profileVisibility,
  });

  AccountId accountId;

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

  int age;

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
  AdminAccountLoginSessionInfo? loginSession;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? loginSessionIpCountry;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ProfileVisibility? profileVisibility;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileIteratorPageValue &&
    other.accountId == accountId &&
    other.accountOnline == accountOnline &&
    other.accountState == accountState &&
    other.age == age &&
    other.email == email &&
    other.loginSession == loginSession &&
    other.loginSessionIpCountry == loginSessionIpCountry &&
    other.name == name &&
    other.profileVisibility == profileVisibility;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (accountOnline == null ? 0 : accountOnline!.hashCode) +
    (accountState == null ? 0 : accountState!.hashCode) +
    (age.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (loginSession == null ? 0 : loginSession!.hashCode) +
    (loginSessionIpCountry == null ? 0 : loginSessionIpCountry!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (profileVisibility == null ? 0 : profileVisibility!.hashCode);

  @override
  String toString() => 'ProfileIteratorPageValue[accountId=$accountId, accountOnline=$accountOnline, accountState=$accountState, age=$age, email=$email, loginSession=$loginSession, loginSessionIpCountry=$loginSessionIpCountry, name=$name, profileVisibility=$profileVisibility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
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
      json[r'age'] = this.age;
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    if (this.loginSession != null) {
      json[r'login_session'] = this.loginSession;
    } else {
      json[r'login_session'] = null;
    }
    if (this.loginSessionIpCountry != null) {
      json[r'login_session_ip_country'] = this.loginSessionIpCountry;
    } else {
      json[r'login_session_ip_country'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.profileVisibility != null) {
      json[r'profile_visibility'] = this.profileVisibility;
    } else {
      json[r'profile_visibility'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileIteratorPageValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileIteratorPageValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'account_id'), 'Required key "ProfileIteratorPageValue[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "ProfileIteratorPageValue[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'age'), 'Required key "ProfileIteratorPageValue[age]" is missing from JSON.');
        assert(json[r'age'] != null, 'Required key "ProfileIteratorPageValue[age]" has a null value in JSON.');
        return true;
      }());

      return ProfileIteratorPageValue(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        accountOnline: mapValueOfType<bool>(json, r'account_online'),
        accountState: AccountState.fromJson(json[r'account_state']),
        age: mapValueOfType<int>(json, r'age')!,
        email: mapValueOfType<String>(json, r'email'),
        loginSession: AdminAccountLoginSessionInfo.fromJson(json[r'login_session']),
        loginSessionIpCountry: mapValueOfType<String>(json, r'login_session_ip_country'),
        name: mapValueOfType<String>(json, r'name'),
        profileVisibility: ProfileVisibility.fromJson(json[r'profile_visibility']),
      );
    }
    return null;
  }

  static List<ProfileIteratorPageValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileIteratorPageValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileIteratorPageValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileIteratorPageValue> mapFromJson(dynamic json) {
    final map = <String, ProfileIteratorPageValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileIteratorPageValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileIteratorPageValue-objects as value to a dart map
  static Map<String, List<ProfileIteratorPageValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileIteratorPageValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileIteratorPageValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'age',
  };
}

