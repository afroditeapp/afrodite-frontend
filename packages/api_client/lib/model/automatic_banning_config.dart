//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AutomaticBanningConfig {
  /// Returns a new [AutomaticBanningConfig] instance.
  AutomaticBanningConfig({
    required this.dayCounts,
    this.reasonDetailsVisibleToUser = false,
    this.saveReasonDetails = false,
  });

  AutomaticBanningDayCountConfig dayCounts;

  /// Show ban reason details to the banned user.
  bool reasonDetailsVisibleToUser;

  /// Save the LLM response as the ban reason details.
  bool saveReasonDetails;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AutomaticBanningConfig &&
    other.dayCounts == dayCounts &&
    other.reasonDetailsVisibleToUser == reasonDetailsVisibleToUser &&
    other.saveReasonDetails == saveReasonDetails;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dayCounts.hashCode) +
    (reasonDetailsVisibleToUser.hashCode) +
    (saveReasonDetails.hashCode);

  @override
  String toString() => 'AutomaticBanningConfig[dayCounts=$dayCounts, reasonDetailsVisibleToUser=$reasonDetailsVisibleToUser, saveReasonDetails=$saveReasonDetails]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'day_counts'] = this.dayCounts;
      json[r'reason_details_visible_to_user'] = this.reasonDetailsVisibleToUser;
      json[r'save_reason_details'] = this.saveReasonDetails;
    return json;
  }

  /// Returns a new [AutomaticBanningConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AutomaticBanningConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'day_counts'), 'Required key "AutomaticBanningConfig[day_counts]" is missing from JSON.');
        assert(json[r'day_counts'] != null, 'Required key "AutomaticBanningConfig[day_counts]" has a null value in JSON.');
        return true;
      }());

      return AutomaticBanningConfig(
        dayCounts: AutomaticBanningDayCountConfig.fromJson(json[r'day_counts'])!,
        reasonDetailsVisibleToUser: mapValueOfType<bool>(json, r'reason_details_visible_to_user') ?? false,
        saveReasonDetails: mapValueOfType<bool>(json, r'save_reason_details') ?? false,
      );
    }
    return null;
  }

  static List<AutomaticBanningConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AutomaticBanningConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AutomaticBanningConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AutomaticBanningConfig> mapFromJson(dynamic json) {
    final map = <String, AutomaticBanningConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AutomaticBanningConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AutomaticBanningConfig-objects as value to a dart map
  static Map<String, List<AutomaticBanningConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AutomaticBanningConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AutomaticBanningConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'day_counts',
  };
}

