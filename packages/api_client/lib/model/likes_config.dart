//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LikesConfig {
  /// Returns a new [LikesConfig] instance.
  LikesConfig({
    this.daily,
    this.unlimitedLikesDisablingTime,
  });

  DailyLikesConfig? daily;

  /// UTC time value
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? unlimitedLikesDisablingTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LikesConfig &&
    other.daily == daily &&
    other.unlimitedLikesDisablingTime == unlimitedLikesDisablingTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (daily == null ? 0 : daily!.hashCode) +
    (unlimitedLikesDisablingTime == null ? 0 : unlimitedLikesDisablingTime!.hashCode);

  @override
  String toString() => 'LikesConfig[daily=$daily, unlimitedLikesDisablingTime=$unlimitedLikesDisablingTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.daily != null) {
      json[r'daily'] = this.daily;
    } else {
      json[r'daily'] = null;
    }
    if (this.unlimitedLikesDisablingTime != null) {
      json[r'unlimited_likes_disabling_time'] = this.unlimitedLikesDisablingTime;
    } else {
      json[r'unlimited_likes_disabling_time'] = null;
    }
    return json;
  }

  /// Returns a new [LikesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LikesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LikesConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LikesConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LikesConfig(
        daily: DailyLikesConfig.fromJson(json[r'daily']),
        unlimitedLikesDisablingTime: mapValueOfType<String>(json, r'unlimited_likes_disabling_time'),
      );
    }
    return null;
  }

  static List<LikesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LikesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LikesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LikesConfig> mapFromJson(dynamic json) {
    final map = <String, LikesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LikesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LikesConfig-objects as value to a dart map
  static Map<String, List<LikesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LikesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LikesConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

