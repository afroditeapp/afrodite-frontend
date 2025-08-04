//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class IpCountryStatisticsType {
  /// Instantiate a new enum with the provided [value].
  const IpCountryStatisticsType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const newTcpConnections = IpCountryStatisticsType._(r'NewTcpConnections');
  static const newHttpRequests = IpCountryStatisticsType._(r'NewHttpRequests');

  /// List of all possible values in this [enum][IpCountryStatisticsType].
  static const values = <IpCountryStatisticsType>[
    newTcpConnections,
    newHttpRequests,
  ];

  static IpCountryStatisticsType? fromJson(dynamic value) => IpCountryStatisticsTypeTypeTransformer().decode(value);

  static List<IpCountryStatisticsType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <IpCountryStatisticsType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IpCountryStatisticsType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [IpCountryStatisticsType] to String,
/// and [decode] dynamic data back to [IpCountryStatisticsType].
class IpCountryStatisticsTypeTypeTransformer {
  factory IpCountryStatisticsTypeTypeTransformer() => _instance ??= const IpCountryStatisticsTypeTypeTransformer._();

  const IpCountryStatisticsTypeTypeTransformer._();

  String encode(IpCountryStatisticsType data) => data.value;

  /// Decodes a [dynamic value][data] to a IpCountryStatisticsType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  IpCountryStatisticsType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'NewTcpConnections': return IpCountryStatisticsType.newTcpConnections;
        case r'NewHttpRequests': return IpCountryStatisticsType.newHttpRequests;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [IpCountryStatisticsTypeTypeTransformer] instance.
  static IpCountryStatisticsTypeTypeTransformer? _instance;
}

