//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateNewsTranslation {
  /// Returns a new [UpdateNewsTranslation] instance.
  UpdateNewsTranslation({
    required this.body,
    required this.currentVersion,
    required this.title,
  });

  String body;

  NewsTranslationVersion currentVersion;

  String title;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateNewsTranslation &&
    other.body == body &&
    other.currentVersion == currentVersion &&
    other.title == title;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (body.hashCode) +
    (currentVersion.hashCode) +
    (title.hashCode);

  @override
  String toString() => 'UpdateNewsTranslation[body=$body, currentVersion=$currentVersion, title=$title]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'body'] = this.body;
      json[r'current_version'] = this.currentVersion;
      json[r'title'] = this.title;
    return json;
  }

  /// Returns a new [UpdateNewsTranslation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateNewsTranslation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateNewsTranslation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateNewsTranslation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateNewsTranslation(
        body: mapValueOfType<String>(json, r'body')!,
        currentVersion: NewsTranslationVersion.fromJson(json[r'current_version'])!,
        title: mapValueOfType<String>(json, r'title')!,
      );
    }
    return null;
  }

  static List<UpdateNewsTranslation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateNewsTranslation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateNewsTranslation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateNewsTranslation> mapFromJson(dynamic json) {
    final map = <String, UpdateNewsTranslation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateNewsTranslation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateNewsTranslation-objects as value to a dart map
  static Map<String, List<UpdateNewsTranslation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateNewsTranslation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateNewsTranslation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body',
    'current_version',
    'title',
  };
}

