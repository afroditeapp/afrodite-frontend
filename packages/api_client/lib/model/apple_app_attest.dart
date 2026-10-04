//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppleAppAttest {
  /// Returns a new [AppleAppAttest] instance.
  AppleAppAttest({
    this.assertion,
    this.attestation,
    required this.keyId,
  });

  /// Base64-encoded CBOR assertion object returned by `DCAppAttestService.generateAssertion`. Present when the client is proving an already attested key.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? assertion;

  /// Base64-encoded CBOR attestation object returned by `DCAppAttestService.attestKey`. Present when the client is attesting a new key.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? attestation;

  /// Base64-encoded key identifier returned by `DCAppAttestService.generateKey`.
  String keyId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppleAppAttest &&
    other.assertion == assertion &&
    other.attestation == attestation &&
    other.keyId == keyId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assertion == null ? 0 : assertion!.hashCode) +
    (attestation == null ? 0 : attestation!.hashCode) +
    (keyId.hashCode);

  @override
  String toString() => 'AppleAppAttest[assertion=$assertion, attestation=$attestation, keyId=$keyId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.assertion != null) {
      json[r'assertion'] = this.assertion;
    } else {
      json[r'assertion'] = null;
    }
    if (this.attestation != null) {
      json[r'attestation'] = this.attestation;
    } else {
      json[r'attestation'] = null;
    }
      json[r'key_id'] = this.keyId;
    return json;
  }

  /// Returns a new [AppleAppAttest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppleAppAttest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'key_id'), 'Required key "AppleAppAttest[key_id]" is missing from JSON.');
        assert(json[r'key_id'] != null, 'Required key "AppleAppAttest[key_id]" has a null value in JSON.');
        return true;
      }());

      return AppleAppAttest(
        assertion: mapValueOfType<String>(json, r'assertion'),
        attestation: mapValueOfType<String>(json, r'attestation'),
        keyId: mapValueOfType<String>(json, r'key_id')!,
      );
    }
    return null;
  }

  static List<AppleAppAttest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AppleAppAttest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppleAppAttest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppleAppAttest> mapFromJson(dynamic json) {
    final map = <String, AppleAppAttest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppleAppAttest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppleAppAttest-objects as value to a dart map
  static Map<String, List<AppleAppAttest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AppleAppAttest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppleAppAttest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'key_id',
  };
}

