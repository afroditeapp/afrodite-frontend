//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentInfoDetailed {
  /// Returns a new [ContentInfoDetailed] instance.
  ContentInfoDetailed({
    required this.cid,
    required this.ctype,
    required this.faceDetected,
    this.faceDetectedManual,
    this.faceVerified,
    this.faceVerifiedManual,
    this.rejectedReasonCategory,
    this.rejectedReasonDetails,
    required this.secureCapture,
    this.slot,
    required this.state,
    this.usageEndTime,
    this.usageStartTime,
  });

  ContentId cid;

  MediaContentType ctype;

  /// Face detected (automatic)
  bool faceDetected;

  /// Manual face detected value set by admin
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? faceDetectedManual;

  /// Face verified against current security content (automatic or manual)
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? faceVerified;

  /// Manual face verified value set by admin
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? faceVerifiedManual;

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

  bool secureCapture;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ContentSlot? slot;

  ContentModerationState state;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UnixTime? usageEndTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UnixTime? usageStartTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentInfoDetailed &&
    other.cid == cid &&
    other.ctype == ctype &&
    other.faceDetected == faceDetected &&
    other.faceDetectedManual == faceDetectedManual &&
    other.faceVerified == faceVerified &&
    other.faceVerifiedManual == faceVerifiedManual &&
    other.rejectedReasonCategory == rejectedReasonCategory &&
    other.rejectedReasonDetails == rejectedReasonDetails &&
    other.secureCapture == secureCapture &&
    other.slot == slot &&
    other.state == state &&
    other.usageEndTime == usageEndTime &&
    other.usageStartTime == usageStartTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cid.hashCode) +
    (ctype.hashCode) +
    (faceDetected.hashCode) +
    (faceDetectedManual == null ? 0 : faceDetectedManual!.hashCode) +
    (faceVerified == null ? 0 : faceVerified!.hashCode) +
    (faceVerifiedManual == null ? 0 : faceVerifiedManual!.hashCode) +
    (rejectedReasonCategory == null ? 0 : rejectedReasonCategory!.hashCode) +
    (rejectedReasonDetails == null ? 0 : rejectedReasonDetails!.hashCode) +
    (secureCapture.hashCode) +
    (slot == null ? 0 : slot!.hashCode) +
    (state.hashCode) +
    (usageEndTime == null ? 0 : usageEndTime!.hashCode) +
    (usageStartTime == null ? 0 : usageStartTime!.hashCode);

  @override
  String toString() => 'ContentInfoDetailed[cid=$cid, ctype=$ctype, faceDetected=$faceDetected, faceDetectedManual=$faceDetectedManual, faceVerified=$faceVerified, faceVerifiedManual=$faceVerifiedManual, rejectedReasonCategory=$rejectedReasonCategory, rejectedReasonDetails=$rejectedReasonDetails, secureCapture=$secureCapture, slot=$slot, state=$state, usageEndTime=$usageEndTime, usageStartTime=$usageStartTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'cid'] = this.cid;
      json[r'ctype'] = this.ctype;
      json[r'face_detected'] = this.faceDetected;
    if (this.faceDetectedManual != null) {
      json[r'face_detected_manual'] = this.faceDetectedManual;
    } else {
      json[r'face_detected_manual'] = null;
    }
    if (this.faceVerified != null) {
      json[r'face_verified'] = this.faceVerified;
    } else {
      json[r'face_verified'] = null;
    }
    if (this.faceVerifiedManual != null) {
      json[r'face_verified_manual'] = this.faceVerifiedManual;
    } else {
      json[r'face_verified_manual'] = null;
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
      json[r'secure_capture'] = this.secureCapture;
    if (this.slot != null) {
      json[r'slot'] = this.slot;
    } else {
      json[r'slot'] = null;
    }
      json[r'state'] = this.state;
    if (this.usageEndTime != null) {
      json[r'usage_end_time'] = this.usageEndTime;
    } else {
      json[r'usage_end_time'] = null;
    }
    if (this.usageStartTime != null) {
      json[r'usage_start_time'] = this.usageStartTime;
    } else {
      json[r'usage_start_time'] = null;
    }
    return json;
  }

  /// Returns a new [ContentInfoDetailed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentInfoDetailed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'cid'), 'Required key "ContentInfoDetailed[cid]" is missing from JSON.');
        assert(json[r'cid'] != null, 'Required key "ContentInfoDetailed[cid]" has a null value in JSON.');
        assert(json.containsKey(r'ctype'), 'Required key "ContentInfoDetailed[ctype]" is missing from JSON.');
        assert(json[r'ctype'] != null, 'Required key "ContentInfoDetailed[ctype]" has a null value in JSON.');
        assert(json.containsKey(r'face_detected'), 'Required key "ContentInfoDetailed[face_detected]" is missing from JSON.');
        assert(json[r'face_detected'] != null, 'Required key "ContentInfoDetailed[face_detected]" has a null value in JSON.');
        assert(json.containsKey(r'secure_capture'), 'Required key "ContentInfoDetailed[secure_capture]" is missing from JSON.');
        assert(json[r'secure_capture'] != null, 'Required key "ContentInfoDetailed[secure_capture]" has a null value in JSON.');
        assert(json.containsKey(r'state'), 'Required key "ContentInfoDetailed[state]" is missing from JSON.');
        assert(json[r'state'] != null, 'Required key "ContentInfoDetailed[state]" has a null value in JSON.');
        return true;
      }());

      return ContentInfoDetailed(
        cid: ContentId.fromJson(json[r'cid'])!,
        ctype: MediaContentType.fromJson(json[r'ctype'])!,
        faceDetected: mapValueOfType<bool>(json, r'face_detected')!,
        faceDetectedManual: mapValueOfType<bool>(json, r'face_detected_manual'),
        faceVerified: mapValueOfType<bool>(json, r'face_verified'),
        faceVerifiedManual: mapValueOfType<bool>(json, r'face_verified_manual'),
        rejectedReasonCategory: MediaContentModerationRejectedReasonCategory.fromJson(json[r'rejected_reason_category']),
        rejectedReasonDetails: MediaContentModerationRejectedReasonDetails.fromJson(json[r'rejected_reason_details']),
        secureCapture: mapValueOfType<bool>(json, r'secure_capture')!,
        slot: ContentSlot.fromJson(json[r'slot']),
        state: ContentModerationState.fromJson(json[r'state'])!,
        usageEndTime: UnixTime.fromJson(json[r'usage_end_time']),
        usageStartTime: UnixTime.fromJson(json[r'usage_start_time']),
      );
    }
    return null;
  }

  static List<ContentInfoDetailed> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentInfoDetailed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentInfoDetailed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentInfoDetailed> mapFromJson(dynamic json) {
    final map = <String, ContentInfoDetailed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentInfoDetailed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentInfoDetailed-objects as value to a dart map
  static Map<String, List<ContentInfoDetailed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentInfoDetailed>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ContentInfoDetailed.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'cid',
    'ctype',
    'face_detected',
    'secure_capture',
    'state',
  };
}

