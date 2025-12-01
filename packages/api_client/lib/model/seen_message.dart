//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SeenMessage {
  /// Returns a new [SeenMessage] instance.
  SeenMessage({
    required this.id,
    required this.mn,
    required this.sender,
  });

  MessageId id;

  MessageNumber mn;

  /// Sender of the message.
  AccountId sender;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SeenMessage &&
    other.id == id &&
    other.mn == mn &&
    other.sender == sender;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (mn.hashCode) +
    (sender.hashCode);

  @override
  String toString() => 'SeenMessage[id=$id, mn=$mn, sender=$sender]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'mn'] = this.mn;
      json[r'sender'] = this.sender;
    return json;
  }

  /// Returns a new [SeenMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SeenMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SeenMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SeenMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SeenMessage(
        id: MessageId.fromJson(json[r'id'])!,
        mn: MessageNumber.fromJson(json[r'mn'])!,
        sender: AccountId.fromJson(json[r'sender'])!,
      );
    }
    return null;
  }

  static List<SeenMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SeenMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SeenMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SeenMessage> mapFromJson(dynamic json) {
    final map = <String, SeenMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SeenMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SeenMessage-objects as value to a dart map
  static Map<String, List<SeenMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SeenMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SeenMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'mn',
    'sender',
  };
}

