//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentId {
  /// Returns a new [ContentId] instance.
  ContentId({
    required this.contentId,
  });

  String contentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentId &&
     other.contentId == contentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentId.hashCode);

  @override
  String toString() => 'ContentId[contentId=$contentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_id'] = this.contentId;
    return json;
  }

  /// Returns a new [ContentId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContentId[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContentId[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContentId(
        contentId: mapValueOfType<String>(json, r'content_id')!,
      );
    }
    return null;
  }

  static List<ContentId>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentId> mapFromJson(dynamic json) {
    final map = <String, ContentId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentId-objects as value to a dart map
  static Map<String, List<ContentId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentId>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentId.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content_id',
  };
}

