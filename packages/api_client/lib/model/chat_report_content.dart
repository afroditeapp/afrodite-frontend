//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatReportContent {
  /// Returns a new [ChatReportContent] instance.
  ChatReportContent({
    this.isAgainstVideoCalling = false,
  });

  bool isAgainstVideoCalling;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatReportContent &&
    other.isAgainstVideoCalling == isAgainstVideoCalling;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (isAgainstVideoCalling.hashCode);

  @override
  String toString() => 'ChatReportContent[isAgainstVideoCalling=$isAgainstVideoCalling]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'is_against_video_calling'] = this.isAgainstVideoCalling;
    return json;
  }

  /// Returns a new [ChatReportContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatReportContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatReportContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatReportContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatReportContent(
        isAgainstVideoCalling: mapValueOfType<bool>(json, r'is_against_video_calling') ?? false,
      );
    }
    return null;
  }

  static List<ChatReportContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatReportContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatReportContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatReportContent> mapFromJson(dynamic json) {
    final map = <String, ChatReportContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatReportContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatReportContent-objects as value to a dart map
  static Map<String, List<ChatReportContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatReportContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatReportContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

