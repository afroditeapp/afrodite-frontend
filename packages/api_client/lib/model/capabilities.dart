//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Capabilities {
  /// Returns a new [Capabilities] instance.
  Capabilities({
    this.adminModerateImages = false,
    this.adminModerateProfiles = false,
    this.adminModifyCapabilities = false,
    this.adminServerMaintenanceRebootBackend = false,
    this.adminServerMaintenanceResetData = false,
    this.adminServerMaintenanceSaveBackendConfig = false,
    this.adminServerMaintenanceUpdateSoftware = false,
    this.adminServerMaintenanceViewBackendConfig = false,
    this.adminServerMaintenanceViewInfo = false,
    this.adminViewAllProfiles = false,
    this.adminViewPrivateInfo = false,
    this.adminViewProfileHistory = false,
  });

  bool adminModerateImages;

  bool adminModerateProfiles;

  bool adminModifyCapabilities;

  bool adminServerMaintenanceRebootBackend;

  bool adminServerMaintenanceResetData;

  bool adminServerMaintenanceSaveBackendConfig;

  bool adminServerMaintenanceUpdateSoftware;

  bool adminServerMaintenanceViewBackendConfig;

  /// View server infrastructure related info like logs and software versions.
  bool adminServerMaintenanceViewInfo;

  /// View public and private profiles.
  bool adminViewAllProfiles;

  bool adminViewPrivateInfo;

  bool adminViewProfileHistory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Capabilities &&
    other.adminModerateImages == adminModerateImages &&
    other.adminModerateProfiles == adminModerateProfiles &&
    other.adminModifyCapabilities == adminModifyCapabilities &&
    other.adminServerMaintenanceRebootBackend == adminServerMaintenanceRebootBackend &&
    other.adminServerMaintenanceResetData == adminServerMaintenanceResetData &&
    other.adminServerMaintenanceSaveBackendConfig == adminServerMaintenanceSaveBackendConfig &&
    other.adminServerMaintenanceUpdateSoftware == adminServerMaintenanceUpdateSoftware &&
    other.adminServerMaintenanceViewBackendConfig == adminServerMaintenanceViewBackendConfig &&
    other.adminServerMaintenanceViewInfo == adminServerMaintenanceViewInfo &&
    other.adminViewAllProfiles == adminViewAllProfiles &&
    other.adminViewPrivateInfo == adminViewPrivateInfo &&
    other.adminViewProfileHistory == adminViewProfileHistory;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminModerateImages.hashCode) +
    (adminModerateProfiles.hashCode) +
    (adminModifyCapabilities.hashCode) +
    (adminServerMaintenanceRebootBackend.hashCode) +
    (adminServerMaintenanceResetData.hashCode) +
    (adminServerMaintenanceSaveBackendConfig.hashCode) +
    (adminServerMaintenanceUpdateSoftware.hashCode) +
    (adminServerMaintenanceViewBackendConfig.hashCode) +
    (adminServerMaintenanceViewInfo.hashCode) +
    (adminViewAllProfiles.hashCode) +
    (adminViewPrivateInfo.hashCode) +
    (adminViewProfileHistory.hashCode);

  @override
  String toString() => 'Capabilities[adminModerateImages=$adminModerateImages, adminModerateProfiles=$adminModerateProfiles, adminModifyCapabilities=$adminModifyCapabilities, adminServerMaintenanceRebootBackend=$adminServerMaintenanceRebootBackend, adminServerMaintenanceResetData=$adminServerMaintenanceResetData, adminServerMaintenanceSaveBackendConfig=$adminServerMaintenanceSaveBackendConfig, adminServerMaintenanceUpdateSoftware=$adminServerMaintenanceUpdateSoftware, adminServerMaintenanceViewBackendConfig=$adminServerMaintenanceViewBackendConfig, adminServerMaintenanceViewInfo=$adminServerMaintenanceViewInfo, adminViewAllProfiles=$adminViewAllProfiles, adminViewPrivateInfo=$adminViewPrivateInfo, adminViewProfileHistory=$adminViewProfileHistory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'admin_moderate_images'] = this.adminModerateImages;
      json[r'admin_moderate_profiles'] = this.adminModerateProfiles;
      json[r'admin_modify_capabilities'] = this.adminModifyCapabilities;
      json[r'admin_server_maintenance_reboot_backend'] = this.adminServerMaintenanceRebootBackend;
      json[r'admin_server_maintenance_reset_data'] = this.adminServerMaintenanceResetData;
      json[r'admin_server_maintenance_save_backend_config'] = this.adminServerMaintenanceSaveBackendConfig;
      json[r'admin_server_maintenance_update_software'] = this.adminServerMaintenanceUpdateSoftware;
      json[r'admin_server_maintenance_view_backend_config'] = this.adminServerMaintenanceViewBackendConfig;
      json[r'admin_server_maintenance_view_info'] = this.adminServerMaintenanceViewInfo;
      json[r'admin_view_all_profiles'] = this.adminViewAllProfiles;
      json[r'admin_view_private_info'] = this.adminViewPrivateInfo;
      json[r'admin_view_profile_history'] = this.adminViewProfileHistory;
    return json;
  }

  /// Returns a new [Capabilities] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Capabilities? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Capabilities[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Capabilities[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Capabilities(
        adminModerateImages: mapValueOfType<bool>(json, r'admin_moderate_images') ?? false,
        adminModerateProfiles: mapValueOfType<bool>(json, r'admin_moderate_profiles') ?? false,
        adminModifyCapabilities: mapValueOfType<bool>(json, r'admin_modify_capabilities') ?? false,
        adminServerMaintenanceRebootBackend: mapValueOfType<bool>(json, r'admin_server_maintenance_reboot_backend') ?? false,
        adminServerMaintenanceResetData: mapValueOfType<bool>(json, r'admin_server_maintenance_reset_data') ?? false,
        adminServerMaintenanceSaveBackendConfig: mapValueOfType<bool>(json, r'admin_server_maintenance_save_backend_config') ?? false,
        adminServerMaintenanceUpdateSoftware: mapValueOfType<bool>(json, r'admin_server_maintenance_update_software') ?? false,
        adminServerMaintenanceViewBackendConfig: mapValueOfType<bool>(json, r'admin_server_maintenance_view_backend_config') ?? false,
        adminServerMaintenanceViewInfo: mapValueOfType<bool>(json, r'admin_server_maintenance_view_info') ?? false,
        adminViewAllProfiles: mapValueOfType<bool>(json, r'admin_view_all_profiles') ?? false,
        adminViewPrivateInfo: mapValueOfType<bool>(json, r'admin_view_private_info') ?? false,
        adminViewProfileHistory: mapValueOfType<bool>(json, r'admin_view_profile_history') ?? false,
      );
    }
    return null;
  }

  static List<Capabilities> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Capabilities>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Capabilities.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Capabilities> mapFromJson(dynamic json) {
    final map = <String, Capabilities>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Capabilities.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Capabilities-objects as value to a dart map
  static Map<String, List<Capabilities>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Capabilities>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Capabilities.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

