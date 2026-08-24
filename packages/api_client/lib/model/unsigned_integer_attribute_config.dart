//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UnsignedIntegerAttributeConfig {
  /// Returns a new [UnsignedIntegerAttributeConfig] instance.
  UnsignedIntegerAttributeConfig({
    required this.max,
    required this.min,
    this.unit,
  });

  /// User visible maximum value for the attribute.
  ///
  /// Minimum value: 0
  int max;

  /// User visible minimum value for the attribute.
  ///
  /// Minimum value: 0
  int min;

  /// User visible unit for the value, for example `cm` or `kg`.  The default text shown when a translation for the key `{attribute_key}_unit` is not available.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? unit;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UnsignedIntegerAttributeConfig &&
    other.max == max &&
    other.min == min &&
    other.unit == unit;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (max.hashCode) +
    (min.hashCode) +
    (unit == null ? 0 : unit!.hashCode);

  @override
  String toString() => 'UnsignedIntegerAttributeConfig[max=$max, min=$min, unit=$unit]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'max'] = this.max;
      json[r'min'] = this.min;
    if (this.unit != null) {
      json[r'unit'] = this.unit;
    } else {
      json[r'unit'] = null;
    }
    return json;
  }

  /// Returns a new [UnsignedIntegerAttributeConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UnsignedIntegerAttributeConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'max'), 'Required key "UnsignedIntegerAttributeConfig[max]" is missing from JSON.');
        assert(json[r'max'] != null, 'Required key "UnsignedIntegerAttributeConfig[max]" has a null value in JSON.');
        assert(json.containsKey(r'min'), 'Required key "UnsignedIntegerAttributeConfig[min]" is missing from JSON.');
        assert(json[r'min'] != null, 'Required key "UnsignedIntegerAttributeConfig[min]" has a null value in JSON.');
        return true;
      }());

      return UnsignedIntegerAttributeConfig(
        max: mapValueOfType<int>(json, r'max')!,
        min: mapValueOfType<int>(json, r'min')!,
        unit: mapValueOfType<String>(json, r'unit'),
      );
    }
    return null;
  }

  static List<UnsignedIntegerAttributeConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UnsignedIntegerAttributeConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UnsignedIntegerAttributeConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UnsignedIntegerAttributeConfig> mapFromJson(dynamic json) {
    final map = <String, UnsignedIntegerAttributeConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UnsignedIntegerAttributeConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UnsignedIntegerAttributeConfig-objects as value to a dart map
  static Map<String, List<UnsignedIntegerAttributeConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UnsignedIntegerAttributeConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UnsignedIntegerAttributeConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'max',
    'min',
  };
}

