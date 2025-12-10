//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BackupTransferInitialMessage {
  /// Returns a new [BackupTransferInitialMessage] instance.
  BackupTransferInitialMessage({
    this.accessToken,
    required this.role,
    this.targetData,
    this.targetDataSha256,
  });

  /// Access token from target client
  String? accessToken;

  BackupTransferClientRole role;

  /// Data from target client
  String? targetData;

  /// SHA256 hash of target's data from source client. The hash is in hexadecimal format.
  String? targetDataSha256;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BackupTransferInitialMessage &&
    other.accessToken == accessToken &&
    other.role == role &&
    other.targetData == targetData &&
    other.targetDataSha256 == targetDataSha256;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accessToken == null ? 0 : accessToken!.hashCode) +
    (role.hashCode) +
    (targetData == null ? 0 : targetData!.hashCode) +
    (targetDataSha256 == null ? 0 : targetDataSha256!.hashCode);

  @override
  String toString() => 'BackupTransferInitialMessage[accessToken=$accessToken, role=$role, targetData=$targetData, targetDataSha256=$targetDataSha256]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.accessToken != null) {
      json[r'access_token'] = this.accessToken;
    } else {
      json[r'access_token'] = null;
    }
      json[r'role'] = this.role;
    if (this.targetData != null) {
      json[r'target_data'] = this.targetData;
    } else {
      json[r'target_data'] = null;
    }
    if (this.targetDataSha256 != null) {
      json[r'target_data_sha256'] = this.targetDataSha256;
    } else {
      json[r'target_data_sha256'] = null;
    }
    return json;
  }

  /// Returns a new [BackupTransferInitialMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BackupTransferInitialMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BackupTransferInitialMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BackupTransferInitialMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BackupTransferInitialMessage(
        accessToken: mapValueOfType<String>(json, r'access_token'),
        role: BackupTransferClientRole.fromJson(json[r'role'])!,
        targetData: mapValueOfType<String>(json, r'target_data'),
        targetDataSha256: mapValueOfType<String>(json, r'target_data_sha256'),
      );
    }
    return null;
  }

  static List<BackupTransferInitialMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BackupTransferInitialMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BackupTransferInitialMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BackupTransferInitialMessage> mapFromJson(dynamic json) {
    final map = <String, BackupTransferInitialMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BackupTransferInitialMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BackupTransferInitialMessage-objects as value to a dart map
  static Map<String, List<BackupTransferInitialMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BackupTransferInitialMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BackupTransferInitialMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'role',
  };
}

