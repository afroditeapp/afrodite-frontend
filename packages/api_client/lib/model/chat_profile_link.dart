//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatProfileLink {
  /// Returns a new [ChatProfileLink] instance.
  ChatProfileLink({
    required this.a,
    this.c,
    this.l,
    this.p,
  });

  AccountId a;

  /// This is optional because media component owns it.
  ProfileContentVersion? c;

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? l;

  /// This is optional because profile component owns it.
  ProfileVersion? p;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatProfileLink &&
    other.a == a &&
    other.c == c &&
    other.l == l &&
    other.p == p;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (a.hashCode) +
    (c == null ? 0 : c!.hashCode) +
    (l == null ? 0 : l!.hashCode) +
    (p == null ? 0 : p!.hashCode);

  @override
  String toString() => 'ChatProfileLink[a=$a, c=$c, l=$l, p=$p]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'a'] = this.a;
    if (this.c != null) {
      json[r'c'] = this.c;
    } else {
      json[r'c'] = null;
    }
    if (this.l != null) {
      json[r'l'] = this.l;
    } else {
      json[r'l'] = null;
    }
    if (this.p != null) {
      json[r'p'] = this.p;
    } else {
      json[r'p'] = null;
    }
    return json;
  }

  /// Returns a new [ChatProfileLink] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatProfileLink? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatProfileLink[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatProfileLink[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatProfileLink(
        a: AccountId.fromJson(json[r'a'])!,
        c: ProfileContentVersion.fromJson(json[r'c']),
        l: mapValueOfType<int>(json, r'l'),
        p: ProfileVersion.fromJson(json[r'p']),
      );
    }
    return null;
  }

  static List<ChatProfileLink> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatProfileLink>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatProfileLink.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatProfileLink> mapFromJson(dynamic json) {
    final map = <String, ChatProfileLink>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatProfileLink.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatProfileLink-objects as value to a dart map
  static Map<String, List<ChatProfileLink>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatProfileLink>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatProfileLink.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'a',
  };
}
