//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewsConfig {
  /// Returns a new [NewsConfig] instance.
  NewsConfig({
    this.locales = const [],
  });

  /// Make possible for admins to write translations for news. If news translation is not available then server returns news with locale \"default\".
  List<String> locales;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewsConfig &&
    _deepEquality.equals(other.locales, locales);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (locales.hashCode);

  @override
  String toString() => 'NewsConfig[locales=$locales]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'locales'] = this.locales;
    return json;
  }

  /// Returns a new [NewsConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewsConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewsConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewsConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewsConfig(
        locales: json[r'locales'] is Iterable
            ? (json[r'locales'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<NewsConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewsConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewsConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewsConfig> mapFromJson(dynamic json) {
    final map = <String, NewsConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewsConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewsConfig-objects as value to a dart map
  static Map<String, List<NewsConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewsConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewsConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'locales',
  };
}

