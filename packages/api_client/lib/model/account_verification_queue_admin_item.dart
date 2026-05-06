//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountVerificationQueueAdminItem {
  /// Returns a new [AccountVerificationQueueAdminItem] instance.
  AccountVerificationQueueAdminItem({
    required this.accountId,
    required this.verificationData,
    required this.verificationMethod,
  });

  AccountId accountId;

  String verificationData;

  String verificationMethod;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountVerificationQueueAdminItem &&
    other.accountId == accountId &&
    other.verificationData == verificationData &&
    other.verificationMethod == verificationMethod;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (verificationData.hashCode) +
    (verificationMethod.hashCode);

  @override
  String toString() => 'AccountVerificationQueueAdminItem[accountId=$accountId, verificationData=$verificationData, verificationMethod=$verificationMethod]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'verification_data'] = this.verificationData;
      json[r'verification_method'] = this.verificationMethod;
    return json;
  }

  /// Returns a new [AccountVerificationQueueAdminItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountVerificationQueueAdminItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountVerificationQueueAdminItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountVerificationQueueAdminItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountVerificationQueueAdminItem(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        verificationData: mapValueOfType<String>(json, r'verification_data')!,
        verificationMethod: mapValueOfType<String>(json, r'verification_method')!,
      );
    }
    return null;
  }

  static List<AccountVerificationQueueAdminItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountVerificationQueueAdminItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountVerificationQueueAdminItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountVerificationQueueAdminItem> mapFromJson(dynamic json) {
    final map = <String, AccountVerificationQueueAdminItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountVerificationQueueAdminItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountVerificationQueueAdminItem-objects as value to a dart map
  static Map<String, List<AccountVerificationQueueAdminItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountVerificationQueueAdminItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountVerificationQueueAdminItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'verification_data',
    'verification_method',
  };
}

