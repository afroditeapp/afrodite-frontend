//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RequestAppAttestChallenge {
  /// Returns a new [RequestAppAttestChallenge] instance.
  RequestAppAttestChallenge({
    this.appleAppAttestKeyId,
    required this.token,
  });

  /// Base64-encoded Apple App Attest key identifier to check if the server already has the key stored. When set, the response contains [RequestAppAttestChallengeResult::apple_app_attest_key_exists].
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? appleAppAttestKeyId;

  VerifyAppAttestationToken token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestAppAttestChallenge &&
    other.appleAppAttestKeyId == appleAppAttestKeyId &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (appleAppAttestKeyId == null ? 0 : appleAppAttestKeyId!.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'RequestAppAttestChallenge[appleAppAttestKeyId=$appleAppAttestKeyId, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.appleAppAttestKeyId != null) {
      json[r'apple_app_attest_key_id'] = this.appleAppAttestKeyId;
    } else {
      json[r'apple_app_attest_key_id'] = null;
    }
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [RequestAppAttestChallenge] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RequestAppAttestChallenge? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'), 'Required key "RequestAppAttestChallenge[token]" is missing from JSON.');
        assert(json[r'token'] != null, 'Required key "RequestAppAttestChallenge[token]" has a null value in JSON.');
        return true;
      }());

      return RequestAppAttestChallenge(
        appleAppAttestKeyId: mapValueOfType<String>(json, r'apple_app_attest_key_id'),
        token: VerifyAppAttestationToken.fromJson(json[r'token'])!,
      );
    }
    return null;
  }

  static List<RequestAppAttestChallenge> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RequestAppAttestChallenge>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RequestAppAttestChallenge.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RequestAppAttestChallenge> mapFromJson(dynamic json) {
    final map = <String, RequestAppAttestChallenge>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RequestAppAttestChallenge.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RequestAppAttestChallenge-objects as value to a dart map
  static Map<String, List<RequestAppAttestChallenge>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RequestAppAttestChallenge>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RequestAppAttestChallenge.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
  };
}

