//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileStringModerationInfo {
  /// Returns a new [ProfileStringModerationInfo] instance.
  ProfileStringModerationInfo({
    this.rejectedReasonCategory,
    required this.rejectedReasonDetails,
    required this.state,
  });

  ProfileStringModerationRejectedReasonCategory? rejectedReasonCategory;

  ProfileStringModerationRejectedReasonDetails rejectedReasonDetails;

  ProfileStringModerationState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileStringModerationInfo &&
    other.rejectedReasonCategory == rejectedReasonCategory &&
    other.rejectedReasonDetails == rejectedReasonDetails &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (rejectedReasonCategory == null ? 0 : rejectedReasonCategory!.hashCode) +
    (rejectedReasonDetails.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'ProfileStringModerationInfo[rejectedReasonCategory=$rejectedReasonCategory, rejectedReasonDetails=$rejectedReasonDetails, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.rejectedReasonCategory != null) {
      json[r'rejected_reason_category'] = this.rejectedReasonCategory;
    } else {
      json[r'rejected_reason_category'] = null;
    }
      json[r'rejected_reason_details'] = this.rejectedReasonDetails;
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [ProfileStringModerationInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileStringModerationInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileStringModerationInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileStringModerationInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileStringModerationInfo(
        rejectedReasonCategory: ProfileStringModerationRejectedReasonCategory.fromJson(json[r'rejected_reason_category']),
        rejectedReasonDetails: ProfileStringModerationRejectedReasonDetails.fromJson(json[r'rejected_reason_details'])!,
        state: ProfileStringModerationState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<ProfileStringModerationInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStringModerationInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStringModerationInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileStringModerationInfo> mapFromJson(dynamic json) {
    final map = <String, ProfileStringModerationInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileStringModerationInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileStringModerationInfo-objects as value to a dart map
  static Map<String, List<ProfileStringModerationInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileStringModerationInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileStringModerationInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'rejected_reason_details',
    'state',
  };
}

