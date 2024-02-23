//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingMessage {
  /// Returns a new [PendingMessage] instance.
  PendingMessage({
    required this.id,
    required this.message,
    required this.unixTime,
  });

  PendingMessageId id;

  String message;

  UnixTime unixTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingMessage &&
     other.id == id &&
     other.message == message &&
     other.unixTime == unixTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (message.hashCode) +
    (unixTime.hashCode);

  @override
  String toString() => 'PendingMessage[id=$id, message=$message, unixTime=$unixTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'message'] = this.message;
      json[r'unix_time'] = this.unixTime;
    return json;
  }

  /// Returns a new [PendingMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingMessage(
        id: PendingMessageId.fromJson(json[r'id'])!,
        message: mapValueOfType<String>(json, r'message')!,
        unixTime: UnixTime.fromJson(json[r'unix_time'])!,
      );
    }
    return null;
  }

  static List<PendingMessage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingMessage> mapFromJson(dynamic json) {
    final map = <String, PendingMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingMessage-objects as value to a dart map
  static Map<String, List<PendingMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingMessage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingMessage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'message',
    'unix_time',
  };
}

