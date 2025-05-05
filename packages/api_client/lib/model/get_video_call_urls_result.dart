//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetVideoCallUrlsResult {
  /// Returns a new [GetVideoCallUrlsResult] instance.
  GetVideoCallUrlsResult({
    this.customUrl,
    required this.url,
  });

  /// Custom Jitsi Meet URL to a meeting with HTTPS schema. If exists, this should be used to open the meeting when Jitsi Meet app is not installed.
  String? customUrl;

  /// Standard Jitsi Meet URL to a meeting with HTTPS schema. Can be used to crate URL to open Jitsi Meet app.
  String url;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetVideoCallUrlsResult &&
    other.customUrl == customUrl &&
    other.url == url;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (customUrl == null ? 0 : customUrl!.hashCode) +
    (url.hashCode);

  @override
  String toString() => 'GetVideoCallUrlsResult[customUrl=$customUrl, url=$url]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.customUrl != null) {
      json[r'custom_url'] = this.customUrl;
    } else {
      json[r'custom_url'] = null;
    }
      json[r'url'] = this.url;
    return json;
  }

  /// Returns a new [GetVideoCallUrlsResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetVideoCallUrlsResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetVideoCallUrlsResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetVideoCallUrlsResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetVideoCallUrlsResult(
        customUrl: mapValueOfType<String>(json, r'custom_url'),
        url: mapValueOfType<String>(json, r'url')!,
      );
    }
    return null;
  }

  static List<GetVideoCallUrlsResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetVideoCallUrlsResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetVideoCallUrlsResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetVideoCallUrlsResult> mapFromJson(dynamic json) {
    final map = <String, GetVideoCallUrlsResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetVideoCallUrlsResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetVideoCallUrlsResult-objects as value to a dart map
  static Map<String, List<GetVideoCallUrlsResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetVideoCallUrlsResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetVideoCallUrlsResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
  };
}

