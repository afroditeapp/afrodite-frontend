//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportChatInfo {
  /// Returns a new [ReportChatInfo] instance.
  ReportChatInfo({
    this.creatorBlockedTarget = false,
    this.creatorCreatedVideoCallUrl = false,
    this.creatorSentMessagesCount = 0,
    required this.state,
    this.targetBlockedCreator = false,
    this.targetCreatedVideoCallUrl = false,
    this.targetSentMessagesCount = 0,
  });

  bool creatorBlockedTarget;

  bool creatorCreatedVideoCallUrl;

  int creatorSentMessagesCount;

  ReportChatInfoInteractionState state;

  bool targetBlockedCreator;

  bool targetCreatedVideoCallUrl;

  int targetSentMessagesCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportChatInfo &&
    other.creatorBlockedTarget == creatorBlockedTarget &&
    other.creatorCreatedVideoCallUrl == creatorCreatedVideoCallUrl &&
    other.creatorSentMessagesCount == creatorSentMessagesCount &&
    other.state == state &&
    other.targetBlockedCreator == targetBlockedCreator &&
    other.targetCreatedVideoCallUrl == targetCreatedVideoCallUrl &&
    other.targetSentMessagesCount == targetSentMessagesCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (creatorBlockedTarget.hashCode) +
    (creatorCreatedVideoCallUrl.hashCode) +
    (creatorSentMessagesCount.hashCode) +
    (state.hashCode) +
    (targetBlockedCreator.hashCode) +
    (targetCreatedVideoCallUrl.hashCode) +
    (targetSentMessagesCount.hashCode);

  @override
  String toString() => 'ReportChatInfo[creatorBlockedTarget=$creatorBlockedTarget, creatorCreatedVideoCallUrl=$creatorCreatedVideoCallUrl, creatorSentMessagesCount=$creatorSentMessagesCount, state=$state, targetBlockedCreator=$targetBlockedCreator, targetCreatedVideoCallUrl=$targetCreatedVideoCallUrl, targetSentMessagesCount=$targetSentMessagesCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'creator_blocked_target'] = this.creatorBlockedTarget;
      json[r'creator_created_video_call_url'] = this.creatorCreatedVideoCallUrl;
      json[r'creator_sent_messages_count'] = this.creatorSentMessagesCount;
      json[r'state'] = this.state;
      json[r'target_blocked_creator'] = this.targetBlockedCreator;
      json[r'target_created_video_call_url'] = this.targetCreatedVideoCallUrl;
      json[r'target_sent_messages_count'] = this.targetSentMessagesCount;
    return json;
  }

  /// Returns a new [ReportChatInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportChatInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReportChatInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReportChatInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReportChatInfo(
        creatorBlockedTarget: mapValueOfType<bool>(json, r'creator_blocked_target') ?? false,
        creatorCreatedVideoCallUrl: mapValueOfType<bool>(json, r'creator_created_video_call_url') ?? false,
        creatorSentMessagesCount: mapValueOfType<int>(json, r'creator_sent_messages_count') ?? 0,
        state: ReportChatInfoInteractionState.fromJson(json[r'state'])!,
        targetBlockedCreator: mapValueOfType<bool>(json, r'target_blocked_creator') ?? false,
        targetCreatedVideoCallUrl: mapValueOfType<bool>(json, r'target_created_video_call_url') ?? false,
        targetSentMessagesCount: mapValueOfType<int>(json, r'target_sent_messages_count') ?? 0,
      );
    }
    return null;
  }

  static List<ReportChatInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportChatInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportChatInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportChatInfo> mapFromJson(dynamic json) {
    final map = <String, ReportChatInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportChatInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportChatInfo-objects as value to a dart map
  static Map<String, List<ReportChatInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReportChatInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportChatInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'state',
  };
}

