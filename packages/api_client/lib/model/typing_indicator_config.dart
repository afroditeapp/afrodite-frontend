//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TypingIndicatorConfig {
  /// Returns a new [TypingIndicatorConfig] instance.
  TypingIndicatorConfig({
    required this.minWaitSecondsBetweenRequestsClient,
    required this.minWaitSecondsBetweenRequestsServer,
    required this.startEventTtlSeconds,
  });

  /// Client should wait at least this time before sending another typing indicator message.
  ///
  /// Minimum value: 0
  int minWaitSecondsBetweenRequestsClient;

  /// Server ignores messages that are received before wait time elapses.
  ///
  /// Minimum value: 0
  int minWaitSecondsBetweenRequestsServer;

  /// Client should hide typing indicator after this time elapses from [crate::EventType::TypingStart].
  ///
  /// Minimum value: 0
  int startEventTtlSeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TypingIndicatorConfig &&
    other.minWaitSecondsBetweenRequestsClient == minWaitSecondsBetweenRequestsClient &&
    other.minWaitSecondsBetweenRequestsServer == minWaitSecondsBetweenRequestsServer &&
    other.startEventTtlSeconds == startEventTtlSeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (minWaitSecondsBetweenRequestsClient.hashCode) +
    (minWaitSecondsBetweenRequestsServer.hashCode) +
    (startEventTtlSeconds.hashCode);

  @override
  String toString() => 'TypingIndicatorConfig[minWaitSecondsBetweenRequestsClient=$minWaitSecondsBetweenRequestsClient, minWaitSecondsBetweenRequestsServer=$minWaitSecondsBetweenRequestsServer, startEventTtlSeconds=$startEventTtlSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'min_wait_seconds_between_requests_client'] = this.minWaitSecondsBetweenRequestsClient;
      json[r'min_wait_seconds_between_requests_server'] = this.minWaitSecondsBetweenRequestsServer;
      json[r'start_event_ttl_seconds'] = this.startEventTtlSeconds;
    return json;
  }

  /// Returns a new [TypingIndicatorConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TypingIndicatorConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'min_wait_seconds_between_requests_client'), 'Required key "TypingIndicatorConfig[min_wait_seconds_between_requests_client]" is missing from JSON.');
        assert(json[r'min_wait_seconds_between_requests_client'] != null, 'Required key "TypingIndicatorConfig[min_wait_seconds_between_requests_client]" has a null value in JSON.');
        assert(json.containsKey(r'min_wait_seconds_between_requests_server'), 'Required key "TypingIndicatorConfig[min_wait_seconds_between_requests_server]" is missing from JSON.');
        assert(json[r'min_wait_seconds_between_requests_server'] != null, 'Required key "TypingIndicatorConfig[min_wait_seconds_between_requests_server]" has a null value in JSON.');
        assert(json.containsKey(r'start_event_ttl_seconds'), 'Required key "TypingIndicatorConfig[start_event_ttl_seconds]" is missing from JSON.');
        assert(json[r'start_event_ttl_seconds'] != null, 'Required key "TypingIndicatorConfig[start_event_ttl_seconds]" has a null value in JSON.');
        return true;
      }());

      return TypingIndicatorConfig(
        minWaitSecondsBetweenRequestsClient: mapValueOfType<int>(json, r'min_wait_seconds_between_requests_client')!,
        minWaitSecondsBetweenRequestsServer: mapValueOfType<int>(json, r'min_wait_seconds_between_requests_server')!,
        startEventTtlSeconds: mapValueOfType<int>(json, r'start_event_ttl_seconds')!,
      );
    }
    return null;
  }

  static List<TypingIndicatorConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TypingIndicatorConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TypingIndicatorConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TypingIndicatorConfig> mapFromJson(dynamic json) {
    final map = <String, TypingIndicatorConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TypingIndicatorConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TypingIndicatorConfig-objects as value to a dart map
  static Map<String, List<TypingIndicatorConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TypingIndicatorConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TypingIndicatorConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'min_wait_seconds_between_requests_client',
    'min_wait_seconds_between_requests_server',
    'start_event_ttl_seconds',
  };
}

