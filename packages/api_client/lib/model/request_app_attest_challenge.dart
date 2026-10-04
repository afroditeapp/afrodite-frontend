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
    required this.token,
  });

  VerifyAppAttestationToken token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RequestAppAttestChallenge &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode);

  @override
  String toString() => 'RequestAppAttestChallenge[token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
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

