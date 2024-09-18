//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SignInWithLoginInfo {
  /// Returns a new [SignInWithLoginInfo] instance.
  SignInWithLoginInfo({
    this.appleToken,
    required this.clientInfo,
    this.googleToken,
  });

  String? appleToken;

  ClientInfo clientInfo;

  String? googleToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignInWithLoginInfo &&
    other.appleToken == appleToken &&
    other.clientInfo == clientInfo &&
    other.googleToken == googleToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (appleToken == null ? 0 : appleToken!.hashCode) +
    (clientInfo.hashCode) +
    (googleToken == null ? 0 : googleToken!.hashCode);

  @override
  String toString() => 'SignInWithLoginInfo[appleToken=$appleToken, clientInfo=$clientInfo, googleToken=$googleToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.appleToken != null) {
      json[r'apple_token'] = this.appleToken;
    } else {
      json[r'apple_token'] = null;
    }
      json[r'client_info'] = this.clientInfo;
    if (this.googleToken != null) {
      json[r'google_token'] = this.googleToken;
    } else {
      json[r'google_token'] = null;
    }
    return json;
  }

  /// Returns a new [SignInWithLoginInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignInWithLoginInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SignInWithLoginInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SignInWithLoginInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SignInWithLoginInfo(
        appleToken: mapValueOfType<String>(json, r'apple_token'),
        clientInfo: ClientInfo.fromJson(json[r'client_info'])!,
        googleToken: mapValueOfType<String>(json, r'google_token'),
      );
    }
    return null;
  }

  static List<SignInWithLoginInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignInWithLoginInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignInWithLoginInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignInWithLoginInfo> mapFromJson(dynamic json) {
    final map = <String, SignInWithLoginInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignInWithLoginInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignInWithLoginInfo-objects as value to a dart map
  static Map<String, List<SignInWithLoginInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignInWithLoginInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignInWithLoginInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'client_info',
  };
}

