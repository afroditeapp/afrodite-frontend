//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SearchGroups {
  /// Returns a new [SearchGroups] instance.
  SearchGroups({
    this.manForMan = false,
    this.manForNonBinary = false,
    this.manForWoman = false,
    this.nonBinaryForMan = false,
    this.nonBinaryForNonBinary = false,
    this.nonBinaryForWoman = false,
    this.womanForMan = false,
    this.womanForNonBinary = false,
    this.womanForWoman = false,
  });

  bool manForMan;

  bool manForNonBinary;

  bool manForWoman;

  bool nonBinaryForMan;

  bool nonBinaryForNonBinary;

  bool nonBinaryForWoman;

  bool womanForMan;

  bool womanForNonBinary;

  bool womanForWoman;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SearchGroups &&
     other.manForMan == manForMan &&
     other.manForNonBinary == manForNonBinary &&
     other.manForWoman == manForWoman &&
     other.nonBinaryForMan == nonBinaryForMan &&
     other.nonBinaryForNonBinary == nonBinaryForNonBinary &&
     other.nonBinaryForWoman == nonBinaryForWoman &&
     other.womanForMan == womanForMan &&
     other.womanForNonBinary == womanForNonBinary &&
     other.womanForWoman == womanForWoman;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (manForMan.hashCode) +
    (manForNonBinary.hashCode) +
    (manForWoman.hashCode) +
    (nonBinaryForMan.hashCode) +
    (nonBinaryForNonBinary.hashCode) +
    (nonBinaryForWoman.hashCode) +
    (womanForMan.hashCode) +
    (womanForNonBinary.hashCode) +
    (womanForWoman.hashCode);

  @override
  String toString() => 'SearchGroups[manForMan=$manForMan, manForNonBinary=$manForNonBinary, manForWoman=$manForWoman, nonBinaryForMan=$nonBinaryForMan, nonBinaryForNonBinary=$nonBinaryForNonBinary, nonBinaryForWoman=$nonBinaryForWoman, womanForMan=$womanForMan, womanForNonBinary=$womanForNonBinary, womanForWoman=$womanForWoman]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'man_for_man'] = this.manForMan;
      json[r'man_for_non_binary'] = this.manForNonBinary;
      json[r'man_for_woman'] = this.manForWoman;
      json[r'non_binary_for_man'] = this.nonBinaryForMan;
      json[r'non_binary_for_non_binary'] = this.nonBinaryForNonBinary;
      json[r'non_binary_for_woman'] = this.nonBinaryForWoman;
      json[r'woman_for_man'] = this.womanForMan;
      json[r'woman_for_non_binary'] = this.womanForNonBinary;
      json[r'woman_for_woman'] = this.womanForWoman;
    return json;
  }

  /// Returns a new [SearchGroups] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SearchGroups? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SearchGroups[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SearchGroups[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SearchGroups(
        manForMan: mapValueOfType<bool>(json, r'man_for_man') ?? false,
        manForNonBinary: mapValueOfType<bool>(json, r'man_for_non_binary') ?? false,
        manForWoman: mapValueOfType<bool>(json, r'man_for_woman') ?? false,
        nonBinaryForMan: mapValueOfType<bool>(json, r'non_binary_for_man') ?? false,
        nonBinaryForNonBinary: mapValueOfType<bool>(json, r'non_binary_for_non_binary') ?? false,
        nonBinaryForWoman: mapValueOfType<bool>(json, r'non_binary_for_woman') ?? false,
        womanForMan: mapValueOfType<bool>(json, r'woman_for_man') ?? false,
        womanForNonBinary: mapValueOfType<bool>(json, r'woman_for_non_binary') ?? false,
        womanForWoman: mapValueOfType<bool>(json, r'woman_for_woman') ?? false,
      );
    }
    return null;
  }

  static List<SearchGroups>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SearchGroups>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SearchGroups.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SearchGroups> mapFromJson(dynamic json) {
    final map = <String, SearchGroups>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SearchGroups.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SearchGroups-objects as value to a dart map
  static Map<String, List<SearchGroups>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SearchGroups>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SearchGroups.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

