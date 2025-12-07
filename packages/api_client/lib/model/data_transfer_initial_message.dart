//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DataTransferInitialMessage {
  /// Returns a new [DataTransferInitialMessage] instance.
  DataTransferInitialMessage({
    this.accessToken,
    this.accountId,
    this.password,
    this.publicKey,
    required this.role,
  });

  /// Access token from target client
  String? accessToken;

  /// Account ID from source client
  String? accountId;

  /// Password from target and source clients.  Target sets the required password and Source must know it. The password exists to avoid constant polling to find new waiting Target clients.
  String? password;

  /// Public key from target client
  String? publicKey;

  ClientRole role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DataTransferInitialMessage &&
    other.accessToken == accessToken &&
    other.accountId == accountId &&
    other.password == password &&
    other.publicKey == publicKey &&
    other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accessToken == null ? 0 : accessToken!.hashCode) +
    (accountId == null ? 0 : accountId!.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (publicKey == null ? 0 : publicKey!.hashCode) +
    (role.hashCode);

  @override
  String toString() => 'DataTransferInitialMessage[accessToken=$accessToken, accountId=$accountId, password=$password, publicKey=$publicKey, role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accessToken != null) {
      json[r'access_token'] = this.accessToken;
    } else {
      json[r'access_token'] = null;
    }
    if (this.accountId != null) {
      json[r'account_id'] = this.accountId;
    } else {
      json[r'account_id'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
    if (this.publicKey != null) {
      json[r'public_key'] = this.publicKey;
    } else {
      json[r'public_key'] = null;
    }
      json[r'role'] = this.role;
    return json;
  }

  /// Returns a new [DataTransferInitialMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DataTransferInitialMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DataTransferInitialMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DataTransferInitialMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DataTransferInitialMessage(
        accessToken: mapValueOfType<String>(json, r'access_token'),
        accountId: mapValueOfType<String>(json, r'account_id'),
        password: mapValueOfType<String>(json, r'password'),
        publicKey: mapValueOfType<String>(json, r'public_key'),
        role: ClientRole.fromJson(json[r'role'])!,
      );
    }
    return null;
  }

  static List<DataTransferInitialMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DataTransferInitialMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DataTransferInitialMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DataTransferInitialMessage> mapFromJson(dynamic json) {
    final map = <String, DataTransferInitialMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DataTransferInitialMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DataTransferInitialMessage-objects as value to a dart map
  static Map<String, List<DataTransferInitialMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DataTransferInitialMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DataTransferInitialMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'role',
  };
}

