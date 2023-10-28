//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SentLikesPage {
  /// Returns a new [SentLikesPage] instance.
  SentLikesPage({
    this.profiles = const [],
  });

  List<AccountId> profiles;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SentLikesPage &&
     other.profiles == profiles;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (profiles.hashCode);

  @override
  String toString() => 'SentLikesPage[profiles=$profiles]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'profiles'] = this.profiles;
    return json;
  }

  /// Returns a new [SentLikesPage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SentLikesPage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SentLikesPage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SentLikesPage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SentLikesPage(
        profiles: AccountId.listFromJson(json[r'profiles'])!,
      );
    }
    return null;
  }

  static List<SentLikesPage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SentLikesPage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SentLikesPage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SentLikesPage> mapFromJson(dynamic json) {
    final map = <String, SentLikesPage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SentLikesPage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SentLikesPage-objects as value to a dart map
  static Map<String, List<SentLikesPage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SentLikesPage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SentLikesPage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'profiles',
  };
}

