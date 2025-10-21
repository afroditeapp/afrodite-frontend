//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatEmailNotificationSettings {
  /// Returns a new [ChatEmailNotificationSettings] instance.
  ChatEmailNotificationSettings({
    required this.likes,
    required this.messages,
  });

  bool likes;

  bool messages;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatEmailNotificationSettings &&
    other.likes == likes &&
    other.messages == messages;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (likes.hashCode) +
    (messages.hashCode);

  @override
  String toString() => 'ChatEmailNotificationSettings[likes=$likes, messages=$messages]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'likes'] = this.likes;
      json[r'messages'] = this.messages;
    return json;
  }

  /// Returns a new [ChatEmailNotificationSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatEmailNotificationSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatEmailNotificationSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatEmailNotificationSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatEmailNotificationSettings(
        likes: mapValueOfType<bool>(json, r'likes')!,
        messages: mapValueOfType<bool>(json, r'messages')!,
      );
    }
    return null;
  }

  static List<ChatEmailNotificationSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatEmailNotificationSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatEmailNotificationSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatEmailNotificationSettings> mapFromJson(dynamic json) {
    final map = <String, ChatEmailNotificationSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatEmailNotificationSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatEmailNotificationSettings-objects as value to a dart map
  static Map<String, List<ChatEmailNotificationSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatEmailNotificationSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatEmailNotificationSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'likes',
    'messages',
  };
}

