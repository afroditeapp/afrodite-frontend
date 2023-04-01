//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewModerationRequest {
  /// Returns a new [NewModerationRequest] instance.
  NewModerationRequest({
    this.camera,
    required this.image1,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? camera;

  bool image1;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewModerationRequest &&
     other.camera == camera &&
     other.image1 == image1;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (camera == null ? 0 : camera!.hashCode) +
    (image1.hashCode);

  @override
  String toString() => 'NewModerationRequest[camera=$camera, image1=$image1]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.camera != null) {
      json[r'camera'] = this.camera;
    } else {
      json[r'camera'] = null;
    }
      json[r'image1'] = this.image1;
    return json;
  }

  /// Returns a new [NewModerationRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewModerationRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewModerationRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewModerationRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewModerationRequest(
        camera: mapValueOfType<bool>(json, r'camera'),
        image1: mapValueOfType<bool>(json, r'image1')!,
      );
    }
    return null;
  }

  static List<NewModerationRequest>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewModerationRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewModerationRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewModerationRequest> mapFromJson(dynamic json) {
    final map = <String, NewModerationRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewModerationRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewModerationRequest-objects as value to a dart map
  static Map<String, List<NewModerationRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewModerationRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewModerationRequest.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'image1',
  };
}

