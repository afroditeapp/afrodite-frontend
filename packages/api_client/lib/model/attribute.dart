//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Attribute {
  /// Returns a new [Attribute] instance.
  Attribute({
    this.editable = true,
    this.icon,
    required this.id,
    required this.key,
    this.maxFilters = 1,
    this.maxSelected = 1,
    required this.mode,
    required this.name,
    required this.orderNumber,
    this.required_ = false,
    this.translations = const [],
    required this.valueOrder,
    this.values = const [],
    this.visible = true,
  });

  /// Client should show this attribute when editing a profile.
  bool editable;

  /// Icon for the attribute.
  String? icon;

  /// Minimum value: 0
  int id;

  /// String unique identifier for the attribute.
  String key;

  /// Minimum value: 0
  int maxFilters;

  /// Minimum value: 0
  int maxSelected;

  /// Mode of the attribute.
  AttributeMode mode;

  /// Default name for the attribute if translated value is not available.
  String name;

  /// Attribute order number.
  ///
  /// Minimum value: 0
  int orderNumber;

  /// Client should ask this attribute when doing account initial setup.
  bool required_;

  /// Translations for attribute name and attribute values.
  List<Language> translations;

  /// Attribute value ordering mode for client to determine in what order the values should be displayed.
  AttributeValueOrderMode valueOrder;

  /// Top level values for the attribute.  Values are sorted by AttributeValue ID. Indexing with it is not possible as ID might be a bitflag value.
  List<AttributeValue> values;

  /// Client should show this attribute when viewing a profile.
  bool visible;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Attribute &&
    other.editable == editable &&
    other.icon == icon &&
    other.id == id &&
    other.key == key &&
    other.maxFilters == maxFilters &&
    other.maxSelected == maxSelected &&
    other.mode == mode &&
    other.name == name &&
    other.orderNumber == orderNumber &&
    other.required_ == required_ &&
    _deepEquality.equals(other.translations, translations) &&
    other.valueOrder == valueOrder &&
    _deepEquality.equals(other.values, values) &&
    other.visible == visible;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (editable.hashCode) +
    (icon == null ? 0 : icon!.hashCode) +
    (id.hashCode) +
    (key.hashCode) +
    (maxFilters.hashCode) +
    (maxSelected.hashCode) +
    (mode.hashCode) +
    (name.hashCode) +
    (orderNumber.hashCode) +
    (required_.hashCode) +
    (translations.hashCode) +
    (valueOrder.hashCode) +
    (values.hashCode) +
    (visible.hashCode);

  @override
  String toString() => 'Attribute[editable=$editable, icon=$icon, id=$id, key=$key, maxFilters=$maxFilters, maxSelected=$maxSelected, mode=$mode, name=$name, orderNumber=$orderNumber, required_=$required_, translations=$translations, valueOrder=$valueOrder, values=$values, visible=$visible]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'editable'] = this.editable;
    if (this.icon != null) {
      json[r'icon'] = this.icon;
    } else {
      json[r'icon'] = null;
    }
      json[r'id'] = this.id;
      json[r'key'] = this.key;
      json[r'max_filters'] = this.maxFilters;
      json[r'max_selected'] = this.maxSelected;
      json[r'mode'] = this.mode;
      json[r'name'] = this.name;
      json[r'order_number'] = this.orderNumber;
      json[r'required'] = this.required_;
      json[r'translations'] = this.translations;
      json[r'value_order'] = this.valueOrder;
      json[r'values'] = this.values;
      json[r'visible'] = this.visible;
    return json;
  }

  /// Returns a new [Attribute] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Attribute? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Attribute[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Attribute[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Attribute(
        editable: mapValueOfType<bool>(json, r'editable') ?? true,
        icon: mapValueOfType<String>(json, r'icon'),
        id: mapValueOfType<int>(json, r'id')!,
        key: mapValueOfType<String>(json, r'key')!,
        maxFilters: mapValueOfType<int>(json, r'max_filters') ?? 1,
        maxSelected: mapValueOfType<int>(json, r'max_selected') ?? 1,
        mode: AttributeMode.fromJson(json[r'mode'])!,
        name: mapValueOfType<String>(json, r'name')!,
        orderNumber: mapValueOfType<int>(json, r'order_number')!,
        required_: mapValueOfType<bool>(json, r'required') ?? false,
        translations: Language.listFromJson(json[r'translations']),
        valueOrder: AttributeValueOrderMode.fromJson(json[r'value_order'])!,
        values: AttributeValue.listFromJson(json[r'values']),
        visible: mapValueOfType<bool>(json, r'visible') ?? true,
      );
    }
    return null;
  }

  static List<Attribute> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Attribute>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Attribute.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Attribute> mapFromJson(dynamic json) {
    final map = <String, Attribute>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Attribute.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Attribute-objects as value to a dart map
  static Map<String, List<Attribute>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Attribute>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Attribute.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'key',
    'mode',
    'name',
    'order_number',
    'value_order',
    'values',
  };
}

