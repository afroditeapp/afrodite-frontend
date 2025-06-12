//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminNotification {
  /// Returns a new [AdminNotification] instance.
  AdminNotification({
    this.moderateInitialMediaContentBot = false,
    this.moderateInitialMediaContentHuman = false,
    this.moderateMediaContentBot = false,
    this.moderateMediaContentHuman = false,
    this.moderateProfileNamesBot = false,
    this.moderateProfileNamesHuman = false,
    this.moderateProfileTextsBot = false,
    this.moderateProfileTextsHuman = false,
    this.processReports = false,
  });

  bool moderateInitialMediaContentBot;

  bool moderateInitialMediaContentHuman;

  bool moderateMediaContentBot;

  bool moderateMediaContentHuman;

  bool moderateProfileNamesBot;

  bool moderateProfileNamesHuman;

  bool moderateProfileTextsBot;

  bool moderateProfileTextsHuman;

  bool processReports;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminNotification &&
    other.moderateInitialMediaContentBot == moderateInitialMediaContentBot &&
    other.moderateInitialMediaContentHuman == moderateInitialMediaContentHuman &&
    other.moderateMediaContentBot == moderateMediaContentBot &&
    other.moderateMediaContentHuman == moderateMediaContentHuman &&
    other.moderateProfileNamesBot == moderateProfileNamesBot &&
    other.moderateProfileNamesHuman == moderateProfileNamesHuman &&
    other.moderateProfileTextsBot == moderateProfileTextsBot &&
    other.moderateProfileTextsHuman == moderateProfileTextsHuman &&
    other.processReports == processReports;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (moderateInitialMediaContentBot.hashCode) +
    (moderateInitialMediaContentHuman.hashCode) +
    (moderateMediaContentBot.hashCode) +
    (moderateMediaContentHuman.hashCode) +
    (moderateProfileNamesBot.hashCode) +
    (moderateProfileNamesHuman.hashCode) +
    (moderateProfileTextsBot.hashCode) +
    (moderateProfileTextsHuman.hashCode) +
    (processReports.hashCode);

  @override
  String toString() => 'AdminNotification[moderateInitialMediaContentBot=$moderateInitialMediaContentBot, moderateInitialMediaContentHuman=$moderateInitialMediaContentHuman, moderateMediaContentBot=$moderateMediaContentBot, moderateMediaContentHuman=$moderateMediaContentHuman, moderateProfileNamesBot=$moderateProfileNamesBot, moderateProfileNamesHuman=$moderateProfileNamesHuman, moderateProfileTextsBot=$moderateProfileTextsBot, moderateProfileTextsHuman=$moderateProfileTextsHuman, processReports=$processReports]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'moderate_initial_media_content_bot'] = this.moderateInitialMediaContentBot;
      json[r'moderate_initial_media_content_human'] = this.moderateInitialMediaContentHuman;
      json[r'moderate_media_content_bot'] = this.moderateMediaContentBot;
      json[r'moderate_media_content_human'] = this.moderateMediaContentHuman;
      json[r'moderate_profile_names_bot'] = this.moderateProfileNamesBot;
      json[r'moderate_profile_names_human'] = this.moderateProfileNamesHuman;
      json[r'moderate_profile_texts_bot'] = this.moderateProfileTextsBot;
      json[r'moderate_profile_texts_human'] = this.moderateProfileTextsHuman;
      json[r'process_reports'] = this.processReports;
    return json;
  }

  /// Returns a new [AdminNotification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminNotification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminNotification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminNotification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminNotification(
        moderateInitialMediaContentBot: mapValueOfType<bool>(json, r'moderate_initial_media_content_bot') ?? false,
        moderateInitialMediaContentHuman: mapValueOfType<bool>(json, r'moderate_initial_media_content_human') ?? false,
        moderateMediaContentBot: mapValueOfType<bool>(json, r'moderate_media_content_bot') ?? false,
        moderateMediaContentHuman: mapValueOfType<bool>(json, r'moderate_media_content_human') ?? false,
        moderateProfileNamesBot: mapValueOfType<bool>(json, r'moderate_profile_names_bot') ?? false,
        moderateProfileNamesHuman: mapValueOfType<bool>(json, r'moderate_profile_names_human') ?? false,
        moderateProfileTextsBot: mapValueOfType<bool>(json, r'moderate_profile_texts_bot') ?? false,
        moderateProfileTextsHuman: mapValueOfType<bool>(json, r'moderate_profile_texts_human') ?? false,
        processReports: mapValueOfType<bool>(json, r'process_reports') ?? false,
      );
    }
    return null;
  }

  static List<AdminNotification> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminNotification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminNotification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminNotification> mapFromJson(dynamic json) {
    final map = <String, AdminNotification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminNotification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminNotification-objects as value to a dart map
  static Map<String, List<AdminNotification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminNotification>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminNotification.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

