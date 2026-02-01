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
    this.adminChangeEmailAddress = false,
    this.adminDeleteAccount = false,
    this.adminDeleteMediaContent = false,
    this.adminEditLogin = false,
    this.adminEditMediaContentFaceDetectedValue = false,
    this.adminEditPermissions = false,
    this.adminEditProfileName = false,
    this.adminExportData = false,
    this.adminFindAccountByEmailAddress = false,
    this.adminModerateMediaContent = false,
    this.adminModerateProfileNames = false,
    this.adminModerateProfileTexts = false,
    this.adminNewsCreate = false,
    this.adminNewsEditAll = false,
    this.adminProcessReports = false,
    this.adminProfileStatistics = false,
    this.adminRequestAccountDeletion = false,
    this.adminServerDataReset = false,
    this.adminServerEditBotConfig = false,
    this.adminServerEditImageProcessingConfig = false,
    this.adminServerEditMaintenanceNotification = false,
    this.adminServerRestart = false,
    this.adminServerSoftwareUpdate = false,
    this.adminServerViewBotConfig = false,
    this.adminServerViewImageProcessingConfig = false,
    this.adminServerViewInfo = false,
    this.adminSubscribeAdminNotifications = false,
    this.adminViewAccountApiUsage = false,
    this.adminViewAccountIpAddressUsage = false,
    this.adminViewAccountState = false,
    this.adminViewAllProfiles = false,
    this.adminViewEmailAddress = false,
    this.adminViewPermissions = false,
    this.adminViewProfileHistory = false,
  });

  bool adminBanAccount;

  bool adminChangeEmailAddress;

  bool adminDeleteAccount;

  bool adminDeleteMediaContent;

  bool adminEditLogin;

  bool adminEditMediaContentFaceDetectedValue;

  bool adminEditPermissions;

  bool adminEditProfileName;

  bool adminExportData;

  bool adminFindAccountByEmailAddress;

  bool adminModerateMediaContent;

  bool adminModerateProfileNames;

  bool adminModerateProfileTexts;

  bool adminNewsCreate;

  bool adminNewsEditAll;

  bool adminProcessReports;

  bool adminProfileStatistics;

  bool adminRequestAccountDeletion;

  bool adminServerDataReset;

  bool adminServerEditBotConfig;

  bool adminServerEditImageProcessingConfig;

  bool adminServerEditMaintenanceNotification;

  bool adminServerRestart;

  bool adminServerSoftwareUpdate;

  bool adminServerViewBotConfig;

  bool adminServerViewImageProcessingConfig;

  /// View server infrastructure related info like logs and software versions.
  bool adminServerViewInfo;

  bool adminSubscribeAdminNotifications;

  bool adminViewAccountApiUsage;

  bool adminViewAccountIpAddressUsage;

  bool adminViewAccountState;

  /// View public and private profiles.
  bool adminViewAllProfiles;

  bool adminViewEmailAddress;

  bool adminViewPermissions;

  bool adminViewProfileHistory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Permissions &&
    other.adminBanAccount == adminBanAccount &&
    other.adminChangeEmailAddress == adminChangeEmailAddress &&
    other.adminDeleteAccount == adminDeleteAccount &&
    other.adminDeleteMediaContent == adminDeleteMediaContent &&
    other.adminEditLogin == adminEditLogin &&
    other.adminEditMediaContentFaceDetectedValue == adminEditMediaContentFaceDetectedValue &&
    other.adminEditPermissions == adminEditPermissions &&
    other.adminEditProfileName == adminEditProfileName &&
    other.adminExportData == adminExportData &&
    other.adminFindAccountByEmailAddress == adminFindAccountByEmailAddress &&
    other.adminModerateMediaContent == adminModerateMediaContent &&
    other.adminModerateProfileNames == adminModerateProfileNames &&
    other.adminModerateProfileTexts == adminModerateProfileTexts &&
    other.adminNewsCreate == adminNewsCreate &&
    other.adminNewsEditAll == adminNewsEditAll &&
    other.adminProcessReports == adminProcessReports &&
    other.adminProfileStatistics == adminProfileStatistics &&
    other.adminRequestAccountDeletion == adminRequestAccountDeletion &&
    other.adminServerDataReset == adminServerDataReset &&
    other.adminServerEditBotConfig == adminServerEditBotConfig &&
    other.adminServerEditImageProcessingConfig == adminServerEditImageProcessingConfig &&
    other.adminServerEditMaintenanceNotification == adminServerEditMaintenanceNotification &&
    other.adminServerRestart == adminServerRestart &&
    other.adminServerSoftwareUpdate == adminServerSoftwareUpdate &&
    other.adminServerViewBotConfig == adminServerViewBotConfig &&
    other.adminServerViewImageProcessingConfig == adminServerViewImageProcessingConfig &&
    other.adminServerViewInfo == adminServerViewInfo &&
    other.adminSubscribeAdminNotifications == adminSubscribeAdminNotifications &&
    other.adminViewAccountApiUsage == adminViewAccountApiUsage &&
    other.adminViewAccountIpAddressUsage == adminViewAccountIpAddressUsage &&
    other.adminViewAccountState == adminViewAccountState &&
    other.adminViewAllProfiles == adminViewAllProfiles &&
    other.adminViewEmailAddress == adminViewEmailAddress &&
    other.adminViewPermissions == adminViewPermissions &&
    other.adminViewProfileHistory == adminViewProfileHistory;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminBanAccount.hashCode) +
    (adminChangeEmailAddress.hashCode) +
    (adminDeleteAccount.hashCode) +
    (adminDeleteMediaContent.hashCode) +
    (adminEditLogin.hashCode) +
    (adminEditMediaContentFaceDetectedValue.hashCode) +
    (adminEditPermissions.hashCode) +
    (adminEditProfileName.hashCode) +
    (adminExportData.hashCode) +
    (adminFindAccountByEmailAddress.hashCode) +
    (adminModerateMediaContent.hashCode) +
    (adminModerateProfileNames.hashCode) +
    (adminModerateProfileTexts.hashCode) +
    (adminNewsCreate.hashCode) +
    (adminNewsEditAll.hashCode) +
    (adminProcessReports.hashCode) +
    (adminProfileStatistics.hashCode) +
    (adminRequestAccountDeletion.hashCode) +
    (adminServerDataReset.hashCode) +
    (adminServerEditBotConfig.hashCode) +
    (adminServerEditImageProcessingConfig.hashCode) +
    (adminServerEditMaintenanceNotification.hashCode) +
    (adminServerRestart.hashCode) +
    (adminServerSoftwareUpdate.hashCode) +
    (adminServerViewBotConfig.hashCode) +
    (adminServerViewImageProcessingConfig.hashCode) +
    (adminServerViewInfo.hashCode) +
    (adminSubscribeAdminNotifications.hashCode) +
    (adminViewAccountApiUsage.hashCode) +
    (adminViewAccountIpAddressUsage.hashCode) +
    (adminViewAccountState.hashCode) +
    (adminViewAllProfiles.hashCode) +
    (adminViewEmailAddress.hashCode) +
    (adminViewPermissions.hashCode) +
    (adminViewProfileHistory.hashCode);

  @override
  String toString() => 'Permissions[adminBanAccount=$adminBanAccount, adminChangeEmailAddress=$adminChangeEmailAddress, adminDeleteAccount=$adminDeleteAccount, adminDeleteMediaContent=$adminDeleteMediaContent, adminEditLogin=$adminEditLogin, adminEditMediaContentFaceDetectedValue=$adminEditMediaContentFaceDetectedValue, adminEditPermissions=$adminEditPermissions, adminEditProfileName=$adminEditProfileName, adminExportData=$adminExportData, adminFindAccountByEmailAddress=$adminFindAccountByEmailAddress, adminModerateMediaContent=$adminModerateMediaContent, adminModerateProfileNames=$adminModerateProfileNames, adminModerateProfileTexts=$adminModerateProfileTexts, adminNewsCreate=$adminNewsCreate, adminNewsEditAll=$adminNewsEditAll, adminProcessReports=$adminProcessReports, adminProfileStatistics=$adminProfileStatistics, adminRequestAccountDeletion=$adminRequestAccountDeletion, adminServerDataReset=$adminServerDataReset, adminServerEditBotConfig=$adminServerEditBotConfig, adminServerEditImageProcessingConfig=$adminServerEditImageProcessingConfig, adminServerEditMaintenanceNotification=$adminServerEditMaintenanceNotification, adminServerRestart=$adminServerRestart, adminServerSoftwareUpdate=$adminServerSoftwareUpdate, adminServerViewBotConfig=$adminServerViewBotConfig, adminServerViewImageProcessingConfig=$adminServerViewImageProcessingConfig, adminServerViewInfo=$adminServerViewInfo, adminSubscribeAdminNotifications=$adminSubscribeAdminNotifications, adminViewAccountApiUsage=$adminViewAccountApiUsage, adminViewAccountIpAddressUsage=$adminViewAccountIpAddressUsage, adminViewAccountState=$adminViewAccountState, adminViewAllProfiles=$adminViewAllProfiles, adminViewEmailAddress=$adminViewEmailAddress, adminViewPermissions=$adminViewPermissions, adminViewProfileHistory=$adminViewProfileHistory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'admin_ban_account'] = this.adminBanAccount;
      json[r'admin_change_email_address'] = this.adminChangeEmailAddress;
      json[r'admin_delete_account'] = this.adminDeleteAccount;
      json[r'admin_delete_media_content'] = this.adminDeleteMediaContent;
      json[r'admin_edit_login'] = this.adminEditLogin;
      json[r'admin_edit_media_content_face_detected_value'] = this.adminEditMediaContentFaceDetectedValue;
      json[r'admin_edit_permissions'] = this.adminEditPermissions;
      json[r'admin_edit_profile_name'] = this.adminEditProfileName;
      json[r'admin_export_data'] = this.adminExportData;
      json[r'admin_find_account_by_email_address'] = this.adminFindAccountByEmailAddress;
      json[r'admin_moderate_media_content'] = this.adminModerateMediaContent;
      json[r'admin_moderate_profile_names'] = this.adminModerateProfileNames;
      json[r'admin_moderate_profile_texts'] = this.adminModerateProfileTexts;
      json[r'admin_news_create'] = this.adminNewsCreate;
      json[r'admin_news_edit_all'] = this.adminNewsEditAll;
      json[r'admin_process_reports'] = this.adminProcessReports;
      json[r'admin_profile_statistics'] = this.adminProfileStatistics;
      json[r'admin_request_account_deletion'] = this.adminRequestAccountDeletion;
      json[r'admin_server_data_reset'] = this.adminServerDataReset;
      json[r'admin_server_edit_bot_config'] = this.adminServerEditBotConfig;
      json[r'admin_server_edit_image_processing_config'] = this.adminServerEditImageProcessingConfig;
      json[r'admin_server_edit_maintenance_notification'] = this.adminServerEditMaintenanceNotification;
      json[r'admin_server_restart'] = this.adminServerRestart;
      json[r'admin_server_software_update'] = this.adminServerSoftwareUpdate;
      json[r'admin_server_view_bot_config'] = this.adminServerViewBotConfig;
      json[r'admin_server_view_image_processing_config'] = this.adminServerViewImageProcessingConfig;
      json[r'admin_server_view_info'] = this.adminServerViewInfo;
      json[r'admin_subscribe_admin_notifications'] = this.adminSubscribeAdminNotifications;
      json[r'admin_view_account_api_usage'] = this.adminViewAccountApiUsage;
      json[r'admin_view_account_ip_address_usage'] = this.adminViewAccountIpAddressUsage;
      json[r'admin_view_account_state'] = this.adminViewAccountState;
      json[r'admin_view_all_profiles'] = this.adminViewAllProfiles;
      json[r'admin_view_email_address'] = this.adminViewEmailAddress;
      json[r'admin_view_permissions'] = this.adminViewPermissions;
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
        adminChangeEmailAddress: mapValueOfType<bool>(json, r'admin_change_email_address') ?? false,
        adminDeleteAccount: mapValueOfType<bool>(json, r'admin_delete_account') ?? false,
        adminDeleteMediaContent: mapValueOfType<bool>(json, r'admin_delete_media_content') ?? false,
        adminEditLogin: mapValueOfType<bool>(json, r'admin_edit_login') ?? false,
        adminEditMediaContentFaceDetectedValue: mapValueOfType<bool>(json, r'admin_edit_media_content_face_detected_value') ?? false,
        adminEditPermissions: mapValueOfType<bool>(json, r'admin_edit_permissions') ?? false,
        adminEditProfileName: mapValueOfType<bool>(json, r'admin_edit_profile_name') ?? false,
        adminExportData: mapValueOfType<bool>(json, r'admin_export_data') ?? false,
        adminFindAccountByEmailAddress: mapValueOfType<bool>(json, r'admin_find_account_by_email_address') ?? false,
        adminModerateMediaContent: mapValueOfType<bool>(json, r'admin_moderate_media_content') ?? false,
        adminModerateProfileNames: mapValueOfType<bool>(json, r'admin_moderate_profile_names') ?? false,
        adminModerateProfileTexts: mapValueOfType<bool>(json, r'admin_moderate_profile_texts') ?? false,
        adminNewsCreate: mapValueOfType<bool>(json, r'admin_news_create') ?? false,
        adminNewsEditAll: mapValueOfType<bool>(json, r'admin_news_edit_all') ?? false,
        adminProcessReports: mapValueOfType<bool>(json, r'admin_process_reports') ?? false,
        adminProfileStatistics: mapValueOfType<bool>(json, r'admin_profile_statistics') ?? false,
        adminRequestAccountDeletion: mapValueOfType<bool>(json, r'admin_request_account_deletion') ?? false,
        adminServerDataReset: mapValueOfType<bool>(json, r'admin_server_data_reset') ?? false,
        adminServerEditBotConfig: mapValueOfType<bool>(json, r'admin_server_edit_bot_config') ?? false,
        adminServerEditImageProcessingConfig: mapValueOfType<bool>(json, r'admin_server_edit_image_processing_config') ?? false,
        adminServerEditMaintenanceNotification: mapValueOfType<bool>(json, r'admin_server_edit_maintenance_notification') ?? false,
        adminServerRestart: mapValueOfType<bool>(json, r'admin_server_restart') ?? false,
        adminServerSoftwareUpdate: mapValueOfType<bool>(json, r'admin_server_software_update') ?? false,
        adminServerViewBotConfig: mapValueOfType<bool>(json, r'admin_server_view_bot_config') ?? false,
        adminServerViewImageProcessingConfig: mapValueOfType<bool>(json, r'admin_server_view_image_processing_config') ?? false,
        adminServerViewInfo: mapValueOfType<bool>(json, r'admin_server_view_info') ?? false,
        adminSubscribeAdminNotifications: mapValueOfType<bool>(json, r'admin_subscribe_admin_notifications') ?? false,
        adminViewAccountApiUsage: mapValueOfType<bool>(json, r'admin_view_account_api_usage') ?? false,
        adminViewAccountIpAddressUsage: mapValueOfType<bool>(json, r'admin_view_account_ip_address_usage') ?? false,
        adminViewAccountState: mapValueOfType<bool>(json, r'admin_view_account_state') ?? false,
        adminViewAllProfiles: mapValueOfType<bool>(json, r'admin_view_all_profiles') ?? false,
        adminViewEmailAddress: mapValueOfType<bool>(json, r'admin_view_email_address') ?? false,
        adminViewPermissions: mapValueOfType<bool>(json, r'admin_view_permissions') ?? false,
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

