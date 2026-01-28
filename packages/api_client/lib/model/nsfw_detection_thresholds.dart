//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NsfwDetectionThresholds {
  /// Returns a new [NsfwDetectionThresholds] instance.
  NsfwDetectionThresholds({
    this.drawings,
    this.hentai,
    this.neutral,
    this.porn,
    this.sexy,
  });

  double? drawings;

  double? hentai;

  double? neutral;

  double? porn;

  double? sexy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NsfwDetectionThresholds &&
    other.drawings == drawings &&
    other.hentai == hentai &&
    other.neutral == neutral &&
    other.porn == porn &&
    other.sexy == sexy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (drawings == null ? 0 : drawings!.hashCode) +
    (hentai == null ? 0 : hentai!.hashCode) +
    (neutral == null ? 0 : neutral!.hashCode) +
    (porn == null ? 0 : porn!.hashCode) +
    (sexy == null ? 0 : sexy!.hashCode);

  @override
  String toString() => 'NsfwDetectionThresholds[drawings=$drawings, hentai=$hentai, neutral=$neutral, porn=$porn, sexy=$sexy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.drawings != null) {
      json[r'drawings'] = this.drawings;
    } else {
      json[r'drawings'] = null;
    }
    if (this.hentai != null) {
      json[r'hentai'] = this.hentai;
    } else {
      json[r'hentai'] = null;
    }
    if (this.neutral != null) {
      json[r'neutral'] = this.neutral;
    } else {
      json[r'neutral'] = null;
    }
    if (this.porn != null) {
      json[r'porn'] = this.porn;
    } else {
      json[r'porn'] = null;
    }
    if (this.sexy != null) {
      json[r'sexy'] = this.sexy;
    } else {
      json[r'sexy'] = null;
    }
    return json;
  }

  /// Returns a new [NsfwDetectionThresholds] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NsfwDetectionThresholds? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NsfwDetectionThresholds[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NsfwDetectionThresholds[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NsfwDetectionThresholds(
        drawings: mapValueOfType<double>(json, r'drawings'),
        hentai: mapValueOfType<double>(json, r'hentai'),
        neutral: mapValueOfType<double>(json, r'neutral'),
        porn: mapValueOfType<double>(json, r'porn'),
        sexy: mapValueOfType<double>(json, r'sexy'),
      );
    }
    return null;
  }

  static List<NsfwDetectionThresholds> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NsfwDetectionThresholds>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NsfwDetectionThresholds.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NsfwDetectionThresholds> mapFromJson(dynamic json) {
    final map = <String, NsfwDetectionThresholds>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NsfwDetectionThresholds.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NsfwDetectionThresholds-objects as value to a dart map
  static Map<String, List<NsfwDetectionThresholds>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NsfwDetectionThresholds>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NsfwDetectionThresholds.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

