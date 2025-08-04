//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DemoAccountLoginCredentials {
  /// Returns a new [DemoAccountLoginCredentials] instance.
  DemoAccountLoginCredentials({
    required this.password,
    required this.username,
  });

  String password;

  String username;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DemoAccountLoginCredentials &&
    other.password == password &&
    other.username == username;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (password.hashCode) +
    (username.hashCode);

  @override
  String toString() => 'DemoAccountLoginCredentials[password=$password, username=$username]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'password'] = this.password;
      json[r'username'] = this.username;
    return json;
  }

  /// Returns a new [DemoAccountLoginCredentials] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DemoAccountLoginCredentials? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DemoAccountLoginCredentials[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DemoAccountLoginCredentials[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DemoAccountLoginCredentials(
        password: mapValueOfType<String>(json, r'password')!,
        username: mapValueOfType<String>(json, r'username')!,
      );
    }
    return null;
  }

  static List<DemoAccountLoginCredentials> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DemoAccountLoginCredentials>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DemoAccountLoginCredentials.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DemoAccountLoginCredentials> mapFromJson(dynamic json) {
    final map = <String, DemoAccountLoginCredentials>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemoAccountLoginCredentials.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DemoAccountLoginCredentials-objects as value to a dart map
  static Map<String, List<DemoAccountLoginCredentials>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DemoAccountLoginCredentials>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DemoAccountLoginCredentials.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'password',
    'username',
  };
}

