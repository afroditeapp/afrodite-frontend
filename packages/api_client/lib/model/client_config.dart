//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientConfig {
  /// Returns a new [ClientConfig] instance.
  ClientConfig({
    this.clientFeatures,
    this.customReports,
    this.profileAttributes,
    required this.syncVersion,
  });

  /// Account component specific config. It is also possible that client features are not configured.
  ClientFeaturesConfigHash? clientFeatures;

  /// Account component specific config. It is also possible that custom reports are not configured.
  CustomReportsConfigHash? customReports;

  /// Profile component specific config. It is also possible that attributes are not configured.
  PartialProfileAttributesConfig? profileAttributes;

  ClientConfigSyncVersion syncVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientConfig &&
    other.clientFeatures == clientFeatures &&
    other.customReports == customReports &&
    other.profileAttributes == profileAttributes &&
    other.syncVersion == syncVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (clientFeatures == null ? 0 : clientFeatures!.hashCode) +
    (customReports == null ? 0 : customReports!.hashCode) +
    (profileAttributes == null ? 0 : profileAttributes!.hashCode) +
    (syncVersion.hashCode);

  @override
  String toString() => 'ClientConfig[clientFeatures=$clientFeatures, customReports=$customReports, profileAttributes=$profileAttributes, syncVersion=$syncVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.clientFeatures != null) {
      json[r'client_features'] = this.clientFeatures;
    } else {
      json[r'client_features'] = null;
    }
    if (this.customReports != null) {
      json[r'custom_reports'] = this.customReports;
    } else {
      json[r'custom_reports'] = null;
    }
    if (this.profileAttributes != null) {
      json[r'profile_attributes'] = this.profileAttributes;
    } else {
      json[r'profile_attributes'] = null;
    }
      json[r'sync_version'] = this.syncVersion;
    return json;
  }

  /// Returns a new [ClientConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientConfig(
        clientFeatures: ClientFeaturesConfigHash.fromJson(json[r'client_features']),
        customReports: CustomReportsConfigHash.fromJson(json[r'custom_reports']),
        profileAttributes: PartialProfileAttributesConfig.fromJson(json[r'profile_attributes']),
        syncVersion: ClientConfigSyncVersion.fromJson(json[r'sync_version'])!,
      );
    }
    return null;
  }

  static List<ClientConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientConfig> mapFromJson(dynamic json) {
    final map = <String, ClientConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientConfig-objects as value to a dart map
  static Map<String, List<ClientConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sync_version',
  };
}

