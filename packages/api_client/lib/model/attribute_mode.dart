//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AttributeMode {
  /// Instantiate a new enum with the provided [value].
  const AttributeMode._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const selectSingleFilterSingle = AttributeMode._(r'SelectSingleFilterSingle');
  static const selectSingleFilterMultiple = AttributeMode._(r'SelectSingleFilterMultiple');
  static const selectMultipleFilterMultiple = AttributeMode._(r'SelectMultipleFilterMultiple');

  /// List of all possible values in this [enum][AttributeMode].
  static const values = <AttributeMode>[
    selectSingleFilterSingle,
    selectSingleFilterMultiple,
    selectMultipleFilterMultiple,
  ];

  static AttributeMode? fromJson(dynamic value) => AttributeModeTypeTransformer().decode(value);

  static List<AttributeMode>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttributeMode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttributeMode.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AttributeMode] to String,
/// and [decode] dynamic data back to [AttributeMode].
class AttributeModeTypeTransformer {
  factory AttributeModeTypeTransformer() => _instance ??= const AttributeModeTypeTransformer._();

  const AttributeModeTypeTransformer._();

  String encode(AttributeMode data) => data.value;

  /// Decodes a [dynamic value][data] to a AttributeMode.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AttributeMode? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SelectSingleFilterSingle': return AttributeMode.selectSingleFilterSingle;
        case r'SelectSingleFilterMultiple': return AttributeMode.selectSingleFilterMultiple;
        case r'SelectMultipleFilterMultiple': return AttributeMode.selectMultipleFilterMultiple;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AttributeModeTypeTransformer] instance.
  static AttributeModeTypeTransformer? _instance;
}

