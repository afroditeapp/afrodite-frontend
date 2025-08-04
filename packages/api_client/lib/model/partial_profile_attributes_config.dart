//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PartialProfileAttributesConfig {
  /// Returns a new [PartialProfileAttributesConfig] instance.
  PartialProfileAttributesConfig({
    required this.attributeOrder,
    this.attributes = const [],
  });

  AttributeOrderMode attributeOrder;

  List<ProfileAttributeInfo> attributes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PartialProfileAttributesConfig &&
    other.attributeOrder == attributeOrder &&
    _deepEquality.equals(other.attributes, attributes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (attributeOrder.hashCode) +
    (attributes.hashCode);

  @override
  String toString() => 'PartialProfileAttributesConfig[attributeOrder=$attributeOrder, attributes=$attributes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'attribute_order'] = this.attributeOrder;
      json[r'attributes'] = this.attributes;
    return json;
  }

  /// Returns a new [PartialProfileAttributesConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PartialProfileAttributesConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PartialProfileAttributesConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PartialProfileAttributesConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PartialProfileAttributesConfig(
        attributeOrder: AttributeOrderMode.fromJson(json[r'attribute_order'])!,
        attributes: ProfileAttributeInfo.listFromJson(json[r'attributes']),
      );
    }
    return null;
  }

  static List<PartialProfileAttributesConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PartialProfileAttributesConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PartialProfileAttributesConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PartialProfileAttributesConfig> mapFromJson(dynamic json) {
    final map = <String, PartialProfileAttributesConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PartialProfileAttributesConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PartialProfileAttributesConfig-objects as value to a dart map
  static Map<String, List<PartialProfileAttributesConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PartialProfileAttributesConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PartialProfileAttributesConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'attribute_order',
    'attributes',
  };
}

