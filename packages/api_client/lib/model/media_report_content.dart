//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaReportContent {
  /// Returns a new [MediaReportContent] instance.
  MediaReportContent({
    this.profileContent = const [],
  });

  List<ContentId> profileContent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaReportContent &&
    _deepEquality.equals(other.profileContent, profileContent);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profileContent.hashCode);

  @override
  String toString() => 'MediaReportContent[profileContent=$profileContent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profile_content'] = this.profileContent;
    return json;
  }

  /// Returns a new [MediaReportContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaReportContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MediaReportContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MediaReportContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MediaReportContent(
        profileContent: ContentId.listFromJson(json[r'profile_content']),
      );
    }
    return null;
  }

  static List<MediaReportContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaReportContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaReportContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaReportContent> mapFromJson(dynamic json) {
    final map = <String, MediaReportContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaReportContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaReportContent-objects as value to a dart map
  static Map<String, List<MediaReportContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaReportContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaReportContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profile_content',
  };
}

