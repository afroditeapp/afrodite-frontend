//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FeedbackConfig {
  /// Returns a new [FeedbackConfig] instance.
  FeedbackConfig({
    required this.bodyMaxGraphemeClusterCount,
    this.categories = const [],
  });

  /// Max feedback body length in grapheme clusters.
  ///
  /// Minimum value: 0
  int bodyMaxGraphemeClusterCount;

  /// Categories which the client should show. Categories which are hidden in the server config are not included.
  List<FeedbackCategory> categories;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FeedbackConfig &&
    other.bodyMaxGraphemeClusterCount == bodyMaxGraphemeClusterCount &&
    _deepEquality.equals(other.categories, categories);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (bodyMaxGraphemeClusterCount.hashCode) +
    (categories.hashCode);

  @override
  String toString() => 'FeedbackConfig[bodyMaxGraphemeClusterCount=$bodyMaxGraphemeClusterCount, categories=$categories]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'body_max_grapheme_cluster_count'] = this.bodyMaxGraphemeClusterCount;
      json[r'categories'] = this.categories;
    return json;
  }

  /// Returns a new [FeedbackConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FeedbackConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'body_max_grapheme_cluster_count'), 'Required key "FeedbackConfig[body_max_grapheme_cluster_count]" is missing from JSON.');
        assert(json[r'body_max_grapheme_cluster_count'] != null, 'Required key "FeedbackConfig[body_max_grapheme_cluster_count]" has a null value in JSON.');
        return true;
      }());

      return FeedbackConfig(
        bodyMaxGraphemeClusterCount: mapValueOfType<int>(json, r'body_max_grapheme_cluster_count')!,
        categories: FeedbackCategory.listFromJson(json[r'categories']),
      );
    }
    return null;
  }

  static List<FeedbackConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FeedbackConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FeedbackConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FeedbackConfig> mapFromJson(dynamic json) {
    final map = <String, FeedbackConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FeedbackConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FeedbackConfig-objects as value to a dart map
  static Map<String, List<FeedbackConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FeedbackConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FeedbackConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body_max_grapheme_cluster_count',
  };
}

