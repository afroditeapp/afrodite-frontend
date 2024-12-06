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
    this.initialContentModerationCompleted,
    this.newMessageReceivedFrom = const [],
    this.newsChanged,
    this.receivedLikesChanged,
    required this.value,
  });

  /// Data for INITIAL_CONTENT_MODERATION_COMPLETED notification.
  InitialContentModerationCompletedResult? initialContentModerationCompleted;

  /// Data for NEW_MESSAGE notification.  List of account IDs which have sent a new message.
  List<AccountId>? newMessageReceivedFrom;

  /// Data for NEWS_CHANGED notification.
  UnreadNewsCountResult? newsChanged;

  /// Data for RECEIVED_LIKES_CHANGED notification.
  NewReceivedLikesCountResult? receivedLikesChanged;

  /// Pending notification (or multiple notifications which each have different type) not yet received notifications which push notification requests client to download.  The integer is a bitflag.  - const NEW_MESSAGE = 0x1; - const RECEIVED_LIKES_CHANGED = 0x2; - const INITIAL_CONTENT_MODERATION_COMPLETED = 0x4; - const NEWS_CHANGED = 0x8; 
  int value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingNotificationWithData &&
    other.initialContentModerationCompleted == initialContentModerationCompleted &&
    _deepEquality.equals(other.newMessageReceivedFrom, newMessageReceivedFrom) &&
    other.newsChanged == newsChanged &&
    other.receivedLikesChanged == receivedLikesChanged &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (initialContentModerationCompleted == null ? 0 : initialContentModerationCompleted!.hashCode) +
    (newMessageReceivedFrom == null ? 0 : newMessageReceivedFrom!.hashCode) +
    (newsChanged == null ? 0 : newsChanged!.hashCode) +
    (receivedLikesChanged == null ? 0 : receivedLikesChanged!.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'PendingNotificationWithData[initialContentModerationCompleted=$initialContentModerationCompleted, newMessageReceivedFrom=$newMessageReceivedFrom, newsChanged=$newsChanged, receivedLikesChanged=$receivedLikesChanged, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.initialContentModerationCompleted != null) {
      json[r'initial_content_moderation_completed'] = this.initialContentModerationCompleted;
    } else {
      json[r'initial_content_moderation_completed'] = null;
    }
    if (this.newMessageReceivedFrom != null) {
      json[r'new_message_received_from'] = this.newMessageReceivedFrom;
    } else {
      json[r'new_message_received_from'] = null;
    }
    if (this.newsChanged != null) {
      json[r'news_changed'] = this.newsChanged;
    } else {
      json[r'news_changed'] = null;
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
        initialContentModerationCompleted: InitialContentModerationCompletedResult.fromJson(json[r'initial_content_moderation_completed']),
        newMessageReceivedFrom: AccountId.listFromJson(json[r'new_message_received_from']),
        newsChanged: UnreadNewsCountResult.fromJson(json[r'news_changed']),
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

