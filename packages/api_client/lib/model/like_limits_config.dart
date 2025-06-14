//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LikeLimitsConfig {
  /// Returns a new [LikeLimitsConfig] instance.
  LikeLimitsConfig({
    this.likeSending,
    this.unlimitedLikesDisablingTime,
  });

  LikeSendingLimitConfig? likeSending;

  /// UTC time value
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? unlimitedLikesDisablingTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LikeLimitsConfig &&
    other.likeSending == likeSending &&
    other.unlimitedLikesDisablingTime == unlimitedLikesDisablingTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (likeSending == null ? 0 : likeSending!.hashCode) +
    (unlimitedLikesDisablingTime == null ? 0 : unlimitedLikesDisablingTime!.hashCode);

  @override
  String toString() => 'LikeLimitsConfig[likeSending=$likeSending, unlimitedLikesDisablingTime=$unlimitedLikesDisablingTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.likeSending != null) {
      json[r'like_sending'] = this.likeSending;
    } else {
      json[r'like_sending'] = null;
    }
    if (this.unlimitedLikesDisablingTime != null) {
      json[r'unlimited_likes_disabling_time'] = this.unlimitedLikesDisablingTime;
    } else {
      json[r'unlimited_likes_disabling_time'] = null;
    }
    return json;
  }

  /// Returns a new [LikeLimitsConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LikeLimitsConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LikeLimitsConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LikeLimitsConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LikeLimitsConfig(
        likeSending: LikeSendingLimitConfig.fromJson(json[r'like_sending']),
        unlimitedLikesDisablingTime: mapValueOfType<String>(json, r'unlimited_likes_disabling_time'),
      );
    }
    return null;
  }

  static List<LikeLimitsConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LikeLimitsConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LikeLimitsConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LikeLimitsConfig> mapFromJson(dynamic json) {
    final map = <String, LikeLimitsConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LikeLimitsConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LikeLimitsConfig-objects as value to a dart map
  static Map<String, List<LikeLimitsConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LikeLimitsConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LikeLimitsConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

