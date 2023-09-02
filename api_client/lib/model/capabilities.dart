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
    this.adminBanProfile,
    this.adminModerateImages,
    this.adminModerateProfiles,
    this.adminModifyCapablities,
    this.adminServerMaintentanceRebootBackend,
    this.adminServerMaintentanceResetData,
    this.adminServerMaintentanceSaveBackendSettings,
    this.adminServerMaintentanceUpdateSoftware,
    this.adminServerMaintentanceViewBackendSettings,
    this.adminServerMaintentanceViewInfo,
    this.adminSetupPossible,
    this.adminViewAllProfiles,
    this.adminViewPrivateInfo,
    this.adminViewProfileHistory,
    this.bannedEditProfile,
    this.viewPublicProfiles,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminBanProfile;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminModerateImages;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminModerateProfiles;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminModifyCapablities;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminServerMaintentanceRebootBackend;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminServerMaintentanceResetData;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminServerMaintentanceSaveBackendSettings;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminServerMaintentanceUpdateSoftware;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminServerMaintentanceViewBackendSettings;

  /// View server infrastructure related info like logs and software versions.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminServerMaintentanceViewInfo;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminSetupPossible;

  /// View public and private profiles.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminViewAllProfiles;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminViewPrivateInfo;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? adminViewProfileHistory;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? bannedEditProfile;

  /// View public profiles
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? viewPublicProfiles;

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
    (adminBanProfile == null ? 0 : adminBanProfile!.hashCode) +
    (adminModerateImages == null ? 0 : adminModerateImages!.hashCode) +
    (adminModerateProfiles == null ? 0 : adminModerateProfiles!.hashCode) +
    (adminModifyCapablities == null ? 0 : adminModifyCapablities!.hashCode) +
    (adminServerMaintentanceRebootBackend == null ? 0 : adminServerMaintentanceRebootBackend!.hashCode) +
    (adminServerMaintentanceResetData == null ? 0 : adminServerMaintentanceResetData!.hashCode) +
    (adminServerMaintentanceSaveBackendSettings == null ? 0 : adminServerMaintentanceSaveBackendSettings!.hashCode) +
    (adminServerMaintentanceUpdateSoftware == null ? 0 : adminServerMaintentanceUpdateSoftware!.hashCode) +
    (adminServerMaintentanceViewBackendSettings == null ? 0 : adminServerMaintentanceViewBackendSettings!.hashCode) +
    (adminServerMaintentanceViewInfo == null ? 0 : adminServerMaintentanceViewInfo!.hashCode) +
    (adminSetupPossible == null ? 0 : adminSetupPossible!.hashCode) +
    (adminViewAllProfiles == null ? 0 : adminViewAllProfiles!.hashCode) +
    (adminViewPrivateInfo == null ? 0 : adminViewPrivateInfo!.hashCode) +
    (adminViewProfileHistory == null ? 0 : adminViewProfileHistory!.hashCode) +
    (bannedEditProfile == null ? 0 : bannedEditProfile!.hashCode) +
    (viewPublicProfiles == null ? 0 : viewPublicProfiles!.hashCode);

  @override
  String toString() => 'Capabilities[adminBanProfile=$adminBanProfile, adminModerateImages=$adminModerateImages, adminModerateProfiles=$adminModerateProfiles, adminModifyCapablities=$adminModifyCapablities, adminServerMaintentanceRebootBackend=$adminServerMaintentanceRebootBackend, adminServerMaintentanceResetData=$adminServerMaintentanceResetData, adminServerMaintentanceSaveBackendSettings=$adminServerMaintentanceSaveBackendSettings, adminServerMaintentanceUpdateSoftware=$adminServerMaintentanceUpdateSoftware, adminServerMaintentanceViewBackendSettings=$adminServerMaintentanceViewBackendSettings, adminServerMaintentanceViewInfo=$adminServerMaintentanceViewInfo, adminSetupPossible=$adminSetupPossible, adminViewAllProfiles=$adminViewAllProfiles, adminViewPrivateInfo=$adminViewPrivateInfo, adminViewProfileHistory=$adminViewProfileHistory, bannedEditProfile=$bannedEditProfile, viewPublicProfiles=$viewPublicProfiles]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.adminBanProfile != null) {
      json[r'admin_ban_profile'] = this.adminBanProfile;
    } else {
      json[r'admin_ban_profile'] = null;
    }
    if (this.adminModerateImages != null) {
      json[r'admin_moderate_images'] = this.adminModerateImages;
    } else {
      json[r'admin_moderate_images'] = null;
    }
    if (this.adminModerateProfiles != null) {
      json[r'admin_moderate_profiles'] = this.adminModerateProfiles;
    } else {
      json[r'admin_moderate_profiles'] = null;
    }
    if (this.adminModifyCapablities != null) {
      json[r'admin_modify_capablities'] = this.adminModifyCapablities;
    } else {
      json[r'admin_modify_capablities'] = null;
    }
    if (this.adminServerMaintentanceRebootBackend != null) {
      json[r'admin_server_maintentance_reboot_backend'] = this.adminServerMaintentanceRebootBackend;
    } else {
      json[r'admin_server_maintentance_reboot_backend'] = null;
    }
    if (this.adminServerMaintentanceResetData != null) {
      json[r'admin_server_maintentance_reset_data'] = this.adminServerMaintentanceResetData;
    } else {
      json[r'admin_server_maintentance_reset_data'] = null;
    }
    if (this.adminServerMaintentanceSaveBackendSettings != null) {
      json[r'admin_server_maintentance_save_backend_settings'] = this.adminServerMaintentanceSaveBackendSettings;
    } else {
      json[r'admin_server_maintentance_save_backend_settings'] = null;
    }
    if (this.adminServerMaintentanceUpdateSoftware != null) {
      json[r'admin_server_maintentance_update_software'] = this.adminServerMaintentanceUpdateSoftware;
    } else {
      json[r'admin_server_maintentance_update_software'] = null;
    }
    if (this.adminServerMaintentanceViewBackendSettings != null) {
      json[r'admin_server_maintentance_view_backend_settings'] = this.adminServerMaintentanceViewBackendSettings;
    } else {
      json[r'admin_server_maintentance_view_backend_settings'] = null;
    }
    if (this.adminServerMaintentanceViewInfo != null) {
      json[r'admin_server_maintentance_view_info'] = this.adminServerMaintentanceViewInfo;
    } else {
      json[r'admin_server_maintentance_view_info'] = null;
    }
    if (this.adminSetupPossible != null) {
      json[r'admin_setup_possible'] = this.adminSetupPossible;
    } else {
      json[r'admin_setup_possible'] = null;
    }
    if (this.adminViewAllProfiles != null) {
      json[r'admin_view_all_profiles'] = this.adminViewAllProfiles;
    } else {
      json[r'admin_view_all_profiles'] = null;
    }
    if (this.adminViewPrivateInfo != null) {
      json[r'admin_view_private_info'] = this.adminViewPrivateInfo;
    } else {
      json[r'admin_view_private_info'] = null;
    }
    if (this.adminViewProfileHistory != null) {
      json[r'admin_view_profile_history'] = this.adminViewProfileHistory;
    } else {
      json[r'admin_view_profile_history'] = null;
    }
    if (this.bannedEditProfile != null) {
      json[r'banned_edit_profile'] = this.bannedEditProfile;
    } else {
      json[r'banned_edit_profile'] = null;
    }
    if (this.viewPublicProfiles != null) {
      json[r'view_public_profiles'] = this.viewPublicProfiles;
    } else {
      json[r'view_public_profiles'] = null;
    }
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
        adminBanProfile: mapValueOfType<bool>(json, r'admin_ban_profile'),
        adminModerateImages: mapValueOfType<bool>(json, r'admin_moderate_images'),
        adminModerateProfiles: mapValueOfType<bool>(json, r'admin_moderate_profiles'),
        adminModifyCapablities: mapValueOfType<bool>(json, r'admin_modify_capablities'),
        adminServerMaintentanceRebootBackend: mapValueOfType<bool>(json, r'admin_server_maintentance_reboot_backend'),
        adminServerMaintentanceResetData: mapValueOfType<bool>(json, r'admin_server_maintentance_reset_data'),
        adminServerMaintentanceSaveBackendSettings: mapValueOfType<bool>(json, r'admin_server_maintentance_save_backend_settings'),
        adminServerMaintentanceUpdateSoftware: mapValueOfType<bool>(json, r'admin_server_maintentance_update_software'),
        adminServerMaintentanceViewBackendSettings: mapValueOfType<bool>(json, r'admin_server_maintentance_view_backend_settings'),
        adminServerMaintentanceViewInfo: mapValueOfType<bool>(json, r'admin_server_maintentance_view_info'),
        adminSetupPossible: mapValueOfType<bool>(json, r'admin_setup_possible'),
        adminViewAllProfiles: mapValueOfType<bool>(json, r'admin_view_all_profiles'),
        adminViewPrivateInfo: mapValueOfType<bool>(json, r'admin_view_private_info'),
        adminViewProfileHistory: mapValueOfType<bool>(json, r'admin_view_profile_history'),
        bannedEditProfile: mapValueOfType<bool>(json, r'banned_edit_profile'),
        viewPublicProfiles: mapValueOfType<bool>(json, r'view_public_profiles'),
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

