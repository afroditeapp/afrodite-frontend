//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CustomReportType {
  /// Instantiate a new enum with the provided [value].
  const CustomReportType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const boolean = CustomReportType._(r'Boolean');

  /// List of all possible values in this [enum][CustomReportType].
  static const values = <CustomReportType>[
    boolean,
  ];

  static CustomReportType? fromJson(dynamic value) => CustomReportTypeTypeTransformer().decode(value);

  static List<CustomReportType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomReportType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomReportType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomReportType] to String,
/// and [decode] dynamic data back to [CustomReportType].
class CustomReportTypeTypeTransformer {
  factory CustomReportTypeTypeTransformer() => _instance ??= const CustomReportTypeTypeTransformer._();

  const CustomReportTypeTypeTransformer._();

  String encode(CustomReportType data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomReportType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomReportType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Boolean': return CustomReportType.boolean;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomReportTypeTypeTransformer] instance.
  static CustomReportTypeTypeTransformer? _instance;
}

