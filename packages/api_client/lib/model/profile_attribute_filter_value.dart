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
    required this.id,
    this.unwanted = const [],
    required this.useLogicalOperatorAnd,
    this.wanted = const [],
  });

  bool acceptMissingAttribute;

  /// Attribute ID
  int id;

  /// Same as [Self::wanted] but for unwanted values.  The unwanted values are checked always with AND operator.
  List<int> unwanted;

  bool useLogicalOperatorAnd;

  /// Wanted attribute values.  For bitflag filters the list only has one u16 value.  For one level attributes the values are u16 attribute value IDs.  For two level attributes the values are u32 values with most significant u16 containing attribute value ID and least significant u16 containing group value ID.  The values are stored in ascending order.
  List<int> wanted;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProfileAttributeFilterValue &&
    other.acceptMissingAttribute == acceptMissingAttribute &&
    other.id == id &&
    _deepEquality.equals(other.unwanted, unwanted) &&
    other.useLogicalOperatorAnd == useLogicalOperatorAnd &&
    _deepEquality.equals(other.wanted, wanted);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (acceptMissingAttribute.hashCode) +
    (id.hashCode) +
    (unwanted.hashCode) +
    (useLogicalOperatorAnd.hashCode) +
    (wanted.hashCode);

  @override
  String toString() => 'ProfileAttributeFilterValue[acceptMissingAttribute=$acceptMissingAttribute, id=$id, unwanted=$unwanted, useLogicalOperatorAnd=$useLogicalOperatorAnd, wanted=$wanted]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept_missing_attribute'] = this.acceptMissingAttribute;
      json[r'id'] = this.id;
      json[r'unwanted'] = this.unwanted;
      json[r'use_logical_operator_and'] = this.useLogicalOperatorAnd;
      json[r'wanted'] = this.wanted;
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
        assert(json.containsKey(r'accept_missing_attribute'), 'Required key "ProfileAttributeFilterValue[accept_missing_attribute]" is missing from JSON.');
        assert(json[r'accept_missing_attribute'] != null, 'Required key "ProfileAttributeFilterValue[accept_missing_attribute]" has a null value in JSON.');
        assert(json.containsKey(r'id'), 'Required key "ProfileAttributeFilterValue[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProfileAttributeFilterValue[id]" has a null value in JSON.');
        assert(json.containsKey(r'unwanted'), 'Required key "ProfileAttributeFilterValue[unwanted]" is missing from JSON.');
        assert(json[r'unwanted'] != null, 'Required key "ProfileAttributeFilterValue[unwanted]" has a null value in JSON.');
        assert(json.containsKey(r'use_logical_operator_and'), 'Required key "ProfileAttributeFilterValue[use_logical_operator_and]" is missing from JSON.');
        assert(json[r'use_logical_operator_and'] != null, 'Required key "ProfileAttributeFilterValue[use_logical_operator_and]" has a null value in JSON.');
        assert(json.containsKey(r'wanted'), 'Required key "ProfileAttributeFilterValue[wanted]" is missing from JSON.');
        assert(json[r'wanted'] != null, 'Required key "ProfileAttributeFilterValue[wanted]" has a null value in JSON.');
        return true;
      }());

      return ProfileAttributeFilterValue(
        acceptMissingAttribute: mapValueOfType<bool>(json, r'accept_missing_attribute')!,
        id: mapValueOfType<int>(json, r'id')!,
        unwanted: json[r'unwanted'] is Iterable
            ? (json[r'unwanted'] as Iterable).cast<int>().toList(growable: false)
            : const [],
        useLogicalOperatorAnd: mapValueOfType<bool>(json, r'use_logical_operator_and')!,
        wanted: json[r'wanted'] is Iterable
            ? (json[r'wanted'] as Iterable).cast<int>().toList(growable: false)
            : const [],
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
    'id',
    'unwanted',
    'use_logical_operator_and',
    'wanted',
  };
}

