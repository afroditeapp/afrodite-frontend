//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostModerateProfileString {
  /// Returns a new [PostModerateProfileString] instance.
  PostModerateProfileString({
    required this.accept,
    required this.contentType,
    required this.id,
    this.moveToHuman,
    this.rejectedCategory,
    this.rejectedDetails,
    required this.value,
  });

  bool accept;

  ProfileStringModerationContentType contentType;

  AccountId id;

  /// If true, ignore accept and move the text to waiting for human moderation state. rejected_category and rejected_details can be used to set the reason why the bot moved the content to human moderation.
  bool? moveToHuman;

  ProfileStringModerationRejectedReasonCategory? rejectedCategory;

  ProfileStringModerationRejectedReasonDetails? rejectedDetails;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  String value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostModerateProfileString &&
    other.accept == accept &&
    other.contentType == contentType &&
    other.id == id &&
    other.moveToHuman == moveToHuman &&
    other.rejectedCategory == rejectedCategory &&
    other.rejectedDetails == rejectedDetails &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accept.hashCode) +
    (contentType.hashCode) +
    (id.hashCode) +
    (moveToHuman == null ? 0 : moveToHuman!.hashCode) +
    (rejectedCategory == null ? 0 : rejectedCategory!.hashCode) +
    (rejectedDetails == null ? 0 : rejectedDetails!.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'PostModerateProfileString[accept=$accept, contentType=$contentType, id=$id, moveToHuman=$moveToHuman, rejectedCategory=$rejectedCategory, rejectedDetails=$rejectedDetails, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept'] = this.accept;
      json[r'content_type'] = this.contentType;
      json[r'id'] = this.id;
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
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [PostModerateProfileString] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostModerateProfileString? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostModerateProfileString[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostModerateProfileString[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostModerateProfileString(
        accept: mapValueOfType<bool>(json, r'accept')!,
        contentType: ProfileStringModerationContentType.fromJson(json[r'content_type'])!,
        id: AccountId.fromJson(json[r'id'])!,
        moveToHuman: mapValueOfType<bool>(json, r'move_to_human'),
        rejectedCategory: ProfileStringModerationRejectedReasonCategory.fromJson(json[r'rejected_category']),
        rejectedDetails: ProfileStringModerationRejectedReasonDetails.fromJson(json[r'rejected_details']),
        value: mapValueOfType<String>(json, r'value')!,
      );
    }
    return null;
  }

  static List<PostModerateProfileString> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostModerateProfileString>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostModerateProfileString.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostModerateProfileString> mapFromJson(dynamic json) {
    final map = <String, PostModerateProfileString>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostModerateProfileString.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostModerateProfileString-objects as value to a dart map
  static Map<String, List<PostModerateProfileString>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostModerateProfileString>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostModerateProfileString.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accept',
    'content_type',
    'id',
    'value',
  };
}

