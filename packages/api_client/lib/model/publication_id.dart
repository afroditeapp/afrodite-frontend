//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicationId {
  /// Returns a new [PublicationId] instance.
  PublicationId({
    required this.id,
  });

  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicationId &&
    other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode);

  @override
  String toString() => 'PublicationId[id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    return json;
  }

  /// Returns a new [PublicationId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicationId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PublicationId[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PublicationId[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicationId(
        id: mapValueOfType<int>(json, r'id')!,
      );
    }
    return null;
  }

  static List<PublicationId> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicationId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicationId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicationId> mapFromJson(dynamic json) {
    final map = <String, PublicationId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicationId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicationId-objects as value to a dart map
  static Map<String, List<PublicationId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicationId>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicationId.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}

