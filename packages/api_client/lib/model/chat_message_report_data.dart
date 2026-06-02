//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatMessageReportData {
  /// Returns a new [ChatMessageReportData] instance.
  ChatMessageReportData({
    required this.decryptionKeyBase64,
    required this.serverSignedMessageBase64,
  });

  String decryptionKeyBase64;

  String serverSignedMessageBase64;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatMessageReportData &&
    other.decryptionKeyBase64 == decryptionKeyBase64 &&
    other.serverSignedMessageBase64 == serverSignedMessageBase64;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (decryptionKeyBase64.hashCode) +
    (serverSignedMessageBase64.hashCode);

  @override
  String toString() => 'ChatMessageReportData[decryptionKeyBase64=$decryptionKeyBase64, serverSignedMessageBase64=$serverSignedMessageBase64]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'decryption_key_base64'] = this.decryptionKeyBase64;
      json[r'server_signed_message_base64'] = this.serverSignedMessageBase64;
    return json;
  }

  /// Returns a new [ChatMessageReportData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatMessageReportData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatMessageReportData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatMessageReportData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatMessageReportData(
        decryptionKeyBase64: mapValueOfType<String>(json, r'decryption_key_base64')!,
        serverSignedMessageBase64: mapValueOfType<String>(json, r'server_signed_message_base64')!,
      );
    }
    return null;
  }

  static List<ChatMessageReportData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatMessageReportData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatMessageReportData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatMessageReportData> mapFromJson(dynamic json) {
    final map = <String, ChatMessageReportData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatMessageReportData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatMessageReportData-objects as value to a dart map
  static Map<String, List<ChatMessageReportData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatMessageReportData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatMessageReportData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'decryption_key_base64',
    'server_signed_message_base64',
  };
}

