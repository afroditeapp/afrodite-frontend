//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PlayIntegrityAppAttestation {
  /// Returns a new [PlayIntegrityAppAttestation] instance.
  PlayIntegrityAppAttestation({
    required this.token,
  });

  /// Google Play Integrity API verdict token as returned by the client.
  String token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PlayIntegrityAppAttestation &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode);

  @override
  String toString() => 'PlayIntegrityAppAttestation[token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [PlayIntegrityAppAttestation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PlayIntegrityAppAttestation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'), 'Required key "PlayIntegrityAppAttestation[token]" is missing from JSON.');
        assert(json[r'token'] != null, 'Required key "PlayIntegrityAppAttestation[token]" has a null value in JSON.');
        return true;
      }());

      return PlayIntegrityAppAttestation(
        token: mapValueOfType<String>(json, r'token')!,
      );
    }
    return null;
  }

  static List<PlayIntegrityAppAttestation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PlayIntegrityAppAttestation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PlayIntegrityAppAttestation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PlayIntegrityAppAttestation> mapFromJson(dynamic json) {
    final map = <String, PlayIntegrityAppAttestation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PlayIntegrityAppAttestation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PlayIntegrityAppAttestation-objects as value to a dart map
  static Map<String, List<PlayIntegrityAppAttestation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PlayIntegrityAppAttestation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PlayIntegrityAppAttestation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
  };
}

