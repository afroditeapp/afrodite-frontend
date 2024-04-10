//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingMessageDeleteList {
  /// Returns a new [PendingMessageDeleteList] instance.
  PendingMessageDeleteList({
    this.messagesIds = const [],
  });

  List<PendingMessageId> messagesIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingMessageDeleteList &&
     other.messagesIds == messagesIds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messagesIds.hashCode);

  @override
  String toString() => 'PendingMessageDeleteList[messagesIds=$messagesIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'messages_ids'] = this.messagesIds;
    return json;
  }

  /// Returns a new [PendingMessageDeleteList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingMessageDeleteList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingMessageDeleteList[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingMessageDeleteList[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingMessageDeleteList(
        messagesIds: PendingMessageId.listFromJson(json[r'messages_ids'])!,
      );
    }
    return null;
  }

  static List<PendingMessageDeleteList>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingMessageDeleteList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingMessageDeleteList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingMessageDeleteList> mapFromJson(dynamic json) {
    final map = <String, PendingMessageDeleteList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingMessageDeleteList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingMessageDeleteList-objects as value to a dart map
  static Map<String, List<PendingMessageDeleteList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingMessageDeleteList>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingMessageDeleteList.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'messages_ids',
  };
}

