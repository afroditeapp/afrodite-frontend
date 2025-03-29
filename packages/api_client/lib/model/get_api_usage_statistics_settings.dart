//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetApiUsageStatisticsSettings {
  /// Returns a new [GetApiUsageStatisticsSettings] instance.
  GetApiUsageStatisticsSettings({
    required this.account,
    this.maxTime,
    this.minTime,
  });

  AccountId account;

  UnixTime? maxTime;

  UnixTime? minTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetApiUsageStatisticsSettings &&
    other.account == account &&
    other.maxTime == maxTime &&
    other.minTime == minTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (account.hashCode) +
    (maxTime == null ? 0 : maxTime!.hashCode) +
    (minTime == null ? 0 : minTime!.hashCode);

  @override
  String toString() => 'GetApiUsageStatisticsSettings[account=$account, maxTime=$maxTime, minTime=$minTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account'] = this.account;
    if (this.maxTime != null) {
      json[r'max_time'] = this.maxTime;
    } else {
      json[r'max_time'] = null;
    }
    if (this.minTime != null) {
      json[r'min_time'] = this.minTime;
    } else {
      json[r'min_time'] = null;
    }
    return json;
  }

  /// Returns a new [GetApiUsageStatisticsSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetApiUsageStatisticsSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetApiUsageStatisticsSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetApiUsageStatisticsSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetApiUsageStatisticsSettings(
        account: AccountId.fromJson(json[r'account'])!,
        maxTime: UnixTime.fromJson(json[r'max_time']),
        minTime: UnixTime.fromJson(json[r'min_time']),
      );
    }
    return null;
  }

  static List<GetApiUsageStatisticsSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetApiUsageStatisticsSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetApiUsageStatisticsSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetApiUsageStatisticsSettings> mapFromJson(dynamic json) {
    final map = <String, GetApiUsageStatisticsSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetApiUsageStatisticsSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetApiUsageStatisticsSettings-objects as value to a dart map
  static Map<String, List<GetApiUsageStatisticsSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetApiUsageStatisticsSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetApiUsageStatisticsSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account',
  };
}

