//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DeliveryInfoType {
  /// Instantiate a new enum with the provided [value].
  const DeliveryInfoType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const delivered = DeliveryInfoType._(r'Delivered');
  static const seen = DeliveryInfoType._(r'Seen');

  /// List of all possible values in this [enum][DeliveryInfoType].
  static const values = <DeliveryInfoType>[
    delivered,
    seen,
  ];

  static DeliveryInfoType? fromJson(dynamic value) => DeliveryInfoTypeTypeTransformer().decode(value);

  static List<DeliveryInfoType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeliveryInfoType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeliveryInfoType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DeliveryInfoType] to String,
/// and [decode] dynamic data back to [DeliveryInfoType].
class DeliveryInfoTypeTypeTransformer {
  factory DeliveryInfoTypeTypeTransformer() => _instance ??= const DeliveryInfoTypeTypeTransformer._();

  const DeliveryInfoTypeTypeTransformer._();

  String encode(DeliveryInfoType data) => data.value;

  /// Decodes a [dynamic value][data] to a DeliveryInfoType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DeliveryInfoType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Delivered': return DeliveryInfoType.delivered;
        case r'Seen': return DeliveryInfoType.seen;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [DeliveryInfoTypeTypeTransformer] instance.
  static DeliveryInfoTypeTypeTransformer? _instance;
}

