//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum AttributeValueOrderMode {
  alphabethicalKey._(r'AlphabethicalKey'),
  alphabethicalValue._(r'AlphabethicalValue'),
  orderNumber._(r'OrderNumber'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const AttributeValueOrderMode._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AttributeValueOrderMode] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AttributeValueOrderMode? fromJson(dynamic value) => AttributeValueOrderModeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AttributeValueOrderMode]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AttributeValueOrderMode> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttributeValueOrderMode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttributeValueOrderMode.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AttributeValueOrderMode] to String,
/// and [decode] dynamic data back to [AttributeValueOrderMode].
class AttributeValueOrderModeTypeTransformer {
  factory AttributeValueOrderModeTypeTransformer() => _instance ??= const AttributeValueOrderModeTypeTransformer._();

  const AttributeValueOrderModeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(AttributeValueOrderMode data) => data._value;

  /// Returns the instance of [AttributeValueOrderMode] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AttributeValueOrderMode? decode(dynamic data, {bool allowNull = true}) {
    if (data is AttributeValueOrderMode) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'AlphabethicalKey': return AttributeValueOrderMode.alphabethicalKey;
        case r'AlphabethicalValue': return AttributeValueOrderMode.alphabethicalValue;
        case r'OrderNumber': return AttributeValueOrderMode.orderNumber;
        case r'unknown_default_open_api': return AttributeValueOrderMode.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AttributeValueOrderModeTypeTransformer? _instance;
}

