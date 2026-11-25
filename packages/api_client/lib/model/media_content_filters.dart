//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentFilters {
  /// Returns a new [MediaContentFilters] instance.
  MediaContentFilters({
    this.faceDetected,
    this.faceDetectedManualSet,
    this.inUse,
    this.initialContent,
    this.moderationStates = const [],
    this.moderatorAccountId,
    this.moderatorAccountIdNot,
    this.secureCapture,
    this.uploadedAfterUnixTime,
    this.uploadedBeforeUnixTime,
  });

  /// Effective face detected value. Manual value overrides the automatic value.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? faceDetected;

  /// Includes content where the manual face detected value is set when true and content where it is not set when false.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? faceDetectedManualSet;

  /// Includes content which is currently in use (usage start time is set and usage end time is not set) when true.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? inUse;

  /// Includes content which was uploaded when profile visibility was pending public or pending private.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? initialContent;

  /// Includes content in any of the provided moderation states.
  List<ContentModerationState> moderationStates;

  /// Includes content moderated by the provided account.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountId? moderatorAccountId;

  /// Includes content which is not moderated by the provided account. Content without a moderator is included.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AccountId? moderatorAccountIdNot;

  /// Includes content which the client captured.
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
  UnixTime? uploadedAfterUnixTime;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UnixTime? uploadedBeforeUnixTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentFilters &&
    other.faceDetected == faceDetected &&
    other.faceDetectedManualSet == faceDetectedManualSet &&
    other.inUse == inUse &&
    other.initialContent == initialContent &&
    _deepEquality.equals(other.moderationStates, moderationStates) &&
    other.moderatorAccountId == moderatorAccountId &&
    other.moderatorAccountIdNot == moderatorAccountIdNot &&
    other.secureCapture == secureCapture &&
    other.uploadedAfterUnixTime == uploadedAfterUnixTime &&
    other.uploadedBeforeUnixTime == uploadedBeforeUnixTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (faceDetected == null ? 0 : faceDetected!.hashCode) +
    (faceDetectedManualSet == null ? 0 : faceDetectedManualSet!.hashCode) +
    (inUse == null ? 0 : inUse!.hashCode) +
    (initialContent == null ? 0 : initialContent!.hashCode) +
    (moderationStates.hashCode) +
    (moderatorAccountId == null ? 0 : moderatorAccountId!.hashCode) +
    (moderatorAccountIdNot == null ? 0 : moderatorAccountIdNot!.hashCode) +
    (secureCapture == null ? 0 : secureCapture!.hashCode) +
    (uploadedAfterUnixTime == null ? 0 : uploadedAfterUnixTime!.hashCode) +
    (uploadedBeforeUnixTime == null ? 0 : uploadedBeforeUnixTime!.hashCode);

  @override
  String toString() => 'MediaContentFilters[faceDetected=$faceDetected, faceDetectedManualSet=$faceDetectedManualSet, inUse=$inUse, initialContent=$initialContent, moderationStates=$moderationStates, moderatorAccountId=$moderatorAccountId, moderatorAccountIdNot=$moderatorAccountIdNot, secureCapture=$secureCapture, uploadedAfterUnixTime=$uploadedAfterUnixTime, uploadedBeforeUnixTime=$uploadedBeforeUnixTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.faceDetected != null) {
      json[r'face_detected'] = this.faceDetected;
    } else {
      json[r'face_detected'] = null;
    }
    if (this.faceDetectedManualSet != null) {
      json[r'face_detected_manual_set'] = this.faceDetectedManualSet;
    } else {
      json[r'face_detected_manual_set'] = null;
    }
    if (this.inUse != null) {
      json[r'in_use'] = this.inUse;
    } else {
      json[r'in_use'] = null;
    }
    if (this.initialContent != null) {
      json[r'initial_content'] = this.initialContent;
    } else {
      json[r'initial_content'] = null;
    }
      json[r'moderation_states'] = this.moderationStates;
    if (this.moderatorAccountId != null) {
      json[r'moderator_account_id'] = this.moderatorAccountId;
    } else {
      json[r'moderator_account_id'] = null;
    }
    if (this.moderatorAccountIdNot != null) {
      json[r'moderator_account_id_not'] = this.moderatorAccountIdNot;
    } else {
      json[r'moderator_account_id_not'] = null;
    }
    if (this.secureCapture != null) {
      json[r'secure_capture'] = this.secureCapture;
    } else {
      json[r'secure_capture'] = null;
    }
    if (this.uploadedAfterUnixTime != null) {
      json[r'uploaded_after_unix_time'] = this.uploadedAfterUnixTime;
    } else {
      json[r'uploaded_after_unix_time'] = null;
    }
    if (this.uploadedBeforeUnixTime != null) {
      json[r'uploaded_before_unix_time'] = this.uploadedBeforeUnixTime;
    } else {
      json[r'uploaded_before_unix_time'] = null;
    }
    return json;
  }

  /// Returns a new [MediaContentFilters] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentFilters? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return MediaContentFilters(
        faceDetected: mapValueOfType<bool>(json, r'face_detected'),
        faceDetectedManualSet: mapValueOfType<bool>(json, r'face_detected_manual_set'),
        inUse: mapValueOfType<bool>(json, r'in_use'),
        initialContent: mapValueOfType<bool>(json, r'initial_content'),
        moderationStates: ContentModerationState.listFromJson(json[r'moderation_states']),
        moderatorAccountId: AccountId.fromJson(json[r'moderator_account_id']),
        moderatorAccountIdNot: AccountId.fromJson(json[r'moderator_account_id_not']),
        secureCapture: mapValueOfType<bool>(json, r'secure_capture'),
        uploadedAfterUnixTime: UnixTime.fromJson(json[r'uploaded_after_unix_time']),
        uploadedBeforeUnixTime: UnixTime.fromJson(json[r'uploaded_before_unix_time']),
      );
    }
    return null;
  }

  static List<MediaContentFilters> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentFilters>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentFilters.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentFilters> mapFromJson(dynamic json) {
    final map = <String, MediaContentFilters>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentFilters.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentFilters-objects as value to a dart map
  static Map<String, List<MediaContentFilters>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentFilters>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentFilters.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

