//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BotConfig {
  /// Returns a new [BotConfig] instance.
  BotConfig({
    this.adminBot = false,
    required this.adminBotConfig,
    this.remoteBotLogin = false,
    this.userBots = 0,
  });

  /// Admin bot enabled
  bool adminBot;

  /// Admin bot config
  AdminBotConfig adminBotConfig;

  /// Enable remote bot login API
  bool remoteBotLogin;

  /// User bot count
  ///
  /// Minimum value: 0
  int userBots;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BotConfig &&
    other.adminBot == adminBot &&
    other.adminBotConfig == adminBotConfig &&
    other.remoteBotLogin == remoteBotLogin &&
    other.userBots == userBots;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adminBot.hashCode) +
    (adminBotConfig.hashCode) +
    (remoteBotLogin.hashCode) +
    (userBots.hashCode);

  @override
  String toString() => 'BotConfig[adminBot=$adminBot, adminBotConfig=$adminBotConfig, remoteBotLogin=$remoteBotLogin, userBots=$userBots]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'admin_bot'] = this.adminBot;
      json[r'admin_bot_config'] = this.adminBotConfig;
      json[r'remote_bot_login'] = this.remoteBotLogin;
      json[r'user_bots'] = this.userBots;
    return json;
  }

  /// Returns a new [BotConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BotConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BotConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BotConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BotConfig(
        adminBot: mapValueOfType<bool>(json, r'admin_bot') ?? false,
        adminBotConfig: AdminBotConfig.fromJson(json[r'admin_bot_config'])!,
        remoteBotLogin: mapValueOfType<bool>(json, r'remote_bot_login') ?? false,
        userBots: mapValueOfType<int>(json, r'user_bots') ?? 0,
      );
    }
    return null;
  }

  static List<BotConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BotConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BotConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BotConfig> mapFromJson(dynamic json) {
    final map = <String, BotConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BotConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BotConfig-objects as value to a dart map
  static Map<String, List<BotConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BotConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BotConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'admin_bot_config',
  };
}

