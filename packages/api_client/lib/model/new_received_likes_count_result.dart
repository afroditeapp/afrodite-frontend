//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class NewReceivedLikesCountResult {
  /// Returns a new [NewReceivedLikesCountResult] instance.
  NewReceivedLikesCountResult({
    required this.c,
    this.h = false,
    required this.l,
    required this.v,
  });

  NewReceivedLikesCount c;

  /// If true, client should not show the notification
  bool h;

  /// Latest received like in use. Client can use this to check should received likes be refreshed.
  ReceivedLikeId l;

  ReceivedLikesSyncVersion v;

  @override
  bool operator ==(Object other) => identical(this, other) || other is NewReceivedLikesCountResult &&
    other.c == c &&
    other.h == h &&
    other.l == l &&
    other.v == v;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (h.hashCode) +
    (l.hashCode) +
    (v.hashCode);

  @override
  String toString() => 'NewReceivedLikesCountResult[c=$c, h=$h, l=$l, v=$v]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
      json[r'h'] = this.h;
      json[r'l'] = this.l;
      json[r'v'] = this.v;
    return json;
  }

  /// Returns a new [NewReceivedLikesCountResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static NewReceivedLikesCountResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "NewReceivedLikesCountResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "NewReceivedLikesCountResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return NewReceivedLikesCountResult(
        c: NewReceivedLikesCount.fromJson(json[r'c'])!,
        h: mapValueOfType<bool>(json, r'h') ?? false,
        l: ReceivedLikeId.fromJson(json[r'l'])!,
        v: ReceivedLikesSyncVersion.fromJson(json[r'v'])!,
      );
    }
    return null;
  }

  static List<NewReceivedLikesCountResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <NewReceivedLikesCountResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NewReceivedLikesCountResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, NewReceivedLikesCountResult> mapFromJson(dynamic json) {
    final map = <String, NewReceivedLikesCountResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = NewReceivedLikesCountResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of NewReceivedLikesCountResult-objects as value to a dart map
  static Map<String, List<NewReceivedLikesCountResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<NewReceivedLikesCountResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = NewReceivedLikesCountResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
    'l',
    'v',
  };
}

