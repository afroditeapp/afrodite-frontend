//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DemoAccountLoginToAccount {
  /// Returns a new [DemoAccountLoginToAccount] instance.
  DemoAccountLoginToAccount({
    required this.aid,
    required this.clientInfo,
    required this.token,
  });

  AccountId aid;

  ClientInfo clientInfo;

  DemoAccountToken token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DemoAccountLoginToAccount &&
    other.aid == aid &&
    other.clientInfo == clientInfo &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid.hashCode) +
    (clientInfo.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'DemoAccountLoginToAccount[aid=$aid, clientInfo=$clientInfo, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'aid'] = this.aid;
      json[r'client_info'] = this.clientInfo;
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [DemoAccountLoginToAccount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DemoAccountLoginToAccount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DemoAccountLoginToAccount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DemoAccountLoginToAccount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DemoAccountLoginToAccount(
        aid: AccountId.fromJson(json[r'aid'])!,
        clientInfo: ClientInfo.fromJson(json[r'client_info'])!,
        token: DemoAccountToken.fromJson(json[r'token'])!,
      );
    }
    return null;
  }

  static List<DemoAccountLoginToAccount> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DemoAccountLoginToAccount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DemoAccountLoginToAccount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DemoAccountLoginToAccount> mapFromJson(dynamic json) {
    final map = <String, DemoAccountLoginToAccount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemoAccountLoginToAccount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DemoAccountLoginToAccount-objects as value to a dart map
  static Map<String, List<DemoAccountLoginToAccount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DemoAccountLoginToAccount>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DemoAccountLoginToAccount.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'aid',
    'client_info',
    'token',
  };
}

