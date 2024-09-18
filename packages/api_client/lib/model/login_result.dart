//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginResult {
  /// Returns a new [LoginResult] instance.
  LoginResult({
    this.account,
    this.aid,
    this.email,
    this.errorUnsupportedClient = false,
    this.latestPublicKeys = const [],
    this.media,
    this.profile,
  });

  AuthPair? account;

  AccountId? aid;

  String? email;

  bool errorUnsupportedClient;

  /// Info about latest public keys. Client can use this value to ask if user wants to copy existing private and public key from other device. If empty, public key is not set or the client is unsupported.
  List<PublicKeyIdAndVersion> latestPublicKeys;

  AuthPair? media;

  AuthPair? profile;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginResult &&
    other.account == account &&
    other.aid == aid &&
    other.email == email &&
    other.errorUnsupportedClient == errorUnsupportedClient &&
    _deepEquality.equals(other.latestPublicKeys, latestPublicKeys) &&
    other.media == media &&
    other.profile == profile;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (account == null ? 0 : account!.hashCode) +
    (aid == null ? 0 : aid!.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (errorUnsupportedClient.hashCode) +
    (latestPublicKeys.hashCode) +
    (media == null ? 0 : media!.hashCode) +
    (profile == null ? 0 : profile!.hashCode);

  @override
  String toString() => 'LoginResult[account=$account, aid=$aid, email=$email, errorUnsupportedClient=$errorUnsupportedClient, latestPublicKeys=$latestPublicKeys, media=$media, profile=$profile]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.account != null) {
      json[r'account'] = this.account;
    } else {
      json[r'account'] = null;
    }
    if (this.aid != null) {
      json[r'aid'] = this.aid;
    } else {
      json[r'aid'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
      json[r'error_unsupported_client'] = this.errorUnsupportedClient;
      json[r'latest_public_keys'] = this.latestPublicKeys;
    if (this.media != null) {
      json[r'media'] = this.media;
    } else {
      json[r'media'] = null;
    }
    if (this.profile != null) {
      json[r'profile'] = this.profile;
    } else {
      json[r'profile'] = null;
    }
    return json;
  }

  /// Returns a new [LoginResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LoginResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LoginResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LoginResult(
        account: AuthPair.fromJson(json[r'account']),
        aid: AccountId.fromJson(json[r'aid']),
        email: mapValueOfType<String>(json, r'email'),
        errorUnsupportedClient: mapValueOfType<bool>(json, r'error_unsupported_client') ?? false,
        latestPublicKeys: PublicKeyIdAndVersion.listFromJson(json[r'latest_public_keys']),
        media: AuthPair.fromJson(json[r'media']),
        profile: AuthPair.fromJson(json[r'profile']),
      );
    }
    return null;
  }

  static List<LoginResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginResult> mapFromJson(dynamic json) {
    final map = <String, LoginResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginResult-objects as value to a dart map
  static Map<String, List<LoginResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

