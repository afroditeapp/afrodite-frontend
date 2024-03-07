//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IconResource {
  /// Returns a new [IconResource] instance.
  IconResource({
    required this.identifier,
    required this.location,
  });

  String identifier;

  IconLocation location;

  @override
  bool operator ==(Object other) => identical(this, other) || other is IconResource &&
     other.identifier == identifier &&
     other.location == location;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (identifier.hashCode) +
    (location.hashCode);

  @override
  String toString() => 'IconResource[identifier=$identifier, location=$location]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'identifier'] = this.identifier;
      json[r'location'] = this.location;
    return json;
  }

  /// Returns a new [IconResource] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IconResource? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "IconResource[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "IconResource[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IconResource(
        identifier: mapValueOfType<String>(json, r'identifier')!,
        location: IconLocation.fromJson(json[r'location'])!,
      );
    }
    return null;
  }

  static List<IconResource>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <IconResource>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IconResource.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IconResource> mapFromJson(dynamic json) {
    final map = <String, IconResource>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IconResource.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IconResource-objects as value to a dart map
  static Map<String, List<IconResource>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<IconResource>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IconResource.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'identifier',
    'location',
  };
}

