//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentIdDbValue {
  /// Returns a new [MediaContentIdDbValue] instance.
  MediaContentIdDbValue({
    required this.contentIdDb,
  });

  int contentIdDb;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentIdDbValue &&
    other.contentIdDb == contentIdDb;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentIdDb.hashCode);

  @override
  String toString() => 'MediaContentIdDbValue[contentIdDb=$contentIdDb]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_id_db'] = this.contentIdDb;
    return json;
  }

  /// Returns a new [MediaContentIdDbValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentIdDbValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'content_id_db'), 'Required key "MediaContentIdDbValue[content_id_db]" is missing from JSON.');
        assert(json[r'content_id_db'] != null, 'Required key "MediaContentIdDbValue[content_id_db]" has a null value in JSON.');
        return true;
      }());

      return MediaContentIdDbValue(
        contentIdDb: mapValueOfType<int>(json, r'content_id_db')!,
      );
    }
    return null;
  }

  static List<MediaContentIdDbValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentIdDbValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentIdDbValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentIdDbValue> mapFromJson(dynamic json) {
    final map = <String, MediaContentIdDbValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentIdDbValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentIdDbValue-objects as value to a dart map
  static Map<String, List<MediaContentIdDbValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentIdDbValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentIdDbValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content_id_db',
  };
}

