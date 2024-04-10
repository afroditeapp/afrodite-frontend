//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewContentParams {
  /// Returns a new [NewContentParams] instance.
  NewContentParams({
    required this.contentType,
    required this.secureCapture,
  });

  MediaContentType contentType;

  /// Client captured this content.
  bool secureCapture;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewContentParams &&
     other.contentType == contentType &&
     other.secureCapture == secureCapture;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentType.hashCode) +
    (secureCapture.hashCode);

  @override
  String toString() => 'NewContentParams[contentType=$contentType, secureCapture=$secureCapture]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_type'] = this.contentType;
      json[r'secure_capture'] = this.secureCapture;
    return json;
  }

  /// Returns a new [NewContentParams] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewContentParams? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewContentParams[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewContentParams[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewContentParams(
        contentType: MediaContentType.fromJson(json[r'content_type'])!,
        secureCapture: mapValueOfType<bool>(json, r'secure_capture')!,
      );
    }
    return null;
  }

  static List<NewContentParams>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewContentParams>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewContentParams.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewContentParams> mapFromJson(dynamic json) {
    final map = <String, NewContentParams>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewContentParams.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewContentParams-objects as value to a dart map
  static Map<String, List<NewContentParams>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewContentParams>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewContentParams.listFromJson(entry.value, growable: growable,);
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
    'secure_capture',
  };
}

