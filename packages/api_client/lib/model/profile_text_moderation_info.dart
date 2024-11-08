//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileTextModerationInfo {
  /// Returns a new [ProfileTextModerationInfo] instance.
  ProfileTextModerationInfo({
    this.rejectedReasonCategory,
    this.rejectedReasonDetails,
    required this.state,
  });

  ProfileTextModerationRejectedReasonCategory? rejectedReasonCategory;

  ProfileTextModerationRejectedReasonDetails? rejectedReasonDetails;

  ProfileTextModerationState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileTextModerationInfo &&
    other.rejectedReasonCategory == rejectedReasonCategory &&
    other.rejectedReasonDetails == rejectedReasonDetails &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (rejectedReasonCategory == null ? 0 : rejectedReasonCategory!.hashCode) +
    (rejectedReasonDetails == null ? 0 : rejectedReasonDetails!.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'ProfileTextModerationInfo[rejectedReasonCategory=$rejectedReasonCategory, rejectedReasonDetails=$rejectedReasonDetails, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.rejectedReasonCategory != null) {
      json[r'rejected_reason_category'] = this.rejectedReasonCategory;
    } else {
      json[r'rejected_reason_category'] = null;
    }
    if (this.rejectedReasonDetails != null) {
      json[r'rejected_reason_details'] = this.rejectedReasonDetails;
    } else {
      json[r'rejected_reason_details'] = null;
    }
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [ProfileTextModerationInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileTextModerationInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileTextModerationInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileTextModerationInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileTextModerationInfo(
        rejectedReasonCategory: ProfileTextModerationRejectedReasonCategory.fromJson(json[r'rejected_reason_category']),
        rejectedReasonDetails: ProfileTextModerationRejectedReasonDetails.fromJson(json[r'rejected_reason_details']),
        state: ProfileTextModerationState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<ProfileTextModerationInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileTextModerationInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileTextModerationInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileTextModerationInfo> mapFromJson(dynamic json) {
    final map = <String, ProfileTextModerationInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileTextModerationInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileTextModerationInfo-objects as value to a dart map
  static Map<String, List<ProfileTextModerationInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileTextModerationInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileTextModerationInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'state',
  };
}

