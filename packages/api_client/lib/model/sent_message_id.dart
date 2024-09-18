//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SentMessageId {
  /// Returns a new [SentMessageId] instance.
  SentMessageId({
    required this.c,
    required this.l,
  });

  ClientId c;

  ClientLocalId l;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SentMessageId &&
    other.c == c &&
    other.l == l;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (l.hashCode);

  @override
  String toString() => 'SentMessageId[c=$c, l=$l]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
      json[r'l'] = this.l;
    return json;
  }

  /// Returns a new [SentMessageId] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SentMessageId? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SentMessageId[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SentMessageId[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SentMessageId(
        c: ClientId.fromJson(json[r'c'])!,
        l: ClientLocalId.fromJson(json[r'l'])!,
      );
    }
    return null;
  }

  static List<SentMessageId> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SentMessageId>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SentMessageId.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SentMessageId> mapFromJson(dynamic json) {
    final map = <String, SentMessageId>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SentMessageId.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SentMessageId-objects as value to a dart map
  static Map<String, List<SentMessageId>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SentMessageId>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SentMessageId.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
    'l',
  };
}

