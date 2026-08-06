//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotConfig {
  /// Returns a new [AdminBotConfig] instance.
  AdminBotConfig({
    required this.accountVerification,
    this.accountVerificationEnabled = false,
    required this.contentModeration,
    this.contentModerationEnabled = false,
    required this.faceVerification,
    this.faceVerificationEnabled = false,
    required this.profileNameModeration,
    this.profileNameModerationEnabled = false,
    required this.profileTextModeration,
    this.profileTextModerationEnabled = false,
    required this.reportProcessing,
    this.reportProcessingEnabled = false,
  });

  AdminBotAccountVerificationConfig accountVerification;

  bool accountVerificationEnabled;

  AdminBotContentModerationConfig contentModeration;

  bool contentModerationEnabled;

  AdminBotFaceVerificationConfig faceVerification;

  bool faceVerificationEnabled;

  AdminBotProfileStringModerationConfig profileNameModeration;

  bool profileNameModerationEnabled;

  AdminBotProfileStringModerationConfig profileTextModeration;

  bool profileTextModerationEnabled;

  AdminBotReportProcessingConfig reportProcessing;

  bool reportProcessingEnabled;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotConfig &&
    other.accountVerification == accountVerification &&
    other.accountVerificationEnabled == accountVerificationEnabled &&
    other.contentModeration == contentModeration &&
    other.contentModerationEnabled == contentModerationEnabled &&
    other.faceVerification == faceVerification &&
    other.faceVerificationEnabled == faceVerificationEnabled &&
    other.profileNameModeration == profileNameModeration &&
    other.profileNameModerationEnabled == profileNameModerationEnabled &&
    other.profileTextModeration == profileTextModeration &&
    other.profileTextModerationEnabled == profileTextModerationEnabled &&
    other.reportProcessing == reportProcessing &&
    other.reportProcessingEnabled == reportProcessingEnabled;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountVerification.hashCode) +
    (accountVerificationEnabled.hashCode) +
    (contentModeration.hashCode) +
    (contentModerationEnabled.hashCode) +
    (faceVerification.hashCode) +
    (faceVerificationEnabled.hashCode) +
    (profileNameModeration.hashCode) +
    (profileNameModerationEnabled.hashCode) +
    (profileTextModeration.hashCode) +
    (profileTextModerationEnabled.hashCode) +
    (reportProcessing.hashCode) +
    (reportProcessingEnabled.hashCode);

  @override
  String toString() => 'AdminBotConfig[accountVerification=$accountVerification, accountVerificationEnabled=$accountVerificationEnabled, contentModeration=$contentModeration, contentModerationEnabled=$contentModerationEnabled, faceVerification=$faceVerification, faceVerificationEnabled=$faceVerificationEnabled, profileNameModeration=$profileNameModeration, profileNameModerationEnabled=$profileNameModerationEnabled, profileTextModeration=$profileTextModeration, profileTextModerationEnabled=$profileTextModerationEnabled, reportProcessing=$reportProcessing, reportProcessingEnabled=$reportProcessingEnabled]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_verification'] = this.accountVerification;
      json[r'account_verification_enabled'] = this.accountVerificationEnabled;
      json[r'content_moderation'] = this.contentModeration;
      json[r'content_moderation_enabled'] = this.contentModerationEnabled;
      json[r'face_verification'] = this.faceVerification;
      json[r'face_verification_enabled'] = this.faceVerificationEnabled;
      json[r'profile_name_moderation'] = this.profileNameModeration;
      json[r'profile_name_moderation_enabled'] = this.profileNameModerationEnabled;
      json[r'profile_text_moderation'] = this.profileTextModeration;
      json[r'profile_text_moderation_enabled'] = this.profileTextModerationEnabled;
      json[r'report_processing'] = this.reportProcessing;
      json[r'report_processing_enabled'] = this.reportProcessingEnabled;
    return json;
  }

  /// Returns a new [AdminBotConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'account_verification'), 'Required key "AdminBotConfig[account_verification]" is missing from JSON.');
        assert(json[r'account_verification'] != null, 'Required key "AdminBotConfig[account_verification]" has a null value in JSON.');
        assert(json.containsKey(r'content_moderation'), 'Required key "AdminBotConfig[content_moderation]" is missing from JSON.');
        assert(json[r'content_moderation'] != null, 'Required key "AdminBotConfig[content_moderation]" has a null value in JSON.');
        assert(json.containsKey(r'face_verification'), 'Required key "AdminBotConfig[face_verification]" is missing from JSON.');
        assert(json[r'face_verification'] != null, 'Required key "AdminBotConfig[face_verification]" has a null value in JSON.');
        assert(json.containsKey(r'profile_name_moderation'), 'Required key "AdminBotConfig[profile_name_moderation]" is missing from JSON.');
        assert(json[r'profile_name_moderation'] != null, 'Required key "AdminBotConfig[profile_name_moderation]" has a null value in JSON.');
        assert(json.containsKey(r'profile_text_moderation'), 'Required key "AdminBotConfig[profile_text_moderation]" is missing from JSON.');
        assert(json[r'profile_text_moderation'] != null, 'Required key "AdminBotConfig[profile_text_moderation]" has a null value in JSON.');
        assert(json.containsKey(r'report_processing'), 'Required key "AdminBotConfig[report_processing]" is missing from JSON.');
        assert(json[r'report_processing'] != null, 'Required key "AdminBotConfig[report_processing]" has a null value in JSON.');
        return true;
      }());

      return AdminBotConfig(
        accountVerification: AdminBotAccountVerificationConfig.fromJson(json[r'account_verification'])!,
        accountVerificationEnabled: mapValueOfType<bool>(json, r'account_verification_enabled') ?? false,
        contentModeration: AdminBotContentModerationConfig.fromJson(json[r'content_moderation'])!,
        contentModerationEnabled: mapValueOfType<bool>(json, r'content_moderation_enabled') ?? false,
        faceVerification: AdminBotFaceVerificationConfig.fromJson(json[r'face_verification'])!,
        faceVerificationEnabled: mapValueOfType<bool>(json, r'face_verification_enabled') ?? false,
        profileNameModeration: AdminBotProfileStringModerationConfig.fromJson(json[r'profile_name_moderation'])!,
        profileNameModerationEnabled: mapValueOfType<bool>(json, r'profile_name_moderation_enabled') ?? false,
        profileTextModeration: AdminBotProfileStringModerationConfig.fromJson(json[r'profile_text_moderation'])!,
        profileTextModerationEnabled: mapValueOfType<bool>(json, r'profile_text_moderation_enabled') ?? false,
        reportProcessing: AdminBotReportProcessingConfig.fromJson(json[r'report_processing'])!,
        reportProcessingEnabled: mapValueOfType<bool>(json, r'report_processing_enabled') ?? false,
      );
    }
    return null;
  }

  static List<AdminBotConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotConfig-objects as value to a dart map
  static Map<String, List<AdminBotConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_verification',
    'content_moderation',
    'face_verification',
    'profile_name_moderation',
    'profile_text_moderation',
    'report_processing',
  };
}

