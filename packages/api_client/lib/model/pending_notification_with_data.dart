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
    this.mediaContentAccepted,
    this.mediaContentDeleted,
    this.mediaContentRejected,
    this.newMessage,
    this.newsChanged,
    this.profileNameAccepted,
    this.profileNameRejected,
    this.profileTextAccepted,
    this.profileTextRejected,
    this.receivedLikesChanged,
  });

  AdminNotification? adminNotification;

  AutomaticProfileSearchCompletedNotification? automaticProfileSearchCompleted;

  NotificationStatus? mediaContentAccepted;

  NotificationStatus? mediaContentDeleted;

  NotificationStatus? mediaContentRejected;

  NewMessageNotificationList? newMessage;

  UnreadNewsCountResult? newsChanged;

  NotificationStatus? profileNameAccepted;

  NotificationStatus? profileNameRejected;

  NotificationStatus? profileTextAccepted;

  NotificationStatus? profileTextRejected;

  NewReceivedLikesCountResult? receivedLikesChanged;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingNotificationWithData &&
    other.adminNotification == adminNotification &&
    other.automaticProfileSearchCompleted == automaticProfileSearchCompleted &&
    other.mediaContentAccepted == mediaContentAccepted &&
    other.mediaContentDeleted == mediaContentDeleted &&
    other.mediaContentRejected == mediaContentRejected &&
    other.newMessage == newMessage &&
    other.newsChanged == newsChanged &&
    other.profileNameAccepted == profileNameAccepted &&
    other.profileNameRejected == profileNameRejected &&
    other.profileTextAccepted == profileTextAccepted &&
    other.profileTextRejected == profileTextRejected &&
    other.receivedLikesChanged == receivedLikesChanged;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminNotification == null ? 0 : adminNotification!.hashCode) +
    (automaticProfileSearchCompleted == null ? 0 : automaticProfileSearchCompleted!.hashCode) +
    (mediaContentAccepted == null ? 0 : mediaContentAccepted!.hashCode) +
    (mediaContentDeleted == null ? 0 : mediaContentDeleted!.hashCode) +
    (mediaContentRejected == null ? 0 : mediaContentRejected!.hashCode) +
    (newMessage == null ? 0 : newMessage!.hashCode) +
    (newsChanged == null ? 0 : newsChanged!.hashCode) +
    (profileNameAccepted == null ? 0 : profileNameAccepted!.hashCode) +
    (profileNameRejected == null ? 0 : profileNameRejected!.hashCode) +
    (profileTextAccepted == null ? 0 : profileTextAccepted!.hashCode) +
    (profileTextRejected == null ? 0 : profileTextRejected!.hashCode) +
    (receivedLikesChanged == null ? 0 : receivedLikesChanged!.hashCode);

  @override
  String toString() => 'PendingNotificationWithData[adminNotification=$adminNotification, automaticProfileSearchCompleted=$automaticProfileSearchCompleted, mediaContentAccepted=$mediaContentAccepted, mediaContentDeleted=$mediaContentDeleted, mediaContentRejected=$mediaContentRejected, newMessage=$newMessage, newsChanged=$newsChanged, profileNameAccepted=$profileNameAccepted, profileNameRejected=$profileNameRejected, profileTextAccepted=$profileTextAccepted, profileTextRejected=$profileTextRejected, receivedLikesChanged=$receivedLikesChanged]';

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
    if (this.mediaContentAccepted != null) {
      json[r'media_content_accepted'] = this.mediaContentAccepted;
    } else {
      json[r'media_content_accepted'] = null;
    }
    if (this.mediaContentDeleted != null) {
      json[r'media_content_deleted'] = this.mediaContentDeleted;
    } else {
      json[r'media_content_deleted'] = null;
    }
    if (this.mediaContentRejected != null) {
      json[r'media_content_rejected'] = this.mediaContentRejected;
    } else {
      json[r'media_content_rejected'] = null;
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
    if (this.profileNameAccepted != null) {
      json[r'profile_name_accepted'] = this.profileNameAccepted;
    } else {
      json[r'profile_name_accepted'] = null;
    }
    if (this.profileNameRejected != null) {
      json[r'profile_name_rejected'] = this.profileNameRejected;
    } else {
      json[r'profile_name_rejected'] = null;
    }
    if (this.profileTextAccepted != null) {
      json[r'profile_text_accepted'] = this.profileTextAccepted;
    } else {
      json[r'profile_text_accepted'] = null;
    }
    if (this.profileTextRejected != null) {
      json[r'profile_text_rejected'] = this.profileTextRejected;
    } else {
      json[r'profile_text_rejected'] = null;
    }
    if (this.receivedLikesChanged != null) {
      json[r'received_likes_changed'] = this.receivedLikesChanged;
    } else {
      json[r'received_likes_changed'] = null;
    }
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
        mediaContentAccepted: NotificationStatus.fromJson(json[r'media_content_accepted']),
        mediaContentDeleted: NotificationStatus.fromJson(json[r'media_content_deleted']),
        mediaContentRejected: NotificationStatus.fromJson(json[r'media_content_rejected']),
        newMessage: NewMessageNotificationList.fromJson(json[r'new_message']),
        newsChanged: UnreadNewsCountResult.fromJson(json[r'news_changed']),
        profileNameAccepted: NotificationStatus.fromJson(json[r'profile_name_accepted']),
        profileNameRejected: NotificationStatus.fromJson(json[r'profile_name_rejected']),
        profileTextAccepted: NotificationStatus.fromJson(json[r'profile_text_accepted']),
        profileTextRejected: NotificationStatus.fromJson(json[r'profile_text_rejected']),
        receivedLikesChanged: NewReceivedLikesCountResult.fromJson(json[r'received_likes_changed']),
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
  };
}

