//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeFilterValueUpdate {
  /// Returns a new [ProfileAttributeFilterValueUpdate] instance.
  ProfileAttributeFilterValueUpdate({
    this.acceptMissingAttribute,
    this.filterPart1,
    this.filterPart2,
    required this.id,
  });

  /// Should missing attribute be accepted.  Setting this to `None` disables the filter.
  bool? acceptMissingAttribute;

  /// Bitflags value or top level attribute value ID filter.
  ///
  /// Minimum value: 0
  int? filterPart1;

  /// Sub level attribute value ID filter.
  ///
  /// Minimum value: 0
  int? filterPart2;

  /// Attribute ID
  ///
  /// Minimum value: 0
  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeFilterValueUpdate &&
     other.acceptMissingAttribute == acceptMissingAttribute &&
     other.filterPart1 == filterPart1 &&
     other.filterPart2 == filterPart2 &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (acceptMissingAttribute == null ? 0 : acceptMissingAttribute!.hashCode) +
    (filterPart1 == null ? 0 : filterPart1!.hashCode) +
    (filterPart2 == null ? 0 : filterPart2!.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'ProfileAttributeFilterValueUpdate[acceptMissingAttribute=$acceptMissingAttribute, filterPart1=$filterPart1, filterPart2=$filterPart2, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.acceptMissingAttribute != null) {
      json[r'accept_missing_attribute'] = this.acceptMissingAttribute;
    } else {
      json[r'accept_missing_attribute'] = null;
    }
    if (this.filterPart1 != null) {
      json[r'filter_part1'] = this.filterPart1;
    } else {
      json[r'filter_part1'] = null;
    }
    if (this.filterPart2 != null) {
      json[r'filter_part2'] = this.filterPart2;
    } else {
      json[r'filter_part2'] = null;
    }
      json[r'id'] = this.id;
    return json;
  }

  /// Returns a new [ProfileAttributeFilterValueUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeFilterValueUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeFilterValueUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeFilterValueUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeFilterValueUpdate(
        acceptMissingAttribute: mapValueOfType<bool>(json, r'accept_missing_attribute'),
        filterPart1: mapValueOfType<int>(json, r'filter_part1'),
        filterPart2: mapValueOfType<int>(json, r'filter_part2'),
        id: mapValueOfType<int>(json, r'id')!,
      );
    }
    return null;
  }

  static List<ProfileAttributeFilterValueUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeFilterValueUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeFilterValueUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeFilterValueUpdate> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeFilterValueUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeFilterValueUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeFilterValueUpdate-objects as value to a dart map
  static Map<String, List<ProfileAttributeFilterValueUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeFilterValueUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeFilterValueUpdate.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
  };
}

