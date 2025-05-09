//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetProfileName {
  /// Returns a new [SetProfileName] instance.
  SetProfileName({
    required this.account,
    required this.name,
  });

  AccountId account;

  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetProfileName &&
    other.account == account &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (account.hashCode) +
    (name.hashCode);

  @override
  String toString() => 'SetProfileName[account=$account, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account'] = this.account;
      json[r'name'] = this.name;
    return json;
  }

  /// Returns a new [SetProfileName] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetProfileName? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetProfileName[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetProfileName[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetProfileName(
        account: AccountId.fromJson(json[r'account'])!,
        name: mapValueOfType<String>(json, r'name')!,
      );
    }
    return null;
  }

  static List<SetProfileName> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetProfileName>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetProfileName.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetProfileName> mapFromJson(dynamic json) {
    final map = <String, SetProfileName>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetProfileName.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetProfileName-objects as value to a dart map
  static Map<String, List<SetProfileName>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetProfileName>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetProfileName.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account',
    'name',
  };
}

