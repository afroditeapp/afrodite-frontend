//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SignInWithAppleInfo {
  /// Returns a new [SignInWithAppleInfo] instance.
  SignInWithAppleInfo({
    required this.nonce,
    required this.token,
  });

  /// Base64 URL (with possible padding) encoded nonce.  The token contains Base64 URL (with possible padding) encoded SHA-256 of the nonce.
  String nonce;

  String token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignInWithAppleInfo &&
    other.nonce == nonce &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (nonce.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'SignInWithAppleInfo[nonce=$nonce, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'nonce'] = this.nonce;
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [SignInWithAppleInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignInWithAppleInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SignInWithAppleInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SignInWithAppleInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SignInWithAppleInfo(
        nonce: mapValueOfType<String>(json, r'nonce')!,
        token: mapValueOfType<String>(json, r'token')!,
      );
    }
    return null;
  }

  static List<SignInWithAppleInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignInWithAppleInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignInWithAppleInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignInWithAppleInfo> mapFromJson(dynamic json) {
    final map = <String, SignInWithAppleInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignInWithAppleInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignInWithAppleInfo-objects as value to a dart map
  static Map<String, List<SignInWithAppleInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignInWithAppleInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignInWithAppleInfo.listFromJson(entry.value, growable: growable,);
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

