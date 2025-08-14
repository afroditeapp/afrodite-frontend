//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LocalBotsConfig {
  /// Returns a new [LocalBotsConfig] instance.
  LocalBotsConfig({
    this.admin,
    this.users,
  });

  /// Admin bot  If None, editing the value is disabled.
  bool? admin;

  /// User bot count  If None, editing the value is disabled.
  ///
  /// Minimum value: 0
  int? users;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LocalBotsConfig &&
    other.admin == admin &&
    other.users == users;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (admin == null ? 0 : admin!.hashCode) +
    (users == null ? 0 : users!.hashCode);

  @override
  String toString() => 'LocalBotsConfig[admin=$admin, users=$users]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.admin != null) {
      json[r'admin'] = this.admin;
    } else {
      json[r'admin'] = null;
    }
    if (this.users != null) {
      json[r'users'] = this.users;
    } else {
      json[r'users'] = null;
    }
    return json;
  }

  /// Returns a new [LocalBotsConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LocalBotsConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LocalBotsConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LocalBotsConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LocalBotsConfig(
        admin: mapValueOfType<bool>(json, r'admin'),
        users: mapValueOfType<int>(json, r'users'),
      );
    }
    return null;
  }

  static List<LocalBotsConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LocalBotsConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LocalBotsConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LocalBotsConfig> mapFromJson(dynamic json) {
    final map = <String, LocalBotsConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LocalBotsConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LocalBotsConfig-objects as value to a dart map
  static Map<String, List<LocalBotsConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LocalBotsConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LocalBotsConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

