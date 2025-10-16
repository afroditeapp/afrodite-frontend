//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetClientLanguage {
  /// Returns a new [GetClientLanguage] instance.
  GetClientLanguage({
    this.l,
  });

  ClientLanguage? l;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetClientLanguage &&
    other.l == l;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (l == null ? 0 : l!.hashCode);

  @override
  String toString() => 'GetClientLanguage[l=$l]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.l != null) {
      json[r'l'] = this.l;
    } else {
      json[r'l'] = null;
    }
    return json;
  }

  /// Returns a new [GetClientLanguage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetClientLanguage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetClientLanguage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetClientLanguage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetClientLanguage(
        l: ClientLanguage.fromJson(json[r'l']),
      );
    }
    return null;
  }

  static List<GetClientLanguage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetClientLanguage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetClientLanguage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetClientLanguage> mapFromJson(dynamic json) {
    final map = <String, GetClientLanguage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetClientLanguage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetClientLanguage-objects as value to a dart map
  static Map<String, List<GetClientLanguage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetClientLanguage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetClientLanguage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

