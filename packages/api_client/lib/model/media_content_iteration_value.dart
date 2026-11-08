//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentIterationValue {
  /// Returns a new [MediaContentIterationValue] instance.
  MediaContentIterationValue({
    required this.accountId,
    required this.contentId,
    required this.faceDetected,
    required this.secureCapture,
    required this.uploadedTime,
  });

  AccountId accountId;

  ContentId contentId;

  /// Face detected (automatic or manual)
  bool faceDetected;

  bool secureCapture;

  UnixTime uploadedTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentIterationValue &&
    other.accountId == accountId &&
    other.contentId == contentId &&
    other.faceDetected == faceDetected &&
    other.secureCapture == secureCapture &&
    other.uploadedTime == uploadedTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (contentId.hashCode) +
    (faceDetected.hashCode) +
    (secureCapture.hashCode) +
    (uploadedTime.hashCode);

  @override
  String toString() => 'MediaContentIterationValue[accountId=$accountId, contentId=$contentId, faceDetected=$faceDetected, secureCapture=$secureCapture, uploadedTime=$uploadedTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'content_id'] = this.contentId;
      json[r'face_detected'] = this.faceDetected;
      json[r'secure_capture'] = this.secureCapture;
      json[r'uploaded_time'] = this.uploadedTime;
    return json;
  }

  /// Returns a new [MediaContentIterationValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentIterationValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'account_id'), 'Required key "MediaContentIterationValue[account_id]" is missing from JSON.');
        assert(json[r'account_id'] != null, 'Required key "MediaContentIterationValue[account_id]" has a null value in JSON.');
        assert(json.containsKey(r'content_id'), 'Required key "MediaContentIterationValue[content_id]" is missing from JSON.');
        assert(json[r'content_id'] != null, 'Required key "MediaContentIterationValue[content_id]" has a null value in JSON.');
        assert(json.containsKey(r'face_detected'), 'Required key "MediaContentIterationValue[face_detected]" is missing from JSON.');
        assert(json[r'face_detected'] != null, 'Required key "MediaContentIterationValue[face_detected]" has a null value in JSON.');
        assert(json.containsKey(r'secure_capture'), 'Required key "MediaContentIterationValue[secure_capture]" is missing from JSON.');
        assert(json[r'secure_capture'] != null, 'Required key "MediaContentIterationValue[secure_capture]" has a null value in JSON.');
        assert(json.containsKey(r'uploaded_time'), 'Required key "MediaContentIterationValue[uploaded_time]" is missing from JSON.');
        assert(json[r'uploaded_time'] != null, 'Required key "MediaContentIterationValue[uploaded_time]" has a null value in JSON.');
        return true;
      }());

      return MediaContentIterationValue(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        contentId: ContentId.fromJson(json[r'content_id'])!,
        faceDetected: mapValueOfType<bool>(json, r'face_detected')!,
        secureCapture: mapValueOfType<bool>(json, r'secure_capture')!,
        uploadedTime: UnixTime.fromJson(json[r'uploaded_time'])!,
      );
    }
    return null;
  }

  static List<MediaContentIterationValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentIterationValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentIterationValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentIterationValue> mapFromJson(dynamic json) {
    final map = <String, MediaContentIterationValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentIterationValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentIterationValue-objects as value to a dart map
  static Map<String, List<MediaContentIterationValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentIterationValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentIterationValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'content_id',
    'face_detected',
    'secure_capture',
    'uploaded_time',
  };
}

