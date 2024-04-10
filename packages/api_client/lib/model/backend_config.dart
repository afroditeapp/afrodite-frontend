//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BackendConfig {
  /// Returns a new [BackendConfig] instance.
  BackendConfig({
    this.bots,
  });

  BotConfig? bots;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BackendConfig &&
     other.bots == bots;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (bots == null ? 0 : bots!.hashCode);

  @override
  String toString() => 'BackendConfig[bots=$bots]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.bots != null) {
      json[r'bots'] = this.bots;
    } else {
      json[r'bots'] = null;
    }
    return json;
  }

  /// Returns a new [BackendConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BackendConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BackendConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BackendConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BackendConfig(
        bots: BotConfig.fromJson(json[r'bots']),
      );
    }
    return null;
  }

  static List<BackendConfig>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BackendConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BackendConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BackendConfig> mapFromJson(dynamic json) {
    final map = <String, BackendConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BackendConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BackendConfig-objects as value to a dart map
  static Map<String, List<BackendConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BackendConfig>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BackendConfig.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

