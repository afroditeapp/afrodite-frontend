//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SentLikesIteratorState {
  /// Returns a new [SentLikesIteratorState] instance.
  SentLikesIteratorState({
    required this.idAtReset,
    required this.page,
  });

  SentLikeId idAtReset;

  int page;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SentLikesIteratorState &&
    other.idAtReset == idAtReset &&
    other.page == page;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (idAtReset.hashCode) +
    (page.hashCode);

  @override
  String toString() => 'SentLikesIteratorState[idAtReset=$idAtReset, page=$page]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id_at_reset'] = this.idAtReset;
      json[r'page'] = this.page;
    return json;
  }

  /// Returns a new [SentLikesIteratorState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SentLikesIteratorState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id_at_reset'), 'Required key "SentLikesIteratorState[id_at_reset]" is missing from JSON.');
        assert(json[r'id_at_reset'] != null, 'Required key "SentLikesIteratorState[id_at_reset]" has a null value in JSON.');
        assert(json.containsKey(r'page'), 'Required key "SentLikesIteratorState[page]" is missing from JSON.');
        assert(json[r'page'] != null, 'Required key "SentLikesIteratorState[page]" has a null value in JSON.');
        return true;
      }());

      return SentLikesIteratorState(
        idAtReset: SentLikeId.fromJson(json[r'id_at_reset'])!,
        page: mapValueOfType<int>(json, r'page')!,
      );
    }
    return null;
  }

  static List<SentLikesIteratorState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SentLikesIteratorState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SentLikesIteratorState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SentLikesIteratorState> mapFromJson(dynamic json) {
    final map = <String, SentLikesIteratorState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SentLikesIteratorState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SentLikesIteratorState-objects as value to a dart map
  static Map<String, List<SentLikesIteratorState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SentLikesIteratorState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SentLikesIteratorState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id_at_reset',
    'page',
  };
}

