//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetProfileStatisticsResult {
  /// Returns a new [GetProfileStatisticsResult] instance.
  GetProfileStatisticsResult({
    required this.accountCountBotsExcluded,
    required this.ageCounts,
    required this.connectionsAverage,
    required this.connectionsMax,
    required this.connectionsMin,
    required this.generationTime,
    required this.onlineAccountCountBotsExcluded,
  });

  int accountCountBotsExcluded;

  ProfileAgeCounts ageCounts;

  /// Average WebSocket connections per hour
  ConnectionStatistics connectionsAverage;

  /// Max WebSocket connections per hour
  ConnectionStatistics connectionsMax;

  /// Min WebSocket connections per hour
  ConnectionStatistics connectionsMin;

  UnixTime generationTime;

  int onlineAccountCountBotsExcluded;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetProfileStatisticsResult &&
    other.accountCountBotsExcluded == accountCountBotsExcluded &&
    other.ageCounts == ageCounts &&
    other.connectionsAverage == connectionsAverage &&
    other.connectionsMax == connectionsMax &&
    other.connectionsMin == connectionsMin &&
    other.generationTime == generationTime &&
    other.onlineAccountCountBotsExcluded == onlineAccountCountBotsExcluded;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountCountBotsExcluded.hashCode) +
    (ageCounts.hashCode) +
    (connectionsAverage.hashCode) +
    (connectionsMax.hashCode) +
    (connectionsMin.hashCode) +
    (generationTime.hashCode) +
    (onlineAccountCountBotsExcluded.hashCode);

  @override
  String toString() => 'GetProfileStatisticsResult[accountCountBotsExcluded=$accountCountBotsExcluded, ageCounts=$ageCounts, connectionsAverage=$connectionsAverage, connectionsMax=$connectionsMax, connectionsMin=$connectionsMin, generationTime=$generationTime, onlineAccountCountBotsExcluded=$onlineAccountCountBotsExcluded]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_count_bots_excluded'] = this.accountCountBotsExcluded;
      json[r'age_counts'] = this.ageCounts;
      json[r'connections_average'] = this.connectionsAverage;
      json[r'connections_max'] = this.connectionsMax;
      json[r'connections_min'] = this.connectionsMin;
      json[r'generation_time'] = this.generationTime;
      json[r'online_account_count_bots_excluded'] = this.onlineAccountCountBotsExcluded;
    return json;
  }

  /// Returns a new [GetProfileStatisticsResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetProfileStatisticsResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetProfileStatisticsResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetProfileStatisticsResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetProfileStatisticsResult(
        accountCountBotsExcluded: mapValueOfType<int>(json, r'account_count_bots_excluded')!,
        ageCounts: ProfileAgeCounts.fromJson(json[r'age_counts'])!,
        connectionsAverage: ConnectionStatistics.fromJson(json[r'connections_average'])!,
        connectionsMax: ConnectionStatistics.fromJson(json[r'connections_max'])!,
        connectionsMin: ConnectionStatistics.fromJson(json[r'connections_min'])!,
        generationTime: UnixTime.fromJson(json[r'generation_time'])!,
        onlineAccountCountBotsExcluded: mapValueOfType<int>(json, r'online_account_count_bots_excluded')!,
      );
    }
    return null;
  }

  static List<GetProfileStatisticsResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetProfileStatisticsResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetProfileStatisticsResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetProfileStatisticsResult> mapFromJson(dynamic json) {
    final map = <String, GetProfileStatisticsResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetProfileStatisticsResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetProfileStatisticsResult-objects as value to a dart map
  static Map<String, List<GetProfileStatisticsResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetProfileStatisticsResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetProfileStatisticsResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_count_bots_excluded',
    'age_counts',
    'connections_average',
    'connections_max',
    'connections_min',
    'generation_time',
    'online_account_count_bots_excluded',
  };
}

