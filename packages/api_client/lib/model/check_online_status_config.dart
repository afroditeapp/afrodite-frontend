//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CheckOnlineStatusConfig {
  /// Returns a new [CheckOnlineStatusConfig] instance.
  CheckOnlineStatusConfig({
    required this.minWaitSecondsBetweenRequestsClient,
    required this.minWaitSecondsBetweenRequestsServer,
  });

  /// Client should wait at least this time before sending another check online status request.
  ///
  /// Minimum value: 0
  int minWaitSecondsBetweenRequestsClient;

  /// Server ignores check online status requests that are received before wait time elapses.
  ///
  /// Minimum value: 0
  int minWaitSecondsBetweenRequestsServer;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CheckOnlineStatusConfig &&
    other.minWaitSecondsBetweenRequestsClient == minWaitSecondsBetweenRequestsClient &&
    other.minWaitSecondsBetweenRequestsServer == minWaitSecondsBetweenRequestsServer;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (minWaitSecondsBetweenRequestsClient.hashCode) +
    (minWaitSecondsBetweenRequestsServer.hashCode);

  @override
  String toString() => 'CheckOnlineStatusConfig[minWaitSecondsBetweenRequestsClient=$minWaitSecondsBetweenRequestsClient, minWaitSecondsBetweenRequestsServer=$minWaitSecondsBetweenRequestsServer]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'min_wait_seconds_between_requests_client'] = this.minWaitSecondsBetweenRequestsClient;
      json[r'min_wait_seconds_between_requests_server'] = this.minWaitSecondsBetweenRequestsServer;
    return json;
  }

  /// Returns a new [CheckOnlineStatusConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CheckOnlineStatusConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CheckOnlineStatusConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CheckOnlineStatusConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CheckOnlineStatusConfig(
        minWaitSecondsBetweenRequestsClient: mapValueOfType<int>(json, r'min_wait_seconds_between_requests_client')!,
        minWaitSecondsBetweenRequestsServer: mapValueOfType<int>(json, r'min_wait_seconds_between_requests_server')!,
      );
    }
    return null;
  }

  static List<CheckOnlineStatusConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CheckOnlineStatusConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CheckOnlineStatusConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CheckOnlineStatusConfig> mapFromJson(dynamic json) {
    final map = <String, CheckOnlineStatusConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckOnlineStatusConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CheckOnlineStatusConfig-objects as value to a dart map
  static Map<String, List<CheckOnlineStatusConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CheckOnlineStatusConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CheckOnlineStatusConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'min_wait_seconds_between_requests_client',
    'min_wait_seconds_between_requests_server',
  };
}

