//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetPrivatePublicKeyInfo {
  /// Returns a new [GetPrivatePublicKeyInfo] instance.
  GetPrivatePublicKeyInfo({
    this.latestPublicKeyId,
    required this.maxPublicKeyCountFromAccountConfig,
    required this.maxPublicKeyCountFromBackendConfig,
  });

  PublicKeyId? latestPublicKeyId;

  int maxPublicKeyCountFromAccountConfig;

  int maxPublicKeyCountFromBackendConfig;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetPrivatePublicKeyInfo &&
    other.latestPublicKeyId == latestPublicKeyId &&
    other.maxPublicKeyCountFromAccountConfig == maxPublicKeyCountFromAccountConfig &&
    other.maxPublicKeyCountFromBackendConfig == maxPublicKeyCountFromBackendConfig;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (latestPublicKeyId == null ? 0 : latestPublicKeyId!.hashCode) +
    (maxPublicKeyCountFromAccountConfig.hashCode) +
    (maxPublicKeyCountFromBackendConfig.hashCode);

  @override
  String toString() => 'GetPrivatePublicKeyInfo[latestPublicKeyId=$latestPublicKeyId, maxPublicKeyCountFromAccountConfig=$maxPublicKeyCountFromAccountConfig, maxPublicKeyCountFromBackendConfig=$maxPublicKeyCountFromBackendConfig]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.latestPublicKeyId != null) {
      json[r'latest_public_key_id'] = this.latestPublicKeyId;
    } else {
      json[r'latest_public_key_id'] = null;
    }
      json[r'max_public_key_count_from_account_config'] = this.maxPublicKeyCountFromAccountConfig;
      json[r'max_public_key_count_from_backend_config'] = this.maxPublicKeyCountFromBackendConfig;
    return json;
  }

  /// Returns a new [GetPrivatePublicKeyInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetPrivatePublicKeyInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetPrivatePublicKeyInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetPrivatePublicKeyInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetPrivatePublicKeyInfo(
        latestPublicKeyId: PublicKeyId.fromJson(json[r'latest_public_key_id']),
        maxPublicKeyCountFromAccountConfig: mapValueOfType<int>(json, r'max_public_key_count_from_account_config')!,
        maxPublicKeyCountFromBackendConfig: mapValueOfType<int>(json, r'max_public_key_count_from_backend_config')!,
      );
    }
    return null;
  }

  static List<GetPrivatePublicKeyInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetPrivatePublicKeyInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetPrivatePublicKeyInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetPrivatePublicKeyInfo> mapFromJson(dynamic json) {
    final map = <String, GetPrivatePublicKeyInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetPrivatePublicKeyInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetPrivatePublicKeyInfo-objects as value to a dart map
  static Map<String, List<GetPrivatePublicKeyInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetPrivatePublicKeyInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetPrivatePublicKeyInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'max_public_key_count_from_account_config',
    'max_public_key_count_from_backend_config',
  };
}
