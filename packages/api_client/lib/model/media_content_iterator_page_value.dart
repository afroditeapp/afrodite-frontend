//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentIteratorPageValue {
  /// Returns a new [MediaContentIteratorPageValue] instance.
  MediaContentIteratorPageValue({
    required this.accountId,
    this.age,
    required this.contentId,
    this.faceDetected,
    this.initialContent,
    this.moderationState,
    this.moderatorAccountId,
    this.name,
    this.rejectedReasonCategory,
    this.rejectedReasonDetails,
    this.secureCapture,
    this.uploadTime,
  });

  AccountId accountId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? age;

  ContentId contentId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? faceDetected;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? initialContent;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentModerationState? moderationState;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountId? moderatorAccountId;

  /// A string wrapper that ensures the string is not empty. This type is used for TEXT columns that should not allow empty strings. In the database, these columns are NULL when there is no value, and this type represents non-NULL values that must be non-empty.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MediaContentModerationRejectedReasonCategory? rejectedReasonCategory;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MediaContentModerationRejectedReasonDetails? rejectedReasonDetails;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? secureCapture;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UnixTime? uploadTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentIteratorPageValue &&
    other.accountId == accountId &&
    other.age == age &&
    other.contentId == contentId &&
    other.faceDetected == faceDetected &&
    other.initialContent == initialContent &&
    other.moderationState == moderationState &&
    other.moderatorAccountId == moderatorAccountId &&
    other.name == name &&
    other.rejectedReasonCategory == rejectedReasonCategory &&
    other.rejectedReasonDetails == rejectedReasonDetails &&
    other.secureCapture == secureCapture &&
    other.uploadTime == uploadTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (age == null ? 0 : age!.hashCode) +
    (contentId.hashCode) +
    (faceDetected == null ? 0 : faceDetected!.hashCode) +
    (initialContent == null ? 0 : initialContent!.hashCode) +
    (moderationState == null ? 0 : moderationState!.hashCode) +
    (moderatorAccountId == null ? 0 : moderatorAccountId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (rejectedReasonCategory == null ? 0 : rejectedReasonCategory!.hashCode) +
    (rejectedReasonDetails == null ? 0 : rejectedReasonDetails!.hashCode) +
    (secureCapture == null ? 0 : secureCapture!.hashCode) +
    (uploadTime == null ? 0 : uploadTime!.hashCode);

  @override
  String toString() => 'MediaContentIteratorPageValue[accountId=$accountId, age=$age, contentId=$contentId, faceDetected=$faceDetected, initialContent=$initialContent, moderationState=$moderationState, moderatorAccountId=$moderatorAccountId, name=$name, rejectedReasonCategory=$rejectedReasonCategory, rejectedReasonDetails=$rejectedReasonDetails, secureCapture=$secureCapture, uploadTime=$uploadTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
    if (this.age != null) {
      json[r'age'] = this.age;
    } else {
      json[r'age'] = null;
    }
      json[r'content_id'] = this.contentId;
    if (this.faceDetected != null) {
      json[r'face_detected'] = this.faceDetected;
    } else {
      json[r'face_detected'] = null;
    }
    if (this.initialContent != null) {
      json[r'initial_content'] = this.initialContent;
    } else {
      json[r'initial_content'] = null;
    }
    if (this.moderationState != null) {
      json[r'moderation_state'] = this.moderationState;
    } else {
      json[r'moderation_state'] = null;
    }
    if (this.moderatorAccountId != null) {
      json[r'moderator_account_id'] = this.moderatorAccountId;
    } else {
      json[r'moderator_account_id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.rejectedReasonCategory != null) {
      json[r'rejected_reason_category'] = this.rejectedReasonCategory;
    } else {
      json[r'rejected_reason_category'] = null;
    }
    if (this.rejectedReasonDetails != null) {
      json[r'rejected_reason_details'] = this.rejectedReasonDetails;
    } else {
      json[r'rejected_reason_details'] = null;
    }
    if (this.secureCapture != null) {
      json[r'secure_capture'] = this.secureCapture;
    } else {
      json[r'secure_capture'] = null;
    }
    if (this.uploadTime != null) {
      json[r'upload_time'] = this.uploadTime;
    } else {
      json[r'upload_time'] = null;
    }
    return json;
  }

  /// Returns a new [MediaContentIteratorPageValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentIteratorPageValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'account_id'), 'Required key "MediaContentIteratorPageValue[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "MediaContentIteratorPageValue[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'content_id'), 'Required key "MediaContentIteratorPageValue[content_id]" is missing from JSON.');
        assert(json[r'content_id'] != null, 'Required key "MediaContentIteratorPageValue[content_id]" has a null value in JSON.');
        return true;
      }());

      return MediaContentIteratorPageValue(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        age: mapValueOfType<int>(json, r'age'),
        contentId: ContentId.fromJson(json[r'content_id'])!,
        faceDetected: mapValueOfType<bool>(json, r'face_detected'),
        initialContent: mapValueOfType<bool>(json, r'initial_content'),
        moderationState: ContentModerationState.fromJson(json[r'moderation_state']),
        moderatorAccountId: AccountId.fromJson(json[r'moderator_account_id']),
        name: mapValueOfType<String>(json, r'name'),
        rejectedReasonCategory: MediaContentModerationRejectedReasonCategory.fromJson(json[r'rejected_reason_category']),
        rejectedReasonDetails: MediaContentModerationRejectedReasonDetails.fromJson(json[r'rejected_reason_details']),
        secureCapture: mapValueOfType<bool>(json, r'secure_capture'),
        uploadTime: UnixTime.fromJson(json[r'upload_time']),
      );
    }
    return null;
  }

  static List<MediaContentIteratorPageValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentIteratorPageValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentIteratorPageValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentIteratorPageValue> mapFromJson(dynamic json) {
    final map = <String, MediaContentIteratorPageValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentIteratorPageValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentIteratorPageValue-objects as value to a dart map
  static Map<String, List<MediaContentIteratorPageValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentIteratorPageValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentIteratorPageValue.listFromJson(entry.value, growable: growable,);
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

