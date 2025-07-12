//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SignInWithGoogleInfo {
  /// Returns a new [SignInWithGoogleInfo] instance.
  SignInWithGoogleInfo({
    required this.nonce,
    required this.token,
  });

  /// Base64 URL (with possible padding) encoded nonce.  The token contains Base64 URL (with possible padding) encoded SHA-256 of the nonce.
  String nonce;

  String token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignInWithGoogleInfo &&
    other.nonce == nonce &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (nonce.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'SignInWithGoogleInfo[nonce=$nonce, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'nonce'] = this.nonce;
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [SignInWithGoogleInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignInWithGoogleInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SignInWithGoogleInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SignInWithGoogleInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SignInWithGoogleInfo(
        nonce: mapValueOfType<String>(json, r'nonce')!,
        token: mapValueOfType<String>(json, r'token')!,
      );
    }
    return null;
  }

  static List<SignInWithGoogleInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignInWithGoogleInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignInWithGoogleInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignInWithGoogleInfo> mapFromJson(dynamic json) {
    final map = <String, SignInWithGoogleInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignInWithGoogleInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignInWithGoogleInfo-objects as value to a dart map
  static Map<String, List<SignInWithGoogleInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignInWithGoogleInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignInWithGoogleInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'nonce',
    'token',
  };
}

