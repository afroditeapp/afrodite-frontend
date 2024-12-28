//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetAccountBanTimeResult {
  /// Returns a new [GetAccountBanTimeResult] instance.
  GetAccountBanTimeResult({
    this.bannedUntil,
    this.reasonCategory,
    this.reasonDetails,
  });

  /// If `None` the account is not banned.
  UnixTime? bannedUntil;

  AccountBanReasonCategory? reasonCategory;

  AccountBanReasonDetails? reasonDetails;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetAccountBanTimeResult &&
    other.bannedUntil == bannedUntil &&
    other.reasonCategory == reasonCategory &&
    other.reasonDetails == reasonDetails;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (bannedUntil == null ? 0 : bannedUntil!.hashCode) +
    (reasonCategory == null ? 0 : reasonCategory!.hashCode) +
    (reasonDetails == null ? 0 : reasonDetails!.hashCode);

  @override
  String toString() => 'GetAccountBanTimeResult[bannedUntil=$bannedUntil, reasonCategory=$reasonCategory, reasonDetails=$reasonDetails]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.bannedUntil != null) {
      json[r'banned_until'] = this.bannedUntil;
    } else {
      json[r'banned_until'] = null;
    }
    if (this.reasonCategory != null) {
      json[r'reason_category'] = this.reasonCategory;
    } else {
      json[r'reason_category'] = null;
    }
    if (this.reasonDetails != null) {
      json[r'reason_details'] = this.reasonDetails;
    } else {
      json[r'reason_details'] = null;
    }
    return json;
  }

  /// Returns a new [GetAccountBanTimeResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetAccountBanTimeResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetAccountBanTimeResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetAccountBanTimeResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetAccountBanTimeResult(
        bannedUntil: UnixTime.fromJson(json[r'banned_until']),
        reasonCategory: AccountBanReasonCategory.fromJson(json[r'reason_category']),
        reasonDetails: AccountBanReasonDetails.fromJson(json[r'reason_details']),
      );
    }
    return null;
  }

  static List<GetAccountBanTimeResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetAccountBanTimeResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetAccountBanTimeResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetAccountBanTimeResult> mapFromJson(dynamic json) {
    final map = <String, GetAccountBanTimeResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetAccountBanTimeResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetAccountBanTimeResult-objects as value to a dart map
  static Map<String, List<GetAccountBanTimeResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetAccountBanTimeResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetAccountBanTimeResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}
