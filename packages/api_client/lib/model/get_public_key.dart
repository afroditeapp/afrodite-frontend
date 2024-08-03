//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetPublicKey {
  /// Returns a new [GetPublicKey] instance.
  GetPublicKey({
    this.key,
  });

  PublicKey? key;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetPublicKey &&
     other.key == key;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (key == null ? 0 : key!.hashCode);

  @override
  String toString() => 'GetPublicKey[key=$key]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.key != null) {
      json[r'key'] = this.key;
    } else {
      json[r'key'] = null;
    }
    return json;
  }

  /// Returns a new [GetPublicKey] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetPublicKey? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetPublicKey[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetPublicKey[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetPublicKey(
        key: PublicKey.fromJson(json[r'key']),
      );
    }
    return null;
  }

  static List<GetPublicKey>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetPublicKey>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetPublicKey.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetPublicKey> mapFromJson(dynamic json) {
    final map = <String, GetPublicKey>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetPublicKey.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetPublicKey-objects as value to a dart map
  static Map<String, List<GetPublicKey>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetPublicKey>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetPublicKey.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

