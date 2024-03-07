//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AttributeOrderMode {
  /// Instantiate a new enum with the provided [value].
  const AttributeOrderMode._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const orderNumber = AttributeOrderMode._(r'OrderNumber');

  /// List of all possible values in this [enum][AttributeOrderMode].
  static const values = <AttributeOrderMode>[
    orderNumber,
  ];

  static AttributeOrderMode? fromJson(dynamic value) => AttributeOrderModeTypeTransformer().decode(value);

  static List<AttributeOrderMode>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttributeOrderMode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttributeOrderMode.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AttributeOrderMode] to String,
/// and [decode] dynamic data back to [AttributeOrderMode].
class AttributeOrderModeTypeTransformer {
  factory AttributeOrderModeTypeTransformer() => _instance ??= const AttributeOrderModeTypeTransformer._();

  const AttributeOrderModeTypeTransformer._();

  String encode(AttributeOrderMode data) => data.value;

  /// Decodes a [dynamic value][data] to a AttributeOrderMode.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AttributeOrderMode? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OrderNumber': return AttributeOrderMode.orderNumber;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AttributeOrderModeTypeTransformer] instance.
  static AttributeOrderModeTypeTransformer? _instance;
}

