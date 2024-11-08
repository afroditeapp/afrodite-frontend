//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Permissions {
  /// Returns a new [Permissions] instance.
  Permissions({
    this.adminModerateImages = false,
    this.adminModerateProfileNames = false,
    this.adminModerateProfileTexts = false,
    this.adminModerateProfiles = false,
    this.adminModifyPermissions = false,
    this.adminNewsCreate = false,
    this.adminNewsEditAll = false,
    this.adminProfileStatistics = false,
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

  bool adminModerateProfileNames;

  bool adminModerateProfileTexts;

  bool adminModerateProfiles;

  bool adminModifyPermissions;

  bool adminNewsCreate;

  bool adminNewsEditAll;

  bool adminProfileStatistics;

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
  bool operator ==(Object other) => identical(this, other) || other is Permissions &&
    other.adminModerateImages == adminModerateImages &&
    other.adminModerateProfileNames == adminModerateProfileNames &&
    other.adminModerateProfileTexts == adminModerateProfileTexts &&
    other.adminModerateProfiles == adminModerateProfiles &&
    other.adminModifyPermissions == adminModifyPermissions &&
    other.adminNewsCreate == adminNewsCreate &&
    other.adminNewsEditAll == adminNewsEditAll &&
    other.adminProfileStatistics == adminProfileStatistics &&
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
    (adminModerateProfileNames.hashCode) +
    (adminModerateProfileTexts.hashCode) +
    (adminModerateProfiles.hashCode) +
    (adminModifyPermissions.hashCode) +
    (adminNewsCreate.hashCode) +
    (adminNewsEditAll.hashCode) +
    (adminProfileStatistics.hashCode) +
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
  String toString() => 'Permissions[adminModerateImages=$adminModerateImages, adminModerateProfileNames=$adminModerateProfileNames, adminModerateProfileTexts=$adminModerateProfileTexts, adminModerateProfiles=$adminModerateProfiles, adminModifyPermissions=$adminModifyPermissions, adminNewsCreate=$adminNewsCreate, adminNewsEditAll=$adminNewsEditAll, adminProfileStatistics=$adminProfileStatistics, adminServerMaintenanceRebootBackend=$adminServerMaintenanceRebootBackend, adminServerMaintenanceResetData=$adminServerMaintenanceResetData, adminServerMaintenanceSaveBackendConfig=$adminServerMaintenanceSaveBackendConfig, adminServerMaintenanceUpdateSoftware=$adminServerMaintenanceUpdateSoftware, adminServerMaintenanceViewBackendConfig=$adminServerMaintenanceViewBackendConfig, adminServerMaintenanceViewInfo=$adminServerMaintenanceViewInfo, adminViewAllProfiles=$adminViewAllProfiles, adminViewPrivateInfo=$adminViewPrivateInfo, adminViewProfileHistory=$adminViewProfileHistory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'admin_moderate_images'] = this.adminModerateImages;
      json[r'admin_moderate_profile_names'] = this.adminModerateProfileNames;
      json[r'admin_moderate_profile_texts'] = this.adminModerateProfileTexts;
      json[r'admin_moderate_profiles'] = this.adminModerateProfiles;
      json[r'admin_modify_permissions'] = this.adminModifyPermissions;
      json[r'admin_news_create'] = this.adminNewsCreate;
      json[r'admin_news_edit_all'] = this.adminNewsEditAll;
      json[r'admin_profile_statistics'] = this.adminProfileStatistics;
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

  /// Returns a new [Permissions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Permissions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Permissions[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Permissions[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Permissions(
        adminModerateImages: mapValueOfType<bool>(json, r'admin_moderate_images') ?? false,
        adminModerateProfileNames: mapValueOfType<bool>(json, r'admin_moderate_profile_names') ?? false,
        adminModerateProfileTexts: mapValueOfType<bool>(json, r'admin_moderate_profile_texts') ?? false,
        adminModerateProfiles: mapValueOfType<bool>(json, r'admin_moderate_profiles') ?? false,
        adminModifyPermissions: mapValueOfType<bool>(json, r'admin_modify_permissions') ?? false,
        adminNewsCreate: mapValueOfType<bool>(json, r'admin_news_create') ?? false,
        adminNewsEditAll: mapValueOfType<bool>(json, r'admin_news_edit_all') ?? false,
        adminProfileStatistics: mapValueOfType<bool>(json, r'admin_profile_statistics') ?? false,
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

  static List<Permissions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Permissions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Permissions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Permissions> mapFromJson(dynamic json) {
    final map = <String, Permissions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Permissions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Permissions-objects as value to a dart map
  static Map<String, List<Permissions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Permissions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Permissions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

