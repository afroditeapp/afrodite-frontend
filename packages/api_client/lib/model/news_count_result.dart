//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewsCountResult {
  /// Returns a new [NewsCountResult] instance.
  NewsCountResult({
    required this.c,
    required this.v,
  });

  NewsCount c;

  NewsSyncVersion v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewsCountResult &&
    other.c == c &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (v.hashCode);

  @override
  String toString() => 'NewsCountResult[c=$c, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
      json[r'v'] = this.v;
    return json;
  }

  /// Returns a new [NewsCountResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewsCountResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewsCountResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewsCountResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewsCountResult(
        c: NewsCount.fromJson(json[r'c'])!,
        v: NewsSyncVersion.fromJson(json[r'v'])!,
      );
    }
    return null;
  }

  static List<NewsCountResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewsCountResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewsCountResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewsCountResult> mapFromJson(dynamic json) {
    final map = <String, NewsCountResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewsCountResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewsCountResult-objects as value to a dart map
  static Map<String, List<NewsCountResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewsCountResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewsCountResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
    'v',
  };
}

