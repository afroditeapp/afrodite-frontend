//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountStateContainer {
  /// Returns a new [AccountStateContainer] instance.
  AccountStateContainer({
    this.banned = false,
    this.initialSetupCompleted = true,
    this.pendingDeletion = false,
  });

  bool banned;

  bool initialSetupCompleted;

  bool pendingDeletion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountStateContainer &&
    other.banned == banned &&
    other.initialSetupCompleted == initialSetupCompleted &&
    other.pendingDeletion == pendingDeletion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (banned.hashCode) +
    (initialSetupCompleted.hashCode) +
    (pendingDeletion.hashCode);

  @override
  String toString() => 'AccountStateContainer[banned=$banned, initialSetupCompleted=$initialSetupCompleted, pendingDeletion=$pendingDeletion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'banned'] = this.banned;
      json[r'initial_setup_completed'] = this.initialSetupCompleted;
      json[r'pending_deletion'] = this.pendingDeletion;
    return json;
  }

  /// Returns a new [AccountStateContainer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountStateContainer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountStateContainer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountStateContainer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountStateContainer(
        banned: mapValueOfType<bool>(json, r'banned') ?? false,
        initialSetupCompleted: mapValueOfType<bool>(json, r'initial_setup_completed') ?? true,
        pendingDeletion: mapValueOfType<bool>(json, r'pending_deletion') ?? false,
      );
    }
    return null;
  }

  static List<AccountStateContainer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountStateContainer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountStateContainer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountStateContainer> mapFromJson(dynamic json) {
    final map = <String, AccountStateContainer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountStateContainer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountStateContainer-objects as value to a dart map
  static Map<String, List<AccountStateContainer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountStateContainer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountStateContainer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

