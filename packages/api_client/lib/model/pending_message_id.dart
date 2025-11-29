//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingMessageId {
  /// Returns a new [PendingMessageId] instance.
  PendingMessageId({
    required this.id,
    required this.sender,
  });

  MessageId id;

  /// Sender of the message.
  AccountId sender;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingMessageId &&
    other.id == id &&
    other.sender == sender;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (sender.hashCode);

  @override
  String toString() => 'PendingMessageId[id=$id, sender=$sender]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'sender'] = this.sender;
    return json;
  }

  /// Returns a new [PendingMessageId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingMessageId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingMessageId[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingMessageId[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingMessageId(
        id: MessageId.fromJson(json[r'id'])!,
        sender: AccountId.fromJson(json[r'sender'])!,
      );
    }
    return null;
  }

  static List<PendingMessageId> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingMessageId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingMessageId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingMessageId> mapFromJson(dynamic json) {
    final map = <String, PendingMessageId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingMessageId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingMessageId-objects as value to a dart map
  static Map<String, List<PendingMessageId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingMessageId>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PendingMessageId.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'sender',
  };
}

