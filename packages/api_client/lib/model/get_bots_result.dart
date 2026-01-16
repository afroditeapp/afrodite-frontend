//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetBotsResult {
  /// Returns a new [GetBotsResult] instance.
  GetBotsResult({
    this.admin,
    this.users = const [],
  });

  BotAccount? admin;

  List<BotAccount> users;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetBotsResult &&
    other.admin == admin &&
    _deepEquality.equals(other.users, users);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (admin == null ? 0 : admin!.hashCode) +
    (users.hashCode);

  @override
  String toString() => 'GetBotsResult[admin=$admin, users=$users]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.admin != null) {
      json[r'admin'] = this.admin;
    } else {
      json[r'admin'] = null;
    }
      json[r'users'] = this.users;
    return json;
  }

  /// Returns a new [GetBotsResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetBotsResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetBotsResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetBotsResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetBotsResult(
        admin: BotAccount.fromJson(json[r'admin']),
        users: BotAccount.listFromJson(json[r'users']),
      );
    }
    return null;
  }

  static List<GetBotsResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetBotsResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetBotsResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetBotsResult> mapFromJson(dynamic json) {
    final map = <String, GetBotsResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetBotsResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetBotsResult-objects as value to a dart map
  static Map<String, List<GetBotsResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetBotsResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetBotsResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

