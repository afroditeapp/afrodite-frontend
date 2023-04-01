//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountId {
  /// Returns a new [AccountId] instance.
  AccountId({
    required this.accountId,
    required this.light,
  });

  /// UUID string with Simple format.
  String accountId;

  AccountIdLight light;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountId &&
     other.accountId == accountId &&
     other.light == light;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (light.hashCode);

  @override
  String toString() => 'AccountId[accountId=$accountId, light=$light]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'light'] = this.light;
    return json;
  }

  /// Returns a new [AccountId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountId[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountId[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountId(
        accountId: mapValueOfType<String>(json, r'account_id')!,
        light: AccountIdLight.fromJson(json[r'light'])!,
      );
    }
    return null;
  }

  static List<AccountId>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountId> mapFromJson(dynamic json) {
    final map = <String, AccountId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountId-objects as value to a dart map
  static Map<String, List<AccountId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountId>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountId.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'light',
  };
}

