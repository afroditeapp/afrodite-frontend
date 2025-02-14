//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatReportDetailed {
  /// Returns a new [ChatReportDetailed] instance.
  ChatReportDetailed({
    required this.content,
    required this.creator,
    required this.processingState,
    required this.target,
  });

  ChatReportContent content;

  AccountId creator;

  ReportProcessingState processingState;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatReportDetailed &&
    other.content == content &&
    other.creator == creator &&
    other.processingState == processingState &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (creator.hashCode) +
    (processingState.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'ChatReportDetailed[content=$content, creator=$creator, processingState=$processingState, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'creator'] = this.creator;
      json[r'processing_state'] = this.processingState;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [ChatReportDetailed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatReportDetailed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatReportDetailed[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatReportDetailed[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatReportDetailed(
        content: ChatReportContent.fromJson(json[r'content'])!,
        creator: AccountId.fromJson(json[r'creator'])!,
        processingState: ReportProcessingState.fromJson(json[r'processing_state'])!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<ChatReportDetailed> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatReportDetailed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatReportDetailed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatReportDetailed> mapFromJson(dynamic json) {
    final map = <String, ChatReportDetailed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatReportDetailed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatReportDetailed-objects as value to a dart map
  static Map<String, List<ChatReportDetailed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatReportDetailed>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatReportDetailed.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'creator',
    'processing_state',
    'target',
  };
}

