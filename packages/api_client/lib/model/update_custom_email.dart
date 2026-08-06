//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateCustomEmail {
  /// Returns a new [UpdateCustomEmail] instance.
  UpdateCustomEmail({
    required this.id,
    this.translations = const [],
  });

  CustomEmailId id;

  /// Translation with \"default\" locale must exist.
  List<CustomEmailTranslation> translations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateCustomEmail &&
    other.id == id &&
    _deepEquality.equals(other.translations, translations);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (translations.hashCode);

  @override
  String toString() => 'UpdateCustomEmail[id=$id, translations=$translations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'translations'] = this.translations;
    return json;
  }

  /// Returns a new [UpdateCustomEmail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateCustomEmail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "UpdateCustomEmail[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "UpdateCustomEmail[id]" has a null value in JSON.');
        assert(json.containsKey(r'translations'), 'Required key "UpdateCustomEmail[translations]" is missing from JSON.');
        assert(json[r'translations'] != null, 'Required key "UpdateCustomEmail[translations]" has a null value in JSON.');
        return true;
      }());

      return UpdateCustomEmail(
        id: CustomEmailId.fromJson(json[r'id'])!,
        translations: CustomEmailTranslation.listFromJson(json[r'translations']),
      );
    }
    return null;
  }

  static List<UpdateCustomEmail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateCustomEmail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateCustomEmail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateCustomEmail> mapFromJson(dynamic json) {
    final map = <String, UpdateCustomEmail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateCustomEmail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateCustomEmail-objects as value to a dart map
  static Map<String, List<UpdateCustomEmail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateCustomEmail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateCustomEmail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'translations',
  };
}

