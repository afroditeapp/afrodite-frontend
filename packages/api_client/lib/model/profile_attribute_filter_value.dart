//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProfileAttributeFilterValue {
  /// Returns a new [ProfileAttributeFilterValue] instance.
  ProfileAttributeFilterValue({
    required this.acceptMissingAttribute,
    this.filterValues = const [],
    this.filterValuesNonselected = const [],
    required this.id,
    required this.useLogicalOperatorAnd,
  });

  bool acceptMissingAttribute;

  /// For bitflag filters the list only has one u16 value.  For one level attributes the values are u16 attribute value IDs.  For two level attributes the values are u32 values with most significant u16 containing attribute value ID and least significant u16 containing group value ID.  The values are stored in ascending order.
  List<int> filterValues;

  /// Same as [Self::filter_values] but for nonselected values.  The nonselected values are checked always with AND operator.
  List<int> filterValuesNonselected;

  /// Minimum value: 0
  int id;

  bool useLogicalOperatorAnd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeFilterValue &&
    other.acceptMissingAttribute == acceptMissingAttribute &&
    _deepEquality.equals(other.filterValues, filterValues) &&
    _deepEquality.equals(other.filterValuesNonselected, filterValuesNonselected) &&
    other.id == id &&
    other.useLogicalOperatorAnd == useLogicalOperatorAnd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (acceptMissingAttribute.hashCode) +
    (filterValues.hashCode) +
    (filterValuesNonselected.hashCode) +
    (id.hashCode) +
    (useLogicalOperatorAnd.hashCode);

  @override
  String toString() => 'ProfileAttributeFilterValue[acceptMissingAttribute=$acceptMissingAttribute, filterValues=$filterValues, filterValuesNonselected=$filterValuesNonselected, id=$id, useLogicalOperatorAnd=$useLogicalOperatorAnd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept_missing_attribute'] = this.acceptMissingAttribute;
      json[r'filter_values'] = this.filterValues;
      json[r'filter_values_nonselected'] = this.filterValuesNonselected;
      json[r'id'] = this.id;
      json[r'use_logical_operator_and'] = this.useLogicalOperatorAnd;
    return json;
  }

  /// Returns a new [ProfileAttributeFilterValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProfileAttributeFilterValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProfileAttributeFilterValue[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProfileAttributeFilterValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProfileAttributeFilterValue(
        acceptMissingAttribute: mapValueOfType<bool>(json, r'accept_missing_attribute')!,
        filterValues: json[r'filter_values'] is Iterable
            ? (json[r'filter_values'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        filterValuesNonselected: json[r'filter_values_nonselected'] is Iterable
            ? (json[r'filter_values_nonselected'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        id: mapValueOfType<int>(json, r'id')!,
        useLogicalOperatorAnd: mapValueOfType<bool>(json, r'use_logical_operator_and')!,
      );
    }
    return null;
  }

  static List<ProfileAttributeFilterValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileAttributeFilterValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileAttributeFilterValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProfileAttributeFilterValue> mapFromJson(dynamic json) {
    final map = <String, ProfileAttributeFilterValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProfileAttributeFilterValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProfileAttributeFilterValue-objects as value to a dart map
  static Map<String, List<ProfileAttributeFilterValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProfileAttributeFilterValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProfileAttributeFilterValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accept_missing_attribute',
    'filter_values',
    'filter_values_nonselected',
    'id',
    'use_logical_operator_and',
  };
}

