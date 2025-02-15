//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileNameReportDetailed {
  /// Returns a new [ProfileNameReportDetailed] instance.
  ProfileNameReportDetailed({
    required this.info,
    this.profileName,
  });

  ReportDetailedInfo info;

  String? profileName;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileNameReportDetailed &&
    other.info == info &&
    other.profileName == profileName;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (info.hashCode) +
    (profileName == null ? 0 : profileName!.hashCode);

  @override
  String toString() => 'ProfileNameReportDetailed[info=$info, profileName=$profileName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'info'] = this.info;
    if (this.profileName != null) {
      json[r'profile_name'] = this.profileName;
    } else {
      json[r'profile_name'] = null;
    }
    return json;
  }

  /// Returns a new [ProfileNameReportDetailed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileNameReportDetailed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileNameReportDetailed[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileNameReportDetailed[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileNameReportDetailed(
        info: ReportDetailedInfo.fromJson(json[r'info'])!,
        profileName: mapValueOfType<String>(json, r'profile_name'),
      );
    }
    return null;
  }

  static List<ProfileNameReportDetailed> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileNameReportDetailed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileNameReportDetailed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileNameReportDetailed> mapFromJson(dynamic json) {
    final map = <String, ProfileNameReportDetailed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileNameReportDetailed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileNameReportDetailed-objects as value to a dart map
  static Map<String, List<ProfileNameReportDetailed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileNameReportDetailed>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileNameReportDetailed.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'info',
  };
}

