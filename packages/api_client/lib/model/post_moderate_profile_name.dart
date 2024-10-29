//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostModerateProfileName {
  /// Returns a new [PostModerateProfileName] instance.
  PostModerateProfileName({
    required this.accept,
    required this.id,
    required this.name,
  });

  bool accept;

  AccountId id;

  String name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostModerateProfileName &&
    other.accept == accept &&
    other.id == id &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accept.hashCode) +
    (id.hashCode) +
    (name.hashCode);

  @override
  String toString() => 'PostModerateProfileName[accept=$accept, id=$id, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept'] = this.accept;
      json[r'id'] = this.id;
      json[r'name'] = this.name;
    return json;
  }

  /// Returns a new [PostModerateProfileName] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostModerateProfileName? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostModerateProfileName[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostModerateProfileName[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostModerateProfileName(
        accept: mapValueOfType<bool>(json, r'accept')!,
        id: AccountId.fromJson(json[r'id'])!,
        name: mapValueOfType<String>(json, r'name')!,
      );
    }
    return null;
  }

  static List<PostModerateProfileName> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostModerateProfileName>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostModerateProfileName.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostModerateProfileName> mapFromJson(dynamic json) {
    final map = <String, PostModerateProfileName>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostModerateProfileName.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostModerateProfileName-objects as value to a dart map
  static Map<String, List<PostModerateProfileName>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostModerateProfileName>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostModerateProfileName.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accept',
    'id',
    'name',
  };
}

