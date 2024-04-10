//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Account {
  /// Returns a new [Account] instance.
  Account({
    required this.capabilities,
    required this.state,
    required this.syncVersion,
    required this.visibility,
  });

  Capabilities capabilities;

  AccountState state;

  AccountSyncVersion syncVersion;

  ProfileVisibility visibility;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Account &&
     other.capabilities == capabilities &&
     other.state == state &&
     other.syncVersion == syncVersion &&
     other.visibility == visibility;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (capabilities.hashCode) +
    (state.hashCode) +
    (syncVersion.hashCode) +
    (visibility.hashCode);

  @override
  String toString() => 'Account[capabilities=$capabilities, state=$state, syncVersion=$syncVersion, visibility=$visibility]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'capabilities'] = this.capabilities;
      json[r'state'] = this.state;
      json[r'sync_version'] = this.syncVersion;
      json[r'visibility'] = this.visibility;
    return json;
  }

  /// Returns a new [Account] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Account? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Account[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Account[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Account(
        capabilities: Capabilities.fromJson(json[r'capabilities'])!,
        state: AccountState.fromJson(json[r'state'])!,
        syncVersion: AccountSyncVersion.fromJson(json[r'sync_version'])!,
        visibility: ProfileVisibility.fromJson(json[r'visibility'])!,
      );
    }
    return null;
  }

  static List<Account>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Account>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Account.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Account> mapFromJson(dynamic json) {
    final map = <String, Account>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Account.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Account-objects as value to a dart map
  static Map<String, List<Account>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Account>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Account.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'capabilities',
    'state',
    'sync_version',
    'visibility',
  };
}

