//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VerifyAppAttestationToken {
  /// Returns a new [VerifyAppAttestationToken] instance.
  VerifyAppAttestationToken({
    required this.token,
  });

  String token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerifyAppAttestationToken &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode);

  @override
  String toString() => 'VerifyAppAttestationToken[token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [VerifyAppAttestationToken] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerifyAppAttestationToken? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'), 'Required key "VerifyAppAttestationToken[token]" is missing from JSON.');
        assert(json[r'token'] != null, 'Required key "VerifyAppAttestationToken[token]" has a null value in JSON.');
        return true;
      }());

      return VerifyAppAttestationToken(
        token: mapValueOfType<String>(json, r'token')!,
      );
    }
    return null;
  }

  static List<VerifyAppAttestationToken> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerifyAppAttestationToken>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerifyAppAttestationToken.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerifyAppAttestationToken> mapFromJson(dynamic json) {
    final map = <String, VerifyAppAttestationToken>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerifyAppAttestationToken.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerifyAppAttestationToken-objects as value to a dart map
  static Map<String, List<VerifyAppAttestationToken>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerifyAppAttestationToken>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerifyAppAttestationToken.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
  };
}

