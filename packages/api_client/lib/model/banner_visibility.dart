//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BannerVisibility {
  /// Returns a new [BannerVisibility] instance.
  BannerVisibility({
    this.chats = false,
    this.conversation = false,
    this.likes = false,
    this.menu = false,
    this.profiles = false,
  });

  bool chats;

  bool conversation;

  bool likes;

  bool menu;

  bool profiles;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BannerVisibility &&
    other.chats == chats &&
    other.conversation == conversation &&
    other.likes == likes &&
    other.menu == menu &&
    other.profiles == profiles;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chats.hashCode) +
    (conversation.hashCode) +
    (likes.hashCode) +
    (menu.hashCode) +
    (profiles.hashCode);

  @override
  String toString() => 'BannerVisibility[chats=$chats, conversation=$conversation, likes=$likes, menu=$menu, profiles=$profiles]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'chats'] = this.chats;
      json[r'conversation'] = this.conversation;
      json[r'likes'] = this.likes;
      json[r'menu'] = this.menu;
      json[r'profiles'] = this.profiles;
    return json;
  }

  /// Returns a new [BannerVisibility] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BannerVisibility? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BannerVisibility[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BannerVisibility[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BannerVisibility(
        chats: mapValueOfType<bool>(json, r'chats') ?? false,
        conversation: mapValueOfType<bool>(json, r'conversation') ?? false,
        likes: mapValueOfType<bool>(json, r'likes') ?? false,
        menu: mapValueOfType<bool>(json, r'menu') ?? false,
        profiles: mapValueOfType<bool>(json, r'profiles') ?? false,
      );
    }
    return null;
  }

  static List<BannerVisibility> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BannerVisibility>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BannerVisibility.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BannerVisibility> mapFromJson(dynamic json) {
    final map = <String, BannerVisibility>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BannerVisibility.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BannerVisibility-objects as value to a dart map
  static Map<String, List<BannerVisibility>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BannerVisibility>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BannerVisibility.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

