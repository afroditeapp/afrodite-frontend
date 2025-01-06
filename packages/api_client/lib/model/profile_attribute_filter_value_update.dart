//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeFilterValueUpdate {
  /// Returns a new [ProfileAttributeFilterValueUpdate] instance.
  ProfileAttributeFilterValueUpdate({
    this.acceptMissingAttribute,
    this.filterValues = const [],
    required this.id,
  });

  /// Defines should missing attribute be accepted.  Setting this to `None` disables the filter.
  bool? acceptMissingAttribute;

  /// - First value is bitflags value or top level attribute value ID or first number list value. - Second value is sub level attribute value ID or second number list value. - Third and rest are number list values.
  List<int> filterValues;

  /// Minimum value: 0
  int id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeFilterValueUpdate &&
    other.acceptMissingAttribute == acceptMissingAttribute &&
    _deepEquality.equals(other.filterValues, filterValues) &&
    other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (acceptMissingAttribute == null ? 0 : acceptMissingAttribute!.hashCode) +
    (filterValues.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'ProfileAttributeFilterValueUpdate[acceptMissingAttribute=$acceptMissingAttribute, filterValues=$filterValues, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.acceptMissingAttribute != null) {
      json[r'accept_missing_attribute'] = this.acceptMissingAttribute;
    } else {
      json[r'accept_missing_attribute'] = null;
    }
      json[r'filter_values'] = this.filterValues;
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
        filterValues: json[r'filter_values'] is Iterable
            ? (json[r'filter_values'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        id: mapValueOfType<int>(json, r'id')!,
      );
    }
    return null;
  }

  static List<ProfileAttributeFilterValueUpdate> listFromJson(dynamic json, {bool growable = false,}) {
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
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributeFilterValueUpdate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'filter_values',
    'id',
  };
}

