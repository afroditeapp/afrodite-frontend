//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AddPublicKeyResult {
  /// Returns a new [AddPublicKeyResult] instance.
  AddPublicKeyResult({
    required this.errorTooManyPublicKeys,
    this.keyId,
  });

  bool errorTooManyPublicKeys;

  PublicKeyId? keyId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddPublicKeyResult &&
    other.errorTooManyPublicKeys == errorTooManyPublicKeys &&
    other.keyId == keyId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorTooManyPublicKeys.hashCode) +
    (keyId == null ? 0 : keyId!.hashCode);

  @override
  String toString() => 'AddPublicKeyResult[errorTooManyPublicKeys=$errorTooManyPublicKeys, keyId=$keyId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error_too_many_public_keys'] = this.errorTooManyPublicKeys;
    if (this.keyId != null) {
      json[r'key_id'] = this.keyId;
    } else {
      json[r'key_id'] = null;
    }
    return json;
  }

  /// Returns a new [AddPublicKeyResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AddPublicKeyResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AddPublicKeyResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AddPublicKeyResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AddPublicKeyResult(
        errorTooManyPublicKeys: mapValueOfType<bool>(json, r'error_too_many_public_keys')!,
        keyId: PublicKeyId.fromJson(json[r'key_id']),
      );
    }
    return null;
  }

  static List<AddPublicKeyResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddPublicKeyResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddPublicKeyResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AddPublicKeyResult> mapFromJson(dynamic json) {
    final map = <String, AddPublicKeyResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddPublicKeyResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AddPublicKeyResult-objects as value to a dart map
  static Map<String, List<AddPublicKeyResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AddPublicKeyResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AddPublicKeyResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'error_too_many_public_keys',
  };
}
