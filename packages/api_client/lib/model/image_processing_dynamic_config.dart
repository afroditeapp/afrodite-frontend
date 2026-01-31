//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ImageProcessingDynamicConfig {
  /// Returns a new [ImageProcessingDynamicConfig] instance.
  ImageProcessingDynamicConfig({
    this.nsfwThresholds,
    this.seetafaceThreshold,
  });

  /// Thresholds when an image is classified as NSFW.  If a probability value is equal or greater than the related threshold then the image is classified as NSFW.  Threshold values must be in the range 0.0–1.0.
  NsfwDetectionThresholds? nsfwThresholds;

  /// See [rustface::Detector::set_score_thresh] documentation. Value 1.0 seems to work well.
  double? seetafaceThreshold;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ImageProcessingDynamicConfig &&
    other.nsfwThresholds == nsfwThresholds &&
    other.seetafaceThreshold == seetafaceThreshold;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (nsfwThresholds == null ? 0 : nsfwThresholds!.hashCode) +
    (seetafaceThreshold == null ? 0 : seetafaceThreshold!.hashCode);

  @override
  String toString() => 'ImageProcessingDynamicConfig[nsfwThresholds=$nsfwThresholds, seetafaceThreshold=$seetafaceThreshold]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.nsfwThresholds != null) {
      json[r'nsfw_thresholds'] = this.nsfwThresholds;
    } else {
      json[r'nsfw_thresholds'] = null;
    }
    if (this.seetafaceThreshold != null) {
      json[r'seetaface_threshold'] = this.seetafaceThreshold;
    } else {
      json[r'seetaface_threshold'] = null;
    }
    return json;
  }

  /// Returns a new [ImageProcessingDynamicConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ImageProcessingDynamicConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ImageProcessingDynamicConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ImageProcessingDynamicConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ImageProcessingDynamicConfig(
        nsfwThresholds: NsfwDetectionThresholds.fromJson(json[r'nsfw_thresholds']),
        seetafaceThreshold: mapValueOfType<double>(json, r'seetaface_threshold'),
      );
    }
    return null;
  }

  static List<ImageProcessingDynamicConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ImageProcessingDynamicConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ImageProcessingDynamicConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ImageProcessingDynamicConfig> mapFromJson(dynamic json) {
    final map = <String, ImageProcessingDynamicConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImageProcessingDynamicConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ImageProcessingDynamicConfig-objects as value to a dart map
  static Map<String, List<ImageProcessingDynamicConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ImageProcessingDynamicConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ImageProcessingDynamicConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

