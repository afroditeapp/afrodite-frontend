//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AttributeValueOrderMode {
  /// Instantiate a new enum with the provided [value].
  const AttributeValueOrderMode._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const alphabethicalKey = AttributeValueOrderMode._(r'AlphabethicalKey');
  static const alphabethicalValue = AttributeValueOrderMode._(r'AlphabethicalValue');
  static const orderNumber = AttributeValueOrderMode._(r'OrderNumber');

  /// List of all possible values in this [enum][AttributeValueOrderMode].
  static const values = <AttributeValueOrderMode>[
    alphabethicalKey,
    alphabethicalValue,
    orderNumber,
  ];

  static AttributeValueOrderMode? fromJson(dynamic value) => AttributeValueOrderModeTypeTransformer().decode(value);

  static List<AttributeValueOrderMode>? listFromJson(dynamic json, {bool growable = false,}) {
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

  String encode(AttributeValueOrderMode data) => data.value;

  /// Decodes a [dynamic value][data] to a AttributeValueOrderMode.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AttributeValueOrderMode? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AlphabethicalKey': return AttributeValueOrderMode.alphabethicalKey;
        case r'AlphabethicalValue': return AttributeValueOrderMode.alphabethicalValue;
        case r'OrderNumber': return AttributeValueOrderMode.orderNumber;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AttributeValueOrderModeTypeTransformer] instance.
  static AttributeValueOrderModeTypeTransformer? _instance;
}

