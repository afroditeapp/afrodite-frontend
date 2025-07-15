//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatMessageReport {
  /// Returns a new [ChatMessageReport] instance.
  ChatMessageReport({
    required this.messageBase64,
    required this.messageId,
    required this.messageTime,
    required this.receiver,
    required this.sender,
  });

  /// Message without encryption and signing
  String messageBase64;

  MessageId messageId;

  UnixTime messageTime;

  AccountId receiver;

  AccountId sender;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatMessageReport &&
    other.messageBase64 == messageBase64 &&
    other.messageId == messageId &&
    other.messageTime == messageTime &&
    other.receiver == receiver &&
    other.sender == sender;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messageBase64.hashCode) +
    (messageId.hashCode) +
    (messageTime.hashCode) +
    (receiver.hashCode) +
    (sender.hashCode);

  @override
  String toString() => 'ChatMessageReport[messageBase64=$messageBase64, messageId=$messageId, messageTime=$messageTime, receiver=$receiver, sender=$sender]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'message_base64'] = this.messageBase64;
      json[r'message_id'] = this.messageId;
      json[r'message_time'] = this.messageTime;
      json[r'receiver'] = this.receiver;
      json[r'sender'] = this.sender;
    return json;
  }

  /// Returns a new [ChatMessageReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatMessageReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatMessageReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatMessageReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatMessageReport(
        messageBase64: mapValueOfType<String>(json, r'message_base64')!,
        messageId: MessageId.fromJson(json[r'message_id'])!,
        messageTime: UnixTime.fromJson(json[r'message_time'])!,
        receiver: AccountId.fromJson(json[r'receiver'])!,
        sender: AccountId.fromJson(json[r'sender'])!,
      );
    }
    return null;
  }

  static List<ChatMessageReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatMessageReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatMessageReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatMessageReport> mapFromJson(dynamic json) {
    final map = <String, ChatMessageReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatMessageReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatMessageReport-objects as value to a dart map
  static Map<String, List<ChatMessageReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatMessageReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatMessageReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message_base64',
    'message_id',
    'message_time',
    'receiver',
    'sender',
  };
}

