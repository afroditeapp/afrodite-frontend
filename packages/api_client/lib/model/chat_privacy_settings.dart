//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatPrivacySettings {
  /// Returns a new [ChatPrivacySettings] instance.
  ChatPrivacySettings({
    required this.messageStateSeen,
    required this.typingIndicator,
  });

  bool messageStateSeen;

  bool typingIndicator;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatPrivacySettings &&
    other.messageStateSeen == messageStateSeen &&
    other.typingIndicator == typingIndicator;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messageStateSeen.hashCode) +
    (typingIndicator.hashCode);

  @override
  String toString() => 'ChatPrivacySettings[messageStateSeen=$messageStateSeen, typingIndicator=$typingIndicator]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'message_state_seen'] = this.messageStateSeen;
      json[r'typing_indicator'] = this.typingIndicator;
    return json;
  }

  /// Returns a new [ChatPrivacySettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatPrivacySettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatPrivacySettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatPrivacySettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatPrivacySettings(
        messageStateSeen: mapValueOfType<bool>(json, r'message_state_seen')!,
        typingIndicator: mapValueOfType<bool>(json, r'typing_indicator')!,
      );
    }
    return null;
  }

  static List<ChatPrivacySettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatPrivacySettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatPrivacySettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatPrivacySettings> mapFromJson(dynamic json) {
    final map = <String, ChatPrivacySettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatPrivacySettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatPrivacySettings-objects as value to a dart map
  static Map<String, List<ChatPrivacySettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatPrivacySettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatPrivacySettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message_state_seen',
    'typing_indicator',
  };
}

