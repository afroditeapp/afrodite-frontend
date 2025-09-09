//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportDetailed {
  /// Returns a new [ReportDetailed] instance.
  ReportDetailed({
    this.chatInfo,
    required this.content,
    required this.creatorInfo,
    required this.info,
    required this.targetInfo,
  });

  /// Only available when account interaction exists.
  ReportChatInfo? chatInfo;

  ReportContent content;

  ReportAccountInfo creatorInfo;

  ReportDetailedInfo info;

  ReportAccountInfo targetInfo;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportDetailed &&
    other.chatInfo == chatInfo &&
    other.content == content &&
    other.creatorInfo == creatorInfo &&
    other.info == info &&
    other.targetInfo == targetInfo;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chatInfo == null ? 0 : chatInfo!.hashCode) +
    (content.hashCode) +
    (creatorInfo.hashCode) +
    (info.hashCode) +
    (targetInfo.hashCode);

  @override
  String toString() => 'ReportDetailed[chatInfo=$chatInfo, content=$content, creatorInfo=$creatorInfo, info=$info, targetInfo=$targetInfo]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.chatInfo != null) {
      json[r'chat_info'] = this.chatInfo;
    } else {
      json[r'chat_info'] = null;
    }
      json[r'content'] = this.content;
      json[r'creator_info'] = this.creatorInfo;
      json[r'info'] = this.info;
      json[r'target_info'] = this.targetInfo;
    return json;
  }

  /// Returns a new [ReportDetailed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportDetailed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReportDetailed[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReportDetailed[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReportDetailed(
        chatInfo: ReportChatInfo.fromJson(json[r'chat_info']),
        content: ReportContent.fromJson(json[r'content'])!,
        creatorInfo: ReportAccountInfo.fromJson(json[r'creator_info'])!,
        info: ReportDetailedInfo.fromJson(json[r'info'])!,
        targetInfo: ReportAccountInfo.fromJson(json[r'target_info'])!,
      );
    }
    return null;
  }

  static List<ReportDetailed> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportDetailed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportDetailed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportDetailed> mapFromJson(dynamic json) {
    final map = <String, ReportDetailed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportDetailed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportDetailed-objects as value to a dart map
  static Map<String, List<ReportDetailed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReportDetailed>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportDetailed.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'creator_info',
    'info',
    'target_info',
  };
}

