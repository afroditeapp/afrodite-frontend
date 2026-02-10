//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResendMessage {
  /// Returns a new [ResendMessage] instance.
  ResendMessage({
    required this.backendSignedMessageBase64,
    required this.messageBase64,
  });

  String backendSignedMessageBase64;

  String messageBase64;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResendMessage &&
    other.backendSignedMessageBase64 == backendSignedMessageBase64 &&
    other.messageBase64 == messageBase64;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (backendSignedMessageBase64.hashCode) +
    (messageBase64.hashCode);

  @override
  String toString() => 'ResendMessage[backendSignedMessageBase64=$backendSignedMessageBase64, messageBase64=$messageBase64]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'backend_signed_message_base64'] = this.backendSignedMessageBase64;
      json[r'message_base64'] = this.messageBase64;
    return json;
  }

  /// Returns a new [ResendMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResendMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ResendMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ResendMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ResendMessage(
        backendSignedMessageBase64: mapValueOfType<String>(json, r'backend_signed_message_base64')!,
        messageBase64: mapValueOfType<String>(json, r'message_base64')!,
      );
    }
    return null;
  }

  static List<ResendMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResendMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResendMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResendMessage> mapFromJson(dynamic json) {
    final map = <String, ResendMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResendMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResendMessage-objects as value to a dart map
  static Map<String, List<ResendMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResendMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResendMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'backend_signed_message_base64',
    'message_base64',
  };
}

