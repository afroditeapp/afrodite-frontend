//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ImageFileName {
  /// Returns a new [ImageFileName] instance.
  ImageFileName({
    required this.imageFile,
  });

  String imageFile;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ImageFileName &&
     other.imageFile == imageFile;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (imageFile.hashCode);

  @override
  String toString() => 'ImageFileName[imageFile=$imageFile]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'image_file'] = this.imageFile;
    return json;
  }

  /// Returns a new [ImageFileName] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ImageFileName? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ImageFileName[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ImageFileName[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ImageFileName(
        imageFile: mapValueOfType<String>(json, r'image_file')!,
      );
    }
    return null;
  }

  static List<ImageFileName>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ImageFileName>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ImageFileName.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ImageFileName> mapFromJson(dynamic json) {
    final map = <String, ImageFileName>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImageFileName.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ImageFileName-objects as value to a dart map
  static Map<String, List<ImageFileName>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ImageFileName>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImageFileName.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'image_file',
  };
}

