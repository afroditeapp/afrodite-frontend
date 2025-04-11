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
    this.adminBanAccount = false,
    this.adminDeleteAccount = false,
    this.adminDeleteMediaContent = false,
    this.adminEditMaxPublicKeyCount = false,
    this.adminEditProfileName = false,
    this.adminFindAccountByEmail = false,
    this.adminModerateMediaContent = false,
    this.adminModerateProfileNames = false,
    this.adminModerateProfileTexts = false,
    this.adminModifyPermissions = false,
    this.adminNewsCreate = false,
    this.adminNewsEditAll = false,
    this.adminProcessReports = false,
    this.adminProfileStatistics = false,
    this.adminRequestAccountDeletion = false,
    this.adminServerMaintenanceEditNotification = false,
    this.adminServerMaintenanceRebootBackend = false,
    this.adminServerMaintenanceResetData = false,
    this.adminServerMaintenanceSaveBackendConfig = false,
    this.adminServerMaintenanceUpdateSoftware = false,
    this.adminServerMaintenanceViewBackendConfig = false,
    this.adminServerMaintenanceViewInfo = false,
    this.adminViewAllProfiles = false,
    this.adminViewPermissions = false,
    this.adminViewPrivateInfo = false,
    this.adminViewProfileHistory = false,
  });

  bool adminBanAccount;

  bool adminDeleteAccount;

  bool adminDeleteMediaContent;

  bool adminEditMaxPublicKeyCount;

  bool adminEditProfileName;

  bool adminFindAccountByEmail;

  bool adminModerateMediaContent;

  bool adminModerateProfileNames;

  bool adminModerateProfileTexts;

  bool adminModifyPermissions;

  bool adminNewsCreate;

  bool adminNewsEditAll;

  bool adminProcessReports;

  bool adminProfileStatistics;

  bool adminRequestAccountDeletion;

  bool adminServerMaintenanceEditNotification;

  bool adminServerMaintenanceRebootBackend;

  bool adminServerMaintenanceResetData;

  bool adminServerMaintenanceSaveBackendConfig;

  bool adminServerMaintenanceUpdateSoftware;

  bool adminServerMaintenanceViewBackendConfig;

  /// View server infrastructure related info like logs and software versions.
  bool adminServerMaintenanceViewInfo;

  /// View public and private profiles.
  bool adminViewAllProfiles;

  bool adminViewPermissions;

  bool adminViewPrivateInfo;

  bool adminViewProfileHistory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Permissions &&
    other.adminBanAccount == adminBanAccount &&
    other.adminDeleteAccount == adminDeleteAccount &&
    other.adminDeleteMediaContent == adminDeleteMediaContent &&
    other.adminEditMaxPublicKeyCount == adminEditMaxPublicKeyCount &&
    other.adminEditProfileName == adminEditProfileName &&
    other.adminFindAccountByEmail == adminFindAccountByEmail &&
    other.adminModerateMediaContent == adminModerateMediaContent &&
    other.adminModerateProfileNames == adminModerateProfileNames &&
    other.adminModerateProfileTexts == adminModerateProfileTexts &&
    other.adminModifyPermissions == adminModifyPermissions &&
    other.adminNewsCreate == adminNewsCreate &&
    other.adminNewsEditAll == adminNewsEditAll &&
    other.adminProcessReports == adminProcessReports &&
    other.adminProfileStatistics == adminProfileStatistics &&
    other.adminRequestAccountDeletion == adminRequestAccountDeletion &&
    other.adminServerMaintenanceEditNotification == adminServerMaintenanceEditNotification &&
    other.adminServerMaintenanceRebootBackend == adminServerMaintenanceRebootBackend &&
    other.adminServerMaintenanceResetData == adminServerMaintenanceResetData &&
    other.adminServerMaintenanceSaveBackendConfig == adminServerMaintenanceSaveBackendConfig &&
    other.adminServerMaintenanceUpdateSoftware == adminServerMaintenanceUpdateSoftware &&
    other.adminServerMaintenanceViewBackendConfig == adminServerMaintenanceViewBackendConfig &&
    other.adminServerMaintenanceViewInfo == adminServerMaintenanceViewInfo &&
    other.adminViewAllProfiles == adminViewAllProfiles &&
    other.adminViewPermissions == adminViewPermissions &&
    other.adminViewPrivateInfo == adminViewPrivateInfo &&
    other.adminViewProfileHistory == adminViewProfileHistory;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminBanAccount.hashCode) +
    (adminDeleteAccount.hashCode) +
    (adminDeleteMediaContent.hashCode) +
    (adminEditMaxPublicKeyCount.hashCode) +
    (adminEditProfileName.hashCode) +
    (adminFindAccountByEmail.hashCode) +
    (adminModerateMediaContent.hashCode) +
    (adminModerateProfileNames.hashCode) +
    (adminModerateProfileTexts.hashCode) +
    (adminModifyPermissions.hashCode) +
    (adminNewsCreate.hashCode) +
    (adminNewsEditAll.hashCode) +
    (adminProcessReports.hashCode) +
    (adminProfileStatistics.hashCode) +
    (adminRequestAccountDeletion.hashCode) +
    (adminServerMaintenanceEditNotification.hashCode) +
    (adminServerMaintenanceRebootBackend.hashCode) +
    (adminServerMaintenanceResetData.hashCode) +
    (adminServerMaintenanceSaveBackendConfig.hashCode) +
    (adminServerMaintenanceUpdateSoftware.hashCode) +
    (adminServerMaintenanceViewBackendConfig.hashCode) +
    (adminServerMaintenanceViewInfo.hashCode) +
    (adminViewAllProfiles.hashCode) +
    (adminViewPermissions.hashCode) +
    (adminViewPrivateInfo.hashCode) +
    (adminViewProfileHistory.hashCode);

  @override
  String toString() => 'Permissions[adminBanAccount=$adminBanAccount, adminDeleteAccount=$adminDeleteAccount, adminDeleteMediaContent=$adminDeleteMediaContent, adminEditMaxPublicKeyCount=$adminEditMaxPublicKeyCount, adminEditProfileName=$adminEditProfileName, adminFindAccountByEmail=$adminFindAccountByEmail, adminModerateMediaContent=$adminModerateMediaContent, adminModerateProfileNames=$adminModerateProfileNames, adminModerateProfileTexts=$adminModerateProfileTexts, adminModifyPermissions=$adminModifyPermissions, adminNewsCreate=$adminNewsCreate, adminNewsEditAll=$adminNewsEditAll, adminProcessReports=$adminProcessReports, adminProfileStatistics=$adminProfileStatistics, adminRequestAccountDeletion=$adminRequestAccountDeletion, adminServerMaintenanceEditNotification=$adminServerMaintenanceEditNotification, adminServerMaintenanceRebootBackend=$adminServerMaintenanceRebootBackend, adminServerMaintenanceResetData=$adminServerMaintenanceResetData, adminServerMaintenanceSaveBackendConfig=$adminServerMaintenanceSaveBackendConfig, adminServerMaintenanceUpdateSoftware=$adminServerMaintenanceUpdateSoftware, adminServerMaintenanceViewBackendConfig=$adminServerMaintenanceViewBackendConfig, adminServerMaintenanceViewInfo=$adminServerMaintenanceViewInfo, adminViewAllProfiles=$adminViewAllProfiles, adminViewPermissions=$adminViewPermissions, adminViewPrivateInfo=$adminViewPrivateInfo, adminViewProfileHistory=$adminViewProfileHistory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'admin_ban_account'] = this.adminBanAccount;
      json[r'admin_delete_account'] = this.adminDeleteAccount;
      json[r'admin_delete_media_content'] = this.adminDeleteMediaContent;
      json[r'admin_edit_max_public_key_count'] = this.adminEditMaxPublicKeyCount;
      json[r'admin_edit_profile_name'] = this.adminEditProfileName;
      json[r'admin_find_account_by_email'] = this.adminFindAccountByEmail;
      json[r'admin_moderate_media_content'] = this.adminModerateMediaContent;
      json[r'admin_moderate_profile_names'] = this.adminModerateProfileNames;
      json[r'admin_moderate_profile_texts'] = this.adminModerateProfileTexts;
      json[r'admin_modify_permissions'] = this.adminModifyPermissions;
      json[r'admin_news_create'] = this.adminNewsCreate;
      json[r'admin_news_edit_all'] = this.adminNewsEditAll;
      json[r'admin_process_reports'] = this.adminProcessReports;
      json[r'admin_profile_statistics'] = this.adminProfileStatistics;
      json[r'admin_request_account_deletion'] = this.adminRequestAccountDeletion;
      json[r'admin_server_maintenance_edit_notification'] = this.adminServerMaintenanceEditNotification;
      json[r'admin_server_maintenance_reboot_backend'] = this.adminServerMaintenanceRebootBackend;
      json[r'admin_server_maintenance_reset_data'] = this.adminServerMaintenanceResetData;
      json[r'admin_server_maintenance_save_backend_config'] = this.adminServerMaintenanceSaveBackendConfig;
      json[r'admin_server_maintenance_update_software'] = this.adminServerMaintenanceUpdateSoftware;
      json[r'admin_server_maintenance_view_backend_config'] = this.adminServerMaintenanceViewBackendConfig;
      json[r'admin_server_maintenance_view_info'] = this.adminServerMaintenanceViewInfo;
      json[r'admin_view_all_profiles'] = this.adminViewAllProfiles;
      json[r'admin_view_permissions'] = this.adminViewPermissions;
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
        adminBanAccount: mapValueOfType<bool>(json, r'admin_ban_account') ?? false,
        adminDeleteAccount: mapValueOfType<bool>(json, r'admin_delete_account') ?? false,
        adminDeleteMediaContent: mapValueOfType<bool>(json, r'admin_delete_media_content') ?? false,
        adminEditMaxPublicKeyCount: mapValueOfType<bool>(json, r'admin_edit_max_public_key_count') ?? false,
        adminEditProfileName: mapValueOfType<bool>(json, r'admin_edit_profile_name') ?? false,
        adminFindAccountByEmail: mapValueOfType<bool>(json, r'admin_find_account_by_email') ?? false,
        adminModerateMediaContent: mapValueOfType<bool>(json, r'admin_moderate_media_content') ?? false,
        adminModerateProfileNames: mapValueOfType<bool>(json, r'admin_moderate_profile_names') ?? false,
        adminModerateProfileTexts: mapValueOfType<bool>(json, r'admin_moderate_profile_texts') ?? false,
        adminModifyPermissions: mapValueOfType<bool>(json, r'admin_modify_permissions') ?? false,
        adminNewsCreate: mapValueOfType<bool>(json, r'admin_news_create') ?? false,
        adminNewsEditAll: mapValueOfType<bool>(json, r'admin_news_edit_all') ?? false,
        adminProcessReports: mapValueOfType<bool>(json, r'admin_process_reports') ?? false,
        adminProfileStatistics: mapValueOfType<bool>(json, r'admin_profile_statistics') ?? false,
        adminRequestAccountDeletion: mapValueOfType<bool>(json, r'admin_request_account_deletion') ?? false,
        adminServerMaintenanceEditNotification: mapValueOfType<bool>(json, r'admin_server_maintenance_edit_notification') ?? false,
        adminServerMaintenanceRebootBackend: mapValueOfType<bool>(json, r'admin_server_maintenance_reboot_backend') ?? false,
        adminServerMaintenanceResetData: mapValueOfType<bool>(json, r'admin_server_maintenance_reset_data') ?? false,
        adminServerMaintenanceSaveBackendConfig: mapValueOfType<bool>(json, r'admin_server_maintenance_save_backend_config') ?? false,
        adminServerMaintenanceUpdateSoftware: mapValueOfType<bool>(json, r'admin_server_maintenance_update_software') ?? false,
        adminServerMaintenanceViewBackendConfig: mapValueOfType<bool>(json, r'admin_server_maintenance_view_backend_config') ?? false,
        adminServerMaintenanceViewInfo: mapValueOfType<bool>(json, r'admin_server_maintenance_view_info') ?? false,
        adminViewAllProfiles: mapValueOfType<bool>(json, r'admin_view_all_profiles') ?? false,
        adminViewPermissions: mapValueOfType<bool>(json, r'admin_view_permissions') ?? false,
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

