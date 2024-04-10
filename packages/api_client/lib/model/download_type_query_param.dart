//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DownloadTypeQueryParam {
  /// Returns a new [DownloadTypeQueryParam] instance.
  DownloadTypeQueryParam({
    required this.downloadType,
  });

  DownloadType downloadType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DownloadTypeQueryParam &&
     other.downloadType == downloadType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (downloadType.hashCode);

  @override
  String toString() => 'DownloadTypeQueryParam[downloadType=$downloadType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'download_type'] = this.downloadType;
    return json;
  }

  /// Returns a new [DownloadTypeQueryParam] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DownloadTypeQueryParam? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DownloadTypeQueryParam[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DownloadTypeQueryParam[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DownloadTypeQueryParam(
        downloadType: DownloadType.fromJson(json[r'download_type'])!,
      );
    }
    return null;
  }

  static List<DownloadTypeQueryParam>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DownloadTypeQueryParam>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DownloadTypeQueryParam.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DownloadTypeQueryParam> mapFromJson(dynamic json) {
    final map = <String, DownloadTypeQueryParam>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DownloadTypeQueryParam.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DownloadTypeQueryParam-objects as value to a dart map
  static Map<String, List<DownloadTypeQueryParam>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DownloadTypeQueryParam>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DownloadTypeQueryParam.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'download_type',
  };
}

