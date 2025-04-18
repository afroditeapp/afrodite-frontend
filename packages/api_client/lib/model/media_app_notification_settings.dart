//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaAppNotificationSettings {
  /// Returns a new [MediaAppNotificationSettings] instance.
  MediaAppNotificationSettings({
    required this.mediaContentModeration,
  });

  bool mediaContentModeration;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaAppNotificationSettings &&
    other.mediaContentModeration == mediaContentModeration;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mediaContentModeration.hashCode);

  @override
  String toString() => 'MediaAppNotificationSettings[mediaContentModeration=$mediaContentModeration]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'media_content_moderation'] = this.mediaContentModeration;
    return json;
  }

  /// Returns a new [MediaAppNotificationSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaAppNotificationSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MediaAppNotificationSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MediaAppNotificationSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MediaAppNotificationSettings(
        mediaContentModeration: mapValueOfType<bool>(json, r'media_content_moderation')!,
      );
    }
    return null;
  }

  static List<MediaAppNotificationSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaAppNotificationSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaAppNotificationSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaAppNotificationSettings> mapFromJson(dynamic json) {
    final map = <String, MediaAppNotificationSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaAppNotificationSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaAppNotificationSettings-objects as value to a dart map
  static Map<String, List<MediaAppNotificationSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaAppNotificationSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaAppNotificationSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'media_content_moderation',
  };
}

