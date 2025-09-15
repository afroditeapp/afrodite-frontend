//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReceivedLikesPageItem {
  /// Returns a new [ReceivedLikesPageItem] instance.
  ReceivedLikesPageItem({
    this.notViewed,
    required this.p,
  });

  /// If Some, the like is not viewed yet
  ReceivedLikeId? notViewed;

  ProfileLink p;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReceivedLikesPageItem &&
    other.notViewed == notViewed &&
    other.p == p;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (notViewed == null ? 0 : notViewed!.hashCode) +
    (p.hashCode);

  @override
  String toString() => 'ReceivedLikesPageItem[notViewed=$notViewed, p=$p]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.notViewed != null) {
      json[r'not_viewed'] = this.notViewed;
    } else {
      json[r'not_viewed'] = null;
    }
      json[r'p'] = this.p;
    return json;
  }

  /// Returns a new [ReceivedLikesPageItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReceivedLikesPageItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ReceivedLikesPageItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ReceivedLikesPageItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ReceivedLikesPageItem(
        notViewed: ReceivedLikeId.fromJson(json[r'not_viewed']),
        p: ProfileLink.fromJson(json[r'p'])!,
      );
    }
    return null;
  }

  static List<ReceivedLikesPageItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReceivedLikesPageItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReceivedLikesPageItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReceivedLikesPageItem> mapFromJson(dynamic json) {
    final map = <String, ReceivedLikesPageItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReceivedLikesPageItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReceivedLikesPageItem-objects as value to a dart map
  static Map<String, List<ReceivedLikesPageItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReceivedLikesPageItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReceivedLikesPageItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'p',
  };
}

