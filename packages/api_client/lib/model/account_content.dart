//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountContent {
  /// Returns a new [AccountContent] instance.
  AccountContent({
    this.data = const [],
    required this.maxContentCount,
    required this.unusedContentWaitSeconds,
  });

  List<ContentInfoDetailed> data;

  /// Minimum value: 0
  int maxContentCount;

  /// Content can be removed when - [ContentInfoDetailed::usage_end_time] and   [ContentInfoDetailed::usage_start_time] are empty - [ContentInfoDetailed::usage_end_time] is not empty   and [Self::unused_content_wait_seconds] has elapsed from the   [ContentInfoDetailed::usage_end_time]
  ///
  /// Minimum value: 0
  int unusedContentWaitSeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountContent &&
    _deepEquality.equals(other.data, data) &&
    other.maxContentCount == maxContentCount &&
    other.unusedContentWaitSeconds == unusedContentWaitSeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode) +
    (maxContentCount.hashCode) +
    (unusedContentWaitSeconds.hashCode);

  @override
  String toString() => 'AccountContent[data=$data, maxContentCount=$maxContentCount, unusedContentWaitSeconds=$unusedContentWaitSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
      json[r'max_content_count'] = this.maxContentCount;
      json[r'unused_content_wait_seconds'] = this.unusedContentWaitSeconds;
    return json;
  }

  /// Returns a new [AccountContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountContent(
        data: ContentInfoDetailed.listFromJson(json[r'data']),
        maxContentCount: mapValueOfType<int>(json, r'max_content_count')!,
        unusedContentWaitSeconds: mapValueOfType<int>(json, r'unused_content_wait_seconds')!,
      );
    }
    return null;
  }

  static List<AccountContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountContent> mapFromJson(dynamic json) {
    final map = <String, AccountContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountContent-objects as value to a dart map
  static Map<String, List<AccountContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'data',
    'max_content_count',
    'unused_content_wait_seconds',
  };
}

