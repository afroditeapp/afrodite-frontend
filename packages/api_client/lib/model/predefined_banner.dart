//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PredefinedBanner {
  /// Instantiate a new enum with the provided [value].
  const PredefinedBanner._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const serverMaintenance = PredefinedBanner._(r'ServerMaintenance');
  static const adminBotOffline = PredefinedBanner._(r'AdminBotOffline');

  /// List of all possible values in this [enum][PredefinedBanner].
  static const values = <PredefinedBanner>[
    serverMaintenance,
    adminBotOffline,
  ];

  static PredefinedBanner? fromJson(dynamic value) => PredefinedBannerTypeTransformer().decode(value);

  static List<PredefinedBanner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PredefinedBanner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PredefinedBanner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PredefinedBanner] to String,
/// and [decode] dynamic data back to [PredefinedBanner].
class PredefinedBannerTypeTransformer {
  factory PredefinedBannerTypeTransformer() => _instance ??= const PredefinedBannerTypeTransformer._();

  const PredefinedBannerTypeTransformer._();

  String encode(PredefinedBanner data) => data.value;

  /// Decodes a [dynamic value][data] to a PredefinedBanner.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PredefinedBanner? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'ServerMaintenance': return PredefinedBanner.serverMaintenance;
        case r'AdminBotOffline': return PredefinedBanner.adminBotOffline;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PredefinedBannerTypeTransformer] instance.
  static PredefinedBannerTypeTransformer? _instance;
}

