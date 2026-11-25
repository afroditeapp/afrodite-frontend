//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentIteratorSettings {
  /// Returns a new [MediaContentIteratorSettings] instance.
  MediaContentIteratorSettings({
    this.extraInfo,
    this.filters,
    required this.page,
    required this.startPosition,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MediaContentExtraInfoSettings? extraInfo;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MediaContentFilters? filters;

  int page;

  int startPosition;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentIteratorSettings &&
    other.extraInfo == extraInfo &&
    other.filters == filters &&
    other.page == page &&
    other.startPosition == startPosition;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (extraInfo == null ? 0 : extraInfo!.hashCode) +
    (filters == null ? 0 : filters!.hashCode) +
    (page.hashCode) +
    (startPosition.hashCode);

  @override
  String toString() => 'MediaContentIteratorSettings[extraInfo=$extraInfo, filters=$filters, page=$page, startPosition=$startPosition]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.extraInfo != null) {
      json[r'extra_info'] = this.extraInfo;
    } else {
      json[r'extra_info'] = null;
    }
    if (this.filters != null) {
      json[r'filters'] = this.filters;
    } else {
      json[r'filters'] = null;
    }
      json[r'page'] = this.page;
      json[r'start_position'] = this.startPosition;
    return json;
  }

  /// Returns a new [MediaContentIteratorSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentIteratorSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'page'), 'Required key "MediaContentIteratorSettings[page]" is missing from JSON.');
        assert(json[r'page'] != null, 'Required key "MediaContentIteratorSettings[page]" has a null value in JSON.');
        assert(json.containsKey(r'start_position'), 'Required key "MediaContentIteratorSettings[start_position]" is missing from JSON.');
        assert(json[r'start_position'] != null, 'Required key "MediaContentIteratorSettings[start_position]" has a null value in JSON.');
        return true;
      }());

      return MediaContentIteratorSettings(
        extraInfo: MediaContentExtraInfoSettings.fromJson(json[r'extra_info']),
        filters: MediaContentFilters.fromJson(json[r'filters']),
        page: mapValueOfType<int>(json, r'page')!,
        startPosition: mapValueOfType<int>(json, r'start_position')!,
      );
    }
    return null;
  }

  static List<MediaContentIteratorSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentIteratorSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentIteratorSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentIteratorSettings> mapFromJson(dynamic json) {
    final map = <String, MediaContentIteratorSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentIteratorSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentIteratorSettings-objects as value to a dart map
  static Map<String, List<MediaContentIteratorSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentIteratorSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentIteratorSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'page',
    'start_position',
  };
}

