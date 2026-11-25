//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentExtraInfoSettings {
  /// Returns a new [MediaContentExtraInfoSettings] instance.
  MediaContentExtraInfoSettings({
    this.age = false,
    this.faceDetected = false,
    this.initialContent = false,
    this.moderationState = false,
    this.moderatorAccountId = false,
    this.name = false,
    this.rejectedReasonCategory = false,
    this.rejectedReasonDetails = false,
    this.secureCapture = false,
    this.uploadTime = false,
  });

  bool age;

  bool faceDetected;

  bool initialContent;

  bool moderationState;

  bool moderatorAccountId;

  bool name;

  bool rejectedReasonCategory;

  bool rejectedReasonDetails;

  bool secureCapture;

  bool uploadTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentExtraInfoSettings &&
    other.age == age &&
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
    (age.hashCode) +
    (faceDetected.hashCode) +
    (initialContent.hashCode) +
    (moderationState.hashCode) +
    (moderatorAccountId.hashCode) +
    (name.hashCode) +
    (rejectedReasonCategory.hashCode) +
    (rejectedReasonDetails.hashCode) +
    (secureCapture.hashCode) +
    (uploadTime.hashCode);

  @override
  String toString() => 'MediaContentExtraInfoSettings[age=$age, faceDetected=$faceDetected, initialContent=$initialContent, moderationState=$moderationState, moderatorAccountId=$moderatorAccountId, name=$name, rejectedReasonCategory=$rejectedReasonCategory, rejectedReasonDetails=$rejectedReasonDetails, secureCapture=$secureCapture, uploadTime=$uploadTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'age'] = this.age;
      json[r'face_detected'] = this.faceDetected;
      json[r'initial_content'] = this.initialContent;
      json[r'moderation_state'] = this.moderationState;
      json[r'moderator_account_id'] = this.moderatorAccountId;
      json[r'name'] = this.name;
      json[r'rejected_reason_category'] = this.rejectedReasonCategory;
      json[r'rejected_reason_details'] = this.rejectedReasonDetails;
      json[r'secure_capture'] = this.secureCapture;
      json[r'upload_time'] = this.uploadTime;
    return json;
  }

  /// Returns a new [MediaContentExtraInfoSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentExtraInfoSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MediaContentExtraInfoSettings(
        age: mapValueOfType<bool>(json, r'age') ?? false,
        faceDetected: mapValueOfType<bool>(json, r'face_detected') ?? false,
        initialContent: mapValueOfType<bool>(json, r'initial_content') ?? false,
        moderationState: mapValueOfType<bool>(json, r'moderation_state') ?? false,
        moderatorAccountId: mapValueOfType<bool>(json, r'moderator_account_id') ?? false,
        name: mapValueOfType<bool>(json, r'name') ?? false,
        rejectedReasonCategory: mapValueOfType<bool>(json, r'rejected_reason_category') ?? false,
        rejectedReasonDetails: mapValueOfType<bool>(json, r'rejected_reason_details') ?? false,
        secureCapture: mapValueOfType<bool>(json, r'secure_capture') ?? false,
        uploadTime: mapValueOfType<bool>(json, r'upload_time') ?? false,
      );
    }
    return null;
  }

  static List<MediaContentExtraInfoSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentExtraInfoSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentExtraInfoSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentExtraInfoSettings> mapFromJson(dynamic json) {
    final map = <String, MediaContentExtraInfoSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentExtraInfoSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentExtraInfoSettings-objects as value to a dart map
  static Map<String, List<MediaContentExtraInfoSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentExtraInfoSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentExtraInfoSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

