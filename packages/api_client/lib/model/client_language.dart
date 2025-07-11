//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientLanguage {
  /// Returns a new [ClientLanguage] instance.
  ClientLanguage({
    required this.l,
  });

  String l;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientLanguage &&
    other.l == l;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (l.hashCode);

  @override
  String toString() => 'ClientLanguage[l=$l]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'l'] = this.l;
    return json;
  }

  /// Returns a new [ClientLanguage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientLanguage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientLanguage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientLanguage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientLanguage(
        l: mapValueOfType<String>(json, r'l')!,
      );
    }
    return null;
  }

  static List<ClientLanguage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientLanguage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientLanguage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientLanguage> mapFromJson(dynamic json) {
    final map = <String, ClientLanguage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientLanguage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientLanguage-objects as value to a dart map
  static Map<String, List<ClientLanguage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientLanguage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientLanguage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'l',
  };
}
