//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Capabilities {
  /// Returns a new [Capabilities] instance.
  Capabilities({
    this.adminBanProfile = false,
    this.adminModerateImages = false,
    this.adminModerateProfiles = false,
    this.adminModifyCapablities = false,
    this.adminServerMaintentanceRebootBackend = false,
    this.adminServerMaintentanceResetData = false,
    this.adminServerMaintentanceSaveBackendSettings = false,
    this.adminServerMaintentanceUpdateSoftware = false,
    this.adminServerMaintentanceViewBackendSettings = false,
    this.adminServerMaintentanceViewInfo = false,
    this.adminSetupPossible = false,
    this.adminViewAllProfiles = false,
    this.adminViewPrivateInfo = false,
    this.adminViewProfileHistory = false,
    this.bannedEditProfile = false,
    this.viewPublicProfiles = false,
  });

  bool adminBanProfile;

  bool adminModerateImages;

  bool adminModerateProfiles;

  bool adminModifyCapablities;

  bool adminServerMaintentanceRebootBackend;

  bool adminServerMaintentanceResetData;

  bool adminServerMaintentanceSaveBackendSettings;

  bool adminServerMaintentanceUpdateSoftware;

  bool adminServerMaintentanceViewBackendSettings;

  /// View server infrastructure related info like logs and software versions.
  bool adminServerMaintentanceViewInfo;

  bool adminSetupPossible;

  /// View public and private profiles.
  bool adminViewAllProfiles;

  bool adminViewPrivateInfo;

  bool adminViewProfileHistory;

  bool bannedEditProfile;

  /// View public profiles
  bool viewPublicProfiles;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Capabilities &&
     other.adminBanProfile == adminBanProfile &&
     other.adminModerateImages == adminModerateImages &&
     other.adminModerateProfiles == adminModerateProfiles &&
     other.adminModifyCapablities == adminModifyCapablities &&
     other.adminServerMaintentanceRebootBackend == adminServerMaintentanceRebootBackend &&
     other.adminServerMaintentanceResetData == adminServerMaintentanceResetData &&
     other.adminServerMaintentanceSaveBackendSettings == adminServerMaintentanceSaveBackendSettings &&
     other.adminServerMaintentanceUpdateSoftware == adminServerMaintentanceUpdateSoftware &&
     other.adminServerMaintentanceViewBackendSettings == adminServerMaintentanceViewBackendSettings &&
     other.adminServerMaintentanceViewInfo == adminServerMaintentanceViewInfo &&
     other.adminSetupPossible == adminSetupPossible &&
     other.adminViewAllProfiles == adminViewAllProfiles &&
     other.adminViewPrivateInfo == adminViewPrivateInfo &&
     other.adminViewProfileHistory == adminViewProfileHistory &&
     other.bannedEditProfile == bannedEditProfile &&
     other.viewPublicProfiles == viewPublicProfiles;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminBanProfile.hashCode) +
    (adminModerateImages.hashCode) +
    (adminModerateProfiles.hashCode) +
    (adminModifyCapablities.hashCode) +
    (adminServerMaintentanceRebootBackend.hashCode) +
    (adminServerMaintentanceResetData.hashCode) +
    (adminServerMaintentanceSaveBackendSettings.hashCode) +
    (adminServerMaintentanceUpdateSoftware.hashCode) +
    (adminServerMaintentanceViewBackendSettings.hashCode) +
    (adminServerMaintentanceViewInfo.hashCode) +
    (adminSetupPossible.hashCode) +
    (adminViewAllProfiles.hashCode) +
    (adminViewPrivateInfo.hashCode) +
    (adminViewProfileHistory.hashCode) +
    (bannedEditProfile.hashCode) +
    (viewPublicProfiles.hashCode);

  @override
  String toString() => 'Capabilities[adminBanProfile=$adminBanProfile, adminModerateImages=$adminModerateImages, adminModerateProfiles=$adminModerateProfiles, adminModifyCapablities=$adminModifyCapablities, adminServerMaintentanceRebootBackend=$adminServerMaintentanceRebootBackend, adminServerMaintentanceResetData=$adminServerMaintentanceResetData, adminServerMaintentanceSaveBackendSettings=$adminServerMaintentanceSaveBackendSettings, adminServerMaintentanceUpdateSoftware=$adminServerMaintentanceUpdateSoftware, adminServerMaintentanceViewBackendSettings=$adminServerMaintentanceViewBackendSettings, adminServerMaintentanceViewInfo=$adminServerMaintentanceViewInfo, adminSetupPossible=$adminSetupPossible, adminViewAllProfiles=$adminViewAllProfiles, adminViewPrivateInfo=$adminViewPrivateInfo, adminViewProfileHistory=$adminViewProfileHistory, bannedEditProfile=$bannedEditProfile, viewPublicProfiles=$viewPublicProfiles]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'admin_ban_profile'] = this.adminBanProfile;
      json[r'admin_moderate_images'] = this.adminModerateImages;
      json[r'admin_moderate_profiles'] = this.adminModerateProfiles;
      json[r'admin_modify_capablities'] = this.adminModifyCapablities;
      json[r'admin_server_maintentance_reboot_backend'] = this.adminServerMaintentanceRebootBackend;
      json[r'admin_server_maintentance_reset_data'] = this.adminServerMaintentanceResetData;
      json[r'admin_server_maintentance_save_backend_settings'] = this.adminServerMaintentanceSaveBackendSettings;
      json[r'admin_server_maintentance_update_software'] = this.adminServerMaintentanceUpdateSoftware;
      json[r'admin_server_maintentance_view_backend_settings'] = this.adminServerMaintentanceViewBackendSettings;
      json[r'admin_server_maintentance_view_info'] = this.adminServerMaintentanceViewInfo;
      json[r'admin_setup_possible'] = this.adminSetupPossible;
      json[r'admin_view_all_profiles'] = this.adminViewAllProfiles;
      json[r'admin_view_private_info'] = this.adminViewPrivateInfo;
      json[r'admin_view_profile_history'] = this.adminViewProfileHistory;
      json[r'banned_edit_profile'] = this.bannedEditProfile;
      json[r'view_public_profiles'] = this.viewPublicProfiles;
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
        adminBanProfile: mapValueOfType<bool>(json, r'admin_ban_profile') ?? false,
        adminModerateImages: mapValueOfType<bool>(json, r'admin_moderate_images') ?? false,
        adminModerateProfiles: mapValueOfType<bool>(json, r'admin_moderate_profiles') ?? false,
        adminModifyCapablities: mapValueOfType<bool>(json, r'admin_modify_capablities') ?? false,
        adminServerMaintentanceRebootBackend: mapValueOfType<bool>(json, r'admin_server_maintentance_reboot_backend') ?? false,
        adminServerMaintentanceResetData: mapValueOfType<bool>(json, r'admin_server_maintentance_reset_data') ?? false,
        adminServerMaintentanceSaveBackendSettings: mapValueOfType<bool>(json, r'admin_server_maintentance_save_backend_settings') ?? false,
        adminServerMaintentanceUpdateSoftware: mapValueOfType<bool>(json, r'admin_server_maintentance_update_software') ?? false,
        adminServerMaintentanceViewBackendSettings: mapValueOfType<bool>(json, r'admin_server_maintentance_view_backend_settings') ?? false,
        adminServerMaintentanceViewInfo: mapValueOfType<bool>(json, r'admin_server_maintentance_view_info') ?? false,
        adminSetupPossible: mapValueOfType<bool>(json, r'admin_setup_possible') ?? false,
        adminViewAllProfiles: mapValueOfType<bool>(json, r'admin_view_all_profiles') ?? false,
        adminViewPrivateInfo: mapValueOfType<bool>(json, r'admin_view_private_info') ?? false,
        adminViewProfileHistory: mapValueOfType<bool>(json, r'admin_view_profile_history') ?? false,
        bannedEditProfile: mapValueOfType<bool>(json, r'banned_edit_profile') ?? false,
        viewPublicProfiles: mapValueOfType<bool>(json, r'view_public_profiles') ?? false,
      );
    }
    return null;
  }

  static List<Capabilities>? listFromJson(dynamic json, {bool growable = false,}) {
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Capabilities.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

