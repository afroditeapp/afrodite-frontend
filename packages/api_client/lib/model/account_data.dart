//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountData {
  /// Returns a new [AccountData] instance.
  AccountData({
    this.email,
    this.emailChange,
    this.emailChangeCompletionTime,
    this.emailChangeVerified = false,
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

  /// API route handler sets this value
  UnixTime? emailChangeCompletionTime;

  bool emailChangeVerified;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountData &&
    other.email == email &&
    other.emailChange == emailChange &&
    other.emailChangeCompletionTime == emailChangeCompletionTime &&
    other.emailChangeVerified == emailChangeVerified;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email == null ? 0 : email!.hashCode) +
    (emailChange == null ? 0 : emailChange!.hashCode) +
    (emailChangeCompletionTime == null ? 0 : emailChangeCompletionTime!.hashCode) +
    (emailChangeVerified.hashCode);

  @override
  String toString() => 'AccountData[email=$email, emailChange=$emailChange, emailChangeCompletionTime=$emailChangeCompletionTime, emailChangeVerified=$emailChangeVerified]';

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
    if (this.emailChangeCompletionTime != null) {
      json[r'email_change_completion_time'] = this.emailChangeCompletionTime;
    } else {
      json[r'email_change_completion_time'] = null;
    }
      json[r'email_change_verified'] = this.emailChangeVerified;
    return json;
  }

  /// Returns a new [AccountData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountData(
        email: mapValueOfType<String>(json, r'email'),
        emailChange: mapValueOfType<String>(json, r'email_change'),
        emailChangeCompletionTime: UnixTime.fromJson(json[r'email_change_completion_time']),
        emailChangeVerified: mapValueOfType<bool>(json, r'email_change_verified') ?? false,
      );
    }
    return null;
  }

  static List<AccountData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountData> mapFromJson(dynamic json) {
    final map = <String, AccountData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountData-objects as value to a dart map
  static Map<String, List<AccountData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

