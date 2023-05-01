//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ModerationRequestContent {
  /// Returns a new [ModerationRequestContent] instance.
  ModerationRequestContent({
    required this.cameraImage,
    required this.image1,
    this.image2,
    this.image3,
  });

  /// Use slot 1 image as camera image.
  bool cameraImage;

  ContentId image1;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentId? image2;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentId? image3;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ModerationRequestContent &&
     other.cameraImage == cameraImage &&
     other.image1 == image1 &&
     other.image2 == image2 &&
     other.image3 == image3;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cameraImage.hashCode) +
    (image1.hashCode) +
    (image2 == null ? 0 : image2!.hashCode) +
    (image3 == null ? 0 : image3!.hashCode);

  @override
  String toString() => 'ModerationRequestContent[cameraImage=$cameraImage, image1=$image1, image2=$image2, image3=$image3]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'camera_image'] = this.cameraImage;
      json[r'image1'] = this.image1;
    if (this.image2 != null) {
      json[r'image2'] = this.image2;
    } else {
      json[r'image2'] = null;
    }
    if (this.image3 != null) {
      json[r'image3'] = this.image3;
    } else {
      json[r'image3'] = null;
    }
    return json;
  }

  /// Returns a new [ModerationRequestContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ModerationRequestContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ModerationRequestContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ModerationRequestContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ModerationRequestContent(
        cameraImage: mapValueOfType<bool>(json, r'camera_image')!,
        image1: ContentId.fromJson(json[r'image1'])!,
        image2: ContentId.fromJson(json[r'image2']),
        image3: ContentId.fromJson(json[r'image3']),
      );
    }
    return null;
  }

  static List<ModerationRequestContent>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModerationRequestContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModerationRequestContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ModerationRequestContent> mapFromJson(dynamic json) {
    final map = <String, ModerationRequestContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModerationRequestContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ModerationRequestContent-objects as value to a dart map
  static Map<String, List<ModerationRequestContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ModerationRequestContent>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModerationRequestContent.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'camera_image',
    'image1',
  };
}

