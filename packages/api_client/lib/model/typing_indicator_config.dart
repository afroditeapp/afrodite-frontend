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
    this.enabled,
    this.minWaitSecondsBetweenSendingMessages,
    this.startEventTtlSeconds,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enabled;

  /// Server ignores messages that are received before wait time elapses.
  ///
  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? minWaitSecondsBetweenSendingMessages;

  /// Client should hide typing indicator after this time elapses from [crate::EventType::TypingStart].
  ///
  /// Minimum value: 0
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? startEventTtlSeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TypingIndicatorConfig &&
    other.enabled == enabled &&
    other.minWaitSecondsBetweenSendingMessages == minWaitSecondsBetweenSendingMessages &&
    other.startEventTtlSeconds == startEventTtlSeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (enabled == null ? 0 : enabled!.hashCode) +
    (minWaitSecondsBetweenSendingMessages == null ? 0 : minWaitSecondsBetweenSendingMessages!.hashCode) +
    (startEventTtlSeconds == null ? 0 : startEventTtlSeconds!.hashCode);

  @override
  String toString() => 'TypingIndicatorConfig[enabled=$enabled, minWaitSecondsBetweenSendingMessages=$minWaitSecondsBetweenSendingMessages, startEventTtlSeconds=$startEventTtlSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.enabled != null) {
      json[r'enabled'] = this.enabled;
    } else {
      json[r'enabled'] = null;
    }
    if (this.minWaitSecondsBetweenSendingMessages != null) {
      json[r'min_wait_seconds_between_sending_messages'] = this.minWaitSecondsBetweenSendingMessages;
    } else {
      json[r'min_wait_seconds_between_sending_messages'] = null;
    }
    if (this.startEventTtlSeconds != null) {
      json[r'start_event_ttl_seconds'] = this.startEventTtlSeconds;
    } else {
      json[r'start_event_ttl_seconds'] = null;
    }
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
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TypingIndicatorConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TypingIndicatorConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TypingIndicatorConfig(
        enabled: mapValueOfType<bool>(json, r'enabled'),
        minWaitSecondsBetweenSendingMessages: mapValueOfType<int>(json, r'min_wait_seconds_between_sending_messages'),
        startEventTtlSeconds: mapValueOfType<int>(json, r'start_event_ttl_seconds'),
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
  };
}

