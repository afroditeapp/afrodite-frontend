//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientFeaturesConfig {
  /// Returns a new [ClientFeaturesConfig] instance.
  ClientFeaturesConfig({
    this.attribution,
    this.chat,
    this.features,
    this.likes,
    this.map,
    this.news,
    this.profile,
    this.server,
  });

  AttributionConfig? attribution;

  ChatConfig? chat;

  FeaturesConfig? features;

  LikesConfig? likes;

  MapConfig? map;

  NewsConfig? news;

  ProfileConfig? profile;

  ServerConfig? server;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientFeaturesConfig &&
    other.attribution == attribution &&
    other.chat == chat &&
    other.features == features &&
    other.likes == likes &&
    other.map == map &&
    other.news == news &&
    other.profile == profile &&
    other.server == server;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (attribution == null ? 0 : attribution!.hashCode) +
    (chat == null ? 0 : chat!.hashCode) +
    (features == null ? 0 : features!.hashCode) +
    (likes == null ? 0 : likes!.hashCode) +
    (map == null ? 0 : map!.hashCode) +
    (news == null ? 0 : news!.hashCode) +
    (profile == null ? 0 : profile!.hashCode) +
    (server == null ? 0 : server!.hashCode);

  @override
  String toString() => 'ClientFeaturesConfig[attribution=$attribution, chat=$chat, features=$features, likes=$likes, map=$map, news=$news, profile=$profile, server=$server]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.attribution != null) {
      json[r'attribution'] = this.attribution;
    } else {
      json[r'attribution'] = null;
    }
    if (this.chat != null) {
      json[r'chat'] = this.chat;
    } else {
      json[r'chat'] = null;
    }
    if (this.features != null) {
      json[r'features'] = this.features;
    } else {
      json[r'features'] = null;
    }
    if (this.likes != null) {
      json[r'likes'] = this.likes;
    } else {
      json[r'likes'] = null;
    }
    if (this.map != null) {
      json[r'map'] = this.map;
    } else {
      json[r'map'] = null;
    }
    if (this.news != null) {
      json[r'news'] = this.news;
    } else {
      json[r'news'] = null;
    }
    if (this.profile != null) {
      json[r'profile'] = this.profile;
    } else {
      json[r'profile'] = null;
    }
    if (this.server != null) {
      json[r'server'] = this.server;
    } else {
      json[r'server'] = null;
    }
    return json;
  }

  /// Returns a new [ClientFeaturesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientFeaturesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientFeaturesConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientFeaturesConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientFeaturesConfig(
        attribution: AttributionConfig.fromJson(json[r'attribution']),
        chat: ChatConfig.fromJson(json[r'chat']),
        features: FeaturesConfig.fromJson(json[r'features']),
        likes: LikesConfig.fromJson(json[r'likes']),
        map: MapConfig.fromJson(json[r'map']),
        news: NewsConfig.fromJson(json[r'news']),
        profile: ProfileConfig.fromJson(json[r'profile']),
        server: ServerConfig.fromJson(json[r'server']),
      );
    }
    return null;
  }

  static List<ClientFeaturesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientFeaturesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientFeaturesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientFeaturesConfig> mapFromJson(dynamic json) {
    final map = <String, ClientFeaturesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientFeaturesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientFeaturesConfig-objects as value to a dart map
  static Map<String, List<ClientFeaturesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientFeaturesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientFeaturesConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

