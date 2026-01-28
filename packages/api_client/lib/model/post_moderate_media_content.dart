//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostModerateMediaContent {
  /// Returns a new [PostModerateMediaContent] instance.
  PostModerateMediaContent({
    required this.accept,
    required this.accountId,
    required this.contentId,
    this.moveToHuman,
    this.rejectedCategory,
    this.rejectedDetails,
  });

  bool accept;

  AccountId accountId;

  ContentId contentId;

  /// If true, ignore accept and move the content to waiting for human moderation state. rejected_category and rejected_details can be used to set the reason why the bot moved the content to human moderation.
  bool? moveToHuman;

  MediaContentModerationRejectedReasonCategory? rejectedCategory;

  MediaContentModerationRejectedReasonDetails? rejectedDetails;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostModerateMediaContent &&
    other.accept == accept &&
    other.accountId == accountId &&
    other.contentId == contentId &&
    other.moveToHuman == moveToHuman &&
    other.rejectedCategory == rejectedCategory &&
    other.rejectedDetails == rejectedDetails;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accept.hashCode) +
    (accountId.hashCode) +
    (contentId.hashCode) +
    (moveToHuman == null ? 0 : moveToHuman!.hashCode) +
    (rejectedCategory == null ? 0 : rejectedCategory!.hashCode) +
    (rejectedDetails == null ? 0 : rejectedDetails!.hashCode);

  @override
  String toString() => 'PostModerateMediaContent[accept=$accept, accountId=$accountId, contentId=$contentId, moveToHuman=$moveToHuman, rejectedCategory=$rejectedCategory, rejectedDetails=$rejectedDetails]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept'] = this.accept;
      json[r'account_id'] = this.accountId;
      json[r'content_id'] = this.contentId;
    if (this.moveToHuman != null) {
      json[r'move_to_human'] = this.moveToHuman;
    } else {
      json[r'move_to_human'] = null;
    }
    if (this.rejectedCategory != null) {
      json[r'rejected_category'] = this.rejectedCategory;
    } else {
      json[r'rejected_category'] = null;
    }
    if (this.rejectedDetails != null) {
      json[r'rejected_details'] = this.rejectedDetails;
    } else {
      json[r'rejected_details'] = null;
    }
    return json;
  }

  /// Returns a new [PostModerateMediaContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostModerateMediaContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostModerateMediaContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostModerateMediaContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostModerateMediaContent(
        accept: mapValueOfType<bool>(json, r'accept')!,
        accountId: AccountId.fromJson(json[r'account_id'])!,
        contentId: ContentId.fromJson(json[r'content_id'])!,
        moveToHuman: mapValueOfType<bool>(json, r'move_to_human'),
        rejectedCategory: MediaContentModerationRejectedReasonCategory.fromJson(json[r'rejected_category']),
        rejectedDetails: MediaContentModerationRejectedReasonDetails.fromJson(json[r'rejected_details']),
      );
    }
    return null;
  }

  static List<PostModerateMediaContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostModerateMediaContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostModerateMediaContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostModerateMediaContent> mapFromJson(dynamic json) {
    final map = <String, PostModerateMediaContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostModerateMediaContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostModerateMediaContent-objects as value to a dart map
  static Map<String, List<PostModerateMediaContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostModerateMediaContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostModerateMediaContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accept',
    'account_id',
    'content_id',
  };
}

