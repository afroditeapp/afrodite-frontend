//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingNotificationWithData {
  /// Returns a new [PendingNotificationWithData] instance.
  PendingNotificationWithData({
    this.adminNotification,
    this.automaticProfileSearchCompleted,
    this.mediaContentModerationCompleted,
    this.newMessage,
    this.newsChanged,
    this.profileTextModerationCompleted,
    this.receivedLikesChanged,
    required this.value,
  });

  /// Data for ADMIN_NOTIFICATION notification.
  AdminNotification? adminNotification;

  /// Data for AUTOMATIC_PROFILE_SEARCH_COMPLETED notification.
  AutomaticProfileSearchCompletedNotification? automaticProfileSearchCompleted;

  /// Data for MEDIA_CONTENT_MODERATION_COMPLETED notification.
  MediaContentModerationCompletedNotification? mediaContentModerationCompleted;

  /// Data for NEW_MESSAGE notification.
  NewMessageNotificationList? newMessage;

  /// Data for NEWS_CHANGED notification.
  UnreadNewsCountResult? newsChanged;

  /// Data for PROFILE_TEXT_MODERATION_COMPLETED notification.
  ProfileTextModerationCompletedNotification? profileTextModerationCompleted;

  /// Data for RECEIVED_LIKES_CHANGED notification.
  NewReceivedLikesCountResult? receivedLikesChanged;

  /// Pending notification (or multiple notifications which each have different type) not yet received notifications which push notification requests client to download.  The integer is a bitflag.  - const NEW_MESSAGE = 0x1; - const RECEIVED_LIKES_CHANGED = 0x2; - const MEDIA_CONTENT_MODERATION_COMPLETED = 0x4; - const NEWS_CHANGED = 0x8; - const PROFILE_TEXT_MODERATION_COMPLETED = 0x10; - const AUTOMATIC_PROFILE_SEARCH_COMPLETED = 0x20; - const ADMIN_NOTIFICATION = 0x40; 
  int value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingNotificationWithData &&
    other.adminNotification == adminNotification &&
    other.automaticProfileSearchCompleted == automaticProfileSearchCompleted &&
    other.mediaContentModerationCompleted == mediaContentModerationCompleted &&
    other.newMessage == newMessage &&
    other.newsChanged == newsChanged &&
    other.profileTextModerationCompleted == profileTextModerationCompleted &&
    other.receivedLikesChanged == receivedLikesChanged &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminNotification == null ? 0 : adminNotification!.hashCode) +
    (automaticProfileSearchCompleted == null ? 0 : automaticProfileSearchCompleted!.hashCode) +
    (mediaContentModerationCompleted == null ? 0 : mediaContentModerationCompleted!.hashCode) +
    (newMessage == null ? 0 : newMessage!.hashCode) +
    (newsChanged == null ? 0 : newsChanged!.hashCode) +
    (profileTextModerationCompleted == null ? 0 : profileTextModerationCompleted!.hashCode) +
    (receivedLikesChanged == null ? 0 : receivedLikesChanged!.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'PendingNotificationWithData[adminNotification=$adminNotification, automaticProfileSearchCompleted=$automaticProfileSearchCompleted, mediaContentModerationCompleted=$mediaContentModerationCompleted, newMessage=$newMessage, newsChanged=$newsChanged, profileTextModerationCompleted=$profileTextModerationCompleted, receivedLikesChanged=$receivedLikesChanged, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.adminNotification != null) {
      json[r'admin_notification'] = this.adminNotification;
    } else {
      json[r'admin_notification'] = null;
    }
    if (this.automaticProfileSearchCompleted != null) {
      json[r'automatic_profile_search_completed'] = this.automaticProfileSearchCompleted;
    } else {
      json[r'automatic_profile_search_completed'] = null;
    }
    if (this.mediaContentModerationCompleted != null) {
      json[r'media_content_moderation_completed'] = this.mediaContentModerationCompleted;
    } else {
      json[r'media_content_moderation_completed'] = null;
    }
    if (this.newMessage != null) {
      json[r'new_message'] = this.newMessage;
    } else {
      json[r'new_message'] = null;
    }
    if (this.newsChanged != null) {
      json[r'news_changed'] = this.newsChanged;
    } else {
      json[r'news_changed'] = null;
    }
    if (this.profileTextModerationCompleted != null) {
      json[r'profile_text_moderation_completed'] = this.profileTextModerationCompleted;
    } else {
      json[r'profile_text_moderation_completed'] = null;
    }
    if (this.receivedLikesChanged != null) {
      json[r'received_likes_changed'] = this.receivedLikesChanged;
    } else {
      json[r'received_likes_changed'] = null;
    }
      json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [PendingNotificationWithData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingNotificationWithData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingNotificationWithData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingNotificationWithData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingNotificationWithData(
        adminNotification: AdminNotification.fromJson(json[r'admin_notification']),
        automaticProfileSearchCompleted: AutomaticProfileSearchCompletedNotification.fromJson(json[r'automatic_profile_search_completed']),
        mediaContentModerationCompleted: MediaContentModerationCompletedNotification.fromJson(json[r'media_content_moderation_completed']),
        newMessage: NewMessageNotificationList.fromJson(json[r'new_message']),
        newsChanged: UnreadNewsCountResult.fromJson(json[r'news_changed']),
        profileTextModerationCompleted: ProfileTextModerationCompletedNotification.fromJson(json[r'profile_text_moderation_completed']),
        receivedLikesChanged: NewReceivedLikesCountResult.fromJson(json[r'received_likes_changed']),
        value: mapValueOfType<int>(json, r'value')!,
      );
    }
    return null;
  }

  static List<PendingNotificationWithData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingNotificationWithData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingNotificationWithData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingNotificationWithData> mapFromJson(dynamic json) {
    final map = <String, PendingNotificationWithData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingNotificationWithData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingNotificationWithData-objects as value to a dart map
  static Map<String, List<PendingNotificationWithData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingNotificationWithData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PendingNotificationWithData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'value',
  };
}

