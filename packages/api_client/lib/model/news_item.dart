//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewsItem {
  /// Returns a new [NewsItem] instance.
  NewsItem({
    this.aidCreator,
    this.aidEditor,
    required this.body,
    this.editUnixTime,
    required this.locale,
    this.time,
    required this.title,
    this.version,
  });

  /// Only visible for accounts which have some news permissions
  AccountId? aidCreator;

  /// Only visible for accounts which have some news permissions
  AccountId? aidEditor;

  String body;

  /// Option<i64> is a workaround for Dart OpenApi generator version 7.9.0
  int? editUnixTime;

  String locale;

  /// Latest publication time
  UnixTime? time;

  String title;

  /// Only visible for accounts which have some news permissions
  NewsTranslationVersion? version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewsItem &&
    other.aidCreator == aidCreator &&
    other.aidEditor == aidEditor &&
    other.body == body &&
    other.editUnixTime == editUnixTime &&
    other.locale == locale &&
    other.time == time &&
    other.title == title &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aidCreator == null ? 0 : aidCreator!.hashCode) +
    (aidEditor == null ? 0 : aidEditor!.hashCode) +
    (body.hashCode) +
    (editUnixTime == null ? 0 : editUnixTime!.hashCode) +
    (locale.hashCode) +
    (time == null ? 0 : time!.hashCode) +
    (title.hashCode) +
    (version == null ? 0 : version!.hashCode);

  @override
  String toString() => 'NewsItem[aidCreator=$aidCreator, aidEditor=$aidEditor, body=$body, editUnixTime=$editUnixTime, locale=$locale, time=$time, title=$title, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.aidCreator != null) {
      json[r'aid_creator'] = this.aidCreator;
    } else {
      json[r'aid_creator'] = null;
    }
    if (this.aidEditor != null) {
      json[r'aid_editor'] = this.aidEditor;
    } else {
      json[r'aid_editor'] = null;
    }
      json[r'body'] = this.body;
    if (this.editUnixTime != null) {
      json[r'edit_unix_time'] = this.editUnixTime;
    } else {
      json[r'edit_unix_time'] = null;
    }
      json[r'locale'] = this.locale;
    if (this.time != null) {
      json[r'time'] = this.time;
    } else {
      json[r'time'] = null;
    }
      json[r'title'] = this.title;
    if (this.version != null) {
      json[r'version'] = this.version;
    } else {
      json[r'version'] = null;
    }
    return json;
  }

  /// Returns a new [NewsItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewsItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewsItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewsItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewsItem(
        aidCreator: AccountId.fromJson(json[r'aid_creator']),
        aidEditor: AccountId.fromJson(json[r'aid_editor']),
        body: mapValueOfType<String>(json, r'body')!,
        editUnixTime: mapValueOfType<int>(json, r'edit_unix_time'),
        locale: mapValueOfType<String>(json, r'locale')!,
        time: UnixTime.fromJson(json[r'time']),
        title: mapValueOfType<String>(json, r'title')!,
        version: NewsTranslationVersion.fromJson(json[r'version']),
      );
    }
    return null;
  }

  static List<NewsItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewsItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewsItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewsItem> mapFromJson(dynamic json) {
    final map = <String, NewsItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewsItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewsItem-objects as value to a dart map
  static Map<String, List<NewsItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewsItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewsItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body',
    'locale',
    'title',
  };
}

