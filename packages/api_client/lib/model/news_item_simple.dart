//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewsItemSimple {
  /// Returns a new [NewsItemSimple] instance.
  NewsItemSimple({
    required this.id,
    this.private = false,
    this.time,
    this.title,
  });

  NewsId id;

  bool private;

  UnixTime? time;

  String? title;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewsItemSimple &&
    other.id == id &&
    other.private == private &&
    other.time == time &&
    other.title == title;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (private.hashCode) +
    (time == null ? 0 : time!.hashCode) +
    (title == null ? 0 : title!.hashCode);

  @override
  String toString() => 'NewsItemSimple[id=$id, private=$private, time=$time, title=$title]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'private'] = this.private;
    if (this.time != null) {
      json[r'time'] = this.time;
    } else {
      json[r'time'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    return json;
  }

  /// Returns a new [NewsItemSimple] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewsItemSimple? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewsItemSimple[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewsItemSimple[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewsItemSimple(
        id: NewsId.fromJson(json[r'id'])!,
        private: mapValueOfType<bool>(json, r'private') ?? false,
        time: UnixTime.fromJson(json[r'time']),
        title: mapValueOfType<String>(json, r'title'),
      );
    }
    return null;
  }

  static List<NewsItemSimple> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewsItemSimple>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewsItemSimple.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewsItemSimple> mapFromJson(dynamic json) {
    final map = <String, NewsItemSimple>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewsItemSimple.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewsItemSimple-objects as value to a dart map
  static Map<String, List<NewsItemSimple>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewsItemSimple>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewsItemSimple.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}

