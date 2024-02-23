//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentInfo {
  /// Returns a new [ContentInfo] instance.
  ContentInfo({
    required this.contentType,
    required this.id,
  });

  MediaContentType contentType;

  ContentId id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentInfo &&
     other.contentType == contentType &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentType.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'ContentInfo[contentType=$contentType, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_type'] = this.contentType;
      json[r'id'] = this.id;
    return json;
  }

  /// Returns a new [ContentInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContentInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContentInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContentInfo(
        contentType: MediaContentType.fromJson(json[r'content_type'])!,
        id: ContentId.fromJson(json[r'id'])!,
      );
    }
    return null;
  }

  static List<ContentInfo>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentInfo> mapFromJson(dynamic json) {
    final map = <String, ContentInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentInfo-objects as value to a dart map
  static Map<String, List<ContentInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentInfo>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentInfo.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content_type',
    'id',
  };
}

