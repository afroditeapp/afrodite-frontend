//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CustomReportsOrderMode {
  /// Instantiate a new enum with the provided [value].
  const CustomReportsOrderMode._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const orderNumber = CustomReportsOrderMode._(r'OrderNumber');

  /// List of all possible values in this [enum][CustomReportsOrderMode].
  static const values = <CustomReportsOrderMode>[
    orderNumber,
  ];

  static CustomReportsOrderMode? fromJson(dynamic value) => CustomReportsOrderModeTypeTransformer().decode(value);

  static List<CustomReportsOrderMode> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReportsOrderMode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReportsOrderMode.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomReportsOrderMode] to String,
/// and [decode] dynamic data back to [CustomReportsOrderMode].
class CustomReportsOrderModeTypeTransformer {
  factory CustomReportsOrderModeTypeTransformer() => _instance ??= const CustomReportsOrderModeTypeTransformer._();

  const CustomReportsOrderModeTypeTransformer._();

  String encode(CustomReportsOrderMode data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomReportsOrderMode.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomReportsOrderMode? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'OrderNumber': return CustomReportsOrderMode.orderNumber;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomReportsOrderModeTypeTransformer] instance.
  static CustomReportsOrderModeTypeTransformer? _instance;
}

