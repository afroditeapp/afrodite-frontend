//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportContent {
  /// Returns a new [ReportContent] instance.
  ReportContent({
    this.chatMessage,
    this.profileContent,
    this.profileName,
    this.profileText,
  });

  ChatMessageReport? chatMessage;

  ContentId? profileContent;

  String? profileName;

  String? profileText;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportContent &&
    other.chatMessage == chatMessage &&
    other.profileContent == profileContent &&
    other.profileName == profileName &&
    other.profileText == profileText;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chatMessage == null ? 0 : chatMessage!.hashCode) +
    (profileContent == null ? 0 : profileContent!.hashCode) +
    (profileName == null ? 0 : profileName!.hashCode) +
    (profileText == null ? 0 : profileText!.hashCode);

  @override
  String toString() => 'ReportContent[chatMessage=$chatMessage, profileContent=$profileContent, profileName=$profileName, profileText=$profileText]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.chatMessage != null) {
      json[r'chat_message'] = this.chatMessage;
    } else {
      json[r'chat_message'] = null;
    }
    if (this.profileContent != null) {
      json[r'profile_content'] = this.profileContent;
    } else {
      json[r'profile_content'] = null;
    }
    if (this.profileName != null) {
      json[r'profile_name'] = this.profileName;
    } else {
      json[r'profile_name'] = null;
    }
    if (this.profileText != null) {
      json[r'profile_text'] = this.profileText;
    } else {
      json[r'profile_text'] = null;
    }
    return json;
  }

  /// Returns a new [ReportContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReportContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReportContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReportContent(
        chatMessage: ChatMessageReport.fromJson(json[r'chat_message']),
        profileContent: ContentId.fromJson(json[r'profile_content']),
        profileName: mapValueOfType<String>(json, r'profile_name'),
        profileText: mapValueOfType<String>(json, r'profile_text'),
      );
    }
    return null;
  }

  static List<ReportContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportContent> mapFromJson(dynamic json) {
    final map = <String, ReportContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportContent-objects as value to a dart map
  static Map<String, List<ReportContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReportContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

