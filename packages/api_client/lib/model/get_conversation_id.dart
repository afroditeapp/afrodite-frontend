//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetConversationId {
  /// Returns a new [GetConversationId] instance.
  GetConversationId({
    this.value,
  });

  ConversationId? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetConversationId &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (value == null ? 0 : value!.hashCode);

  @override
  String toString() => 'GetConversationId[value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    return json;
  }

  /// Returns a new [GetConversationId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetConversationId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetConversationId[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetConversationId[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetConversationId(
        value: ConversationId.fromJson(json[r'value']),
      );
    }
    return null;
  }

  static List<GetConversationId> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetConversationId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetConversationId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetConversationId> mapFromJson(dynamic json) {
    final map = <String, GetConversationId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetConversationId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetConversationId-objects as value to a dart map
  static Map<String, List<GetConversationId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetConversationId>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetConversationId.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

