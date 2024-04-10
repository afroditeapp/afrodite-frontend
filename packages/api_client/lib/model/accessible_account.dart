//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccessibleAccount {
  /// Returns a new [AccessibleAccount] instance.
  AccessibleAccount({
    this.age,
    required this.id,
    this.name,
  });

  int? age;

  AccountId id;

  String? name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccessibleAccount &&
     other.age == age &&
     other.id == id &&
     other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (age == null ? 0 : age!.hashCode) +
    (id.hashCode) +
    (name == null ? 0 : name!.hashCode);

  @override
  String toString() => 'AccessibleAccount[age=$age, id=$id, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.age != null) {
      json[r'age'] = this.age;
    } else {
      json[r'age'] = null;
    }
      json[r'id'] = this.id;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    return json;
  }

  /// Returns a new [AccessibleAccount] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccessibleAccount? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccessibleAccount[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccessibleAccount[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccessibleAccount(
        age: mapValueOfType<int>(json, r'age'),
        id: AccountId.fromJson(json[r'id'])!,
        name: mapValueOfType<String>(json, r'name'),
      );
    }
    return null;
  }

  static List<AccessibleAccount>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccessibleAccount>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccessibleAccount.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccessibleAccount> mapFromJson(dynamic json) {
    final map = <String, AccessibleAccount>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccessibleAccount.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccessibleAccount-objects as value to a dart map
  static Map<String, List<AccessibleAccount>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccessibleAccount>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccessibleAccount.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}

