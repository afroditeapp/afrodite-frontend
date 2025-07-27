//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentPendingModeration {
  /// Returns a new [MediaContentPendingModeration] instance.
  MediaContentPendingModeration({
    required this.accountId,
    required this.contentId,
  });

  AccountId accountId;

  ContentId contentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentPendingModeration &&
    other.accountId == accountId &&
    other.contentId == contentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (contentId.hashCode);

  @override
  String toString() => 'MediaContentPendingModeration[accountId=$accountId, contentId=$contentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'content_id'] = this.contentId;
    return json;
  }

  /// Returns a new [MediaContentPendingModeration] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentPendingModeration? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MediaContentPendingModeration[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MediaContentPendingModeration[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MediaContentPendingModeration(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        contentId: ContentId.fromJson(json[r'content_id'])!,
      );
    }
    return null;
  }

  static List<MediaContentPendingModeration> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentPendingModeration>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentPendingModeration.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentPendingModeration> mapFromJson(dynamic json) {
    final map = <String, MediaContentPendingModeration>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentPendingModeration.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentPendingModeration-objects as value to a dart map
  static Map<String, List<MediaContentPendingModeration>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentPendingModeration>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentPendingModeration.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'content_id',
  };
}

