//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetAccountBanState {
  /// Returns a new [SetAccountBanState] instance.
  SetAccountBanState({
    required this.account,
    this.banUntil,
    this.reasonCategory,
    required this.reasonDetails,
  });

  AccountId account;

  /// `Some` value bans the account and `None` value unbans the account.
  UnixTime? banUntil;

  AccountBanReasonCategory? reasonCategory;

  AccountBanReasonDetails reasonDetails;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetAccountBanState &&
    other.account == account &&
    other.banUntil == banUntil &&
    other.reasonCategory == reasonCategory &&
    other.reasonDetails == reasonDetails;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (account.hashCode) +
    (banUntil == null ? 0 : banUntil!.hashCode) +
    (reasonCategory == null ? 0 : reasonCategory!.hashCode) +
    (reasonDetails.hashCode);

  @override
  String toString() => 'SetAccountBanState[account=$account, banUntil=$banUntil, reasonCategory=$reasonCategory, reasonDetails=$reasonDetails]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account'] = this.account;
    if (this.banUntil != null) {
      json[r'ban_until'] = this.banUntil;
    } else {
      json[r'ban_until'] = null;
    }
    if (this.reasonCategory != null) {
      json[r'reason_category'] = this.reasonCategory;
    } else {
      json[r'reason_category'] = null;
    }
      json[r'reason_details'] = this.reasonDetails;
    return json;
  }

  /// Returns a new [SetAccountBanState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetAccountBanState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetAccountBanState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetAccountBanState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetAccountBanState(
        account: AccountId.fromJson(json[r'account'])!,
        banUntil: UnixTime.fromJson(json[r'ban_until']),
        reasonCategory: AccountBanReasonCategory.fromJson(json[r'reason_category']),
        reasonDetails: AccountBanReasonDetails.fromJson(json[r'reason_details'])!,
      );
    }
    return null;
  }

  static List<SetAccountBanState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetAccountBanState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetAccountBanState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetAccountBanState> mapFromJson(dynamic json) {
    final map = <String, SetAccountBanState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetAccountBanState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetAccountBanState-objects as value to a dart map
  static Map<String, List<SetAccountBanState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetAccountBanState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetAccountBanState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account',
    'reason_details',
  };
}

