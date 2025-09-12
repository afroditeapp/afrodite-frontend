//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MatchesIteratorState {
  /// Returns a new [MatchesIteratorState] instance.
  MatchesIteratorState({
    required this.idAtReset,
    required this.page,
  });

  MatchId idAtReset;

  int page;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MatchesIteratorState &&
    other.idAtReset == idAtReset &&
    other.page == page;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (idAtReset.hashCode) +
    (page.hashCode);

  @override
  String toString() => 'MatchesIteratorState[idAtReset=$idAtReset, page=$page]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id_at_reset'] = this.idAtReset;
      json[r'page'] = this.page;
    return json;
  }

  /// Returns a new [MatchesIteratorState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MatchesIteratorState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MatchesIteratorState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MatchesIteratorState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MatchesIteratorState(
        idAtReset: MatchId.fromJson(json[r'id_at_reset'])!,
        page: mapValueOfType<int>(json, r'page')!,
      );
    }
    return null;
  }

  static List<MatchesIteratorState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MatchesIteratorState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MatchesIteratorState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MatchesIteratorState> mapFromJson(dynamic json) {
    final map = <String, MatchesIteratorState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MatchesIteratorState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MatchesIteratorState-objects as value to a dart map
  static Map<String, List<MatchesIteratorState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MatchesIteratorState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MatchesIteratorState.listFromJson(entry.value, growable: growable,);
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

