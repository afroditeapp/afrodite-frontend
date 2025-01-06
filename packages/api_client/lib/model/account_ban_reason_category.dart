//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountBanReasonCategory {
  /// Returns a new [AccountBanReasonCategory] instance.
  AccountBanReasonCategory({
    required this.value,
  });

  int value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountBanReasonCategory &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (value.hashCode);

  @override
  String toString() => 'AccountBanReasonCategory[value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [AccountBanReasonCategory] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountBanReasonCategory? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountBanReasonCategory[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountBanReasonCategory[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountBanReasonCategory(
        value: mapValueOfType<int>(json, r'value')!,
      );
    }
    return null;
  }

  static List<AccountBanReasonCategory> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountBanReasonCategory>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountBanReasonCategory.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountBanReasonCategory> mapFromJson(dynamic json) {
    final map = <String, AccountBanReasonCategory>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountBanReasonCategory.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountBanReasonCategory-objects as value to a dart map
  static Map<String, List<AccountBanReasonCategory>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountBanReasonCategory>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountBanReasonCategory.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'value',
  };
}

