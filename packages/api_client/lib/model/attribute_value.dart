//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AttributeValue {
  /// Returns a new [AttributeValue] instance.
  AttributeValue({
    this.editable = true,
    this.groupValues,
    this.icon,
    required this.id,
    required this.key,
    required this.orderNumber,
    required this.value,
    this.visible = true,
  });

  bool editable;

  GroupValues? groupValues;

  String? icon;

  /// Numeric unique identifier for the attribute value. Note that the value must only be unique within a group of values, so value in top level group A, sub level group C and sub level group B can have the same ID.
  ///
  /// Minimum value: 0
  int id;

  /// Unique string identifier for the attribute value.
  String key;

  /// Order number for client to determine in what order the values should be displayed.
  ///
  /// Minimum value: 0
  int orderNumber;

  /// English text for the attribute value.
  String value;

  bool visible;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AttributeValue &&
    other.editable == editable &&
    other.groupValues == groupValues &&
    other.icon == icon &&
    other.id == id &&
    other.key == key &&
    other.orderNumber == orderNumber &&
    other.value == value &&
    other.visible == visible;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (editable.hashCode) +
    (groupValues == null ? 0 : groupValues!.hashCode) +
    (icon == null ? 0 : icon!.hashCode) +
    (id.hashCode) +
    (key.hashCode) +
    (orderNumber.hashCode) +
    (value.hashCode) +
    (visible.hashCode);

  @override
  String toString() => 'AttributeValue[editable=$editable, groupValues=$groupValues, icon=$icon, id=$id, key=$key, orderNumber=$orderNumber, value=$value, visible=$visible]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'editable'] = this.editable;
    if (this.groupValues != null) {
      json[r'group_values'] = this.groupValues;
    } else {
      json[r'group_values'] = null;
    }
    if (this.icon != null) {
      json[r'icon'] = this.icon;
    } else {
      json[r'icon'] = null;
    }
      json[r'id'] = this.id;
      json[r'key'] = this.key;
      json[r'order_number'] = this.orderNumber;
      json[r'value'] = this.value;
      json[r'visible'] = this.visible;
    return json;
  }

  /// Returns a new [AttributeValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AttributeValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AttributeValue[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AttributeValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AttributeValue(
        editable: mapValueOfType<bool>(json, r'editable') ?? true,
        groupValues: GroupValues.fromJson(json[r'group_values']),
        icon: mapValueOfType<String>(json, r'icon'),
        id: mapValueOfType<int>(json, r'id')!,
        key: mapValueOfType<String>(json, r'key')!,
        orderNumber: mapValueOfType<int>(json, r'order_number')!,
        value: mapValueOfType<String>(json, r'value')!,
        visible: mapValueOfType<bool>(json, r'visible') ?? true,
      );
    }
    return null;
  }

  static List<AttributeValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttributeValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttributeValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AttributeValue> mapFromJson(dynamic json) {
    final map = <String, AttributeValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AttributeValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AttributeValue-objects as value to a dart map
  static Map<String, List<AttributeValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AttributeValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AttributeValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'key',
    'order_number',
    'value',
  };
}

