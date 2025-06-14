//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DailyLikesLeft {
  /// Returns a new [DailyLikesLeft] instance.
  DailyLikesLeft({
    required this.likes,
    required this.version,
  });

  /// This value can be ignored when like sending limit is not enabled.
  int likes;

  DailyLikesLeftSyncVersion version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DailyLikesLeft &&
    other.likes == likes &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (likes.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'DailyLikesLeft[likes=$likes, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'likes'] = this.likes;
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [DailyLikesLeft] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DailyLikesLeft? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DailyLikesLeft[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DailyLikesLeft[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DailyLikesLeft(
        likes: mapValueOfType<int>(json, r'likes')!,
        version: DailyLikesLeftSyncVersion.fromJson(json[r'version'])!,
      );
    }
    return null;
  }

  static List<DailyLikesLeft> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DailyLikesLeft>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DailyLikesLeft.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DailyLikesLeft> mapFromJson(dynamic json) {
    final map = <String, DailyLikesLeft>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DailyLikesLeft.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DailyLikesLeft-objects as value to a dart map
  static Map<String, List<DailyLikesLeft>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DailyLikesLeft>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DailyLikesLeft.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'likes',
    'version',
  };
}

