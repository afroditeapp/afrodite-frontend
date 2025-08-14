//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BackendConfig {
  /// Returns a new [BackendConfig] instance.
  BackendConfig({
    this.localBots,
    this.remoteBotLogin,
  });

  LocalBotsConfig? localBots;

  /// Enable remote bot login API  If None, editing the value is disabled.
  bool? remoteBotLogin;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BackendConfig &&
    other.localBots == localBots &&
    other.remoteBotLogin == remoteBotLogin;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (localBots == null ? 0 : localBots!.hashCode) +
    (remoteBotLogin == null ? 0 : remoteBotLogin!.hashCode);

  @override
  String toString() => 'BackendConfig[localBots=$localBots, remoteBotLogin=$remoteBotLogin]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.localBots != null) {
      json[r'local_bots'] = this.localBots;
    } else {
      json[r'local_bots'] = null;
    }
    if (this.remoteBotLogin != null) {
      json[r'remote_bot_login'] = this.remoteBotLogin;
    } else {
      json[r'remote_bot_login'] = null;
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
        localBots: LocalBotsConfig.fromJson(json[r'local_bots']),
        remoteBotLogin: mapValueOfType<bool>(json, r'remote_bot_login'),
      );
    }
    return null;
  }

  static List<BackendConfig> listFromJson(dynamic json, {bool growable = false,}) {
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
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BackendConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

