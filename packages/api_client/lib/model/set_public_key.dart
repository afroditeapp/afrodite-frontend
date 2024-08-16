//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetPublicKey {
  /// Returns a new [SetPublicKey] instance.
  SetPublicKey({
    required this.data,
    required this.version,
  });

  PublicKeyData data;

  PublicKeyVersion version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetPublicKey &&
    other.data == data &&
    other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'SetPublicKey[data=$data, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [SetPublicKey] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetPublicKey? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetPublicKey[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetPublicKey[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetPublicKey(
        data: PublicKeyData.fromJson(json[r'data'])!,
        version: PublicKeyVersion.fromJson(json[r'version'])!,
      );
    }
    return null;
  }

  static List<SetPublicKey> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetPublicKey>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetPublicKey.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetPublicKey> mapFromJson(dynamic json) {
    final map = <String, SetPublicKey>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetPublicKey.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetPublicKey-objects as value to a dart map
  static Map<String, List<SetPublicKey>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetPublicKey>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetPublicKey.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'data',
    'version',
  };
}

