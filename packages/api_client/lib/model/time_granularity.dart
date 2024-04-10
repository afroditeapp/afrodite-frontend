//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TimeGranularity {
  /// Instantiate a new enum with the provided [value].
  const TimeGranularity._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const minutes = TimeGranularity._(r'Minutes');
  static const hours = TimeGranularity._(r'Hours');

  /// List of all possible values in this [enum][TimeGranularity].
  static const values = <TimeGranularity>[
    minutes,
    hours,
  ];

  static TimeGranularity? fromJson(dynamic value) => TimeGranularityTypeTransformer().decode(value);

  static List<TimeGranularity>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TimeGranularity>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TimeGranularity.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TimeGranularity] to String,
/// and [decode] dynamic data back to [TimeGranularity].
class TimeGranularityTypeTransformer {
  factory TimeGranularityTypeTransformer() => _instance ??= const TimeGranularityTypeTransformer._();

  const TimeGranularityTypeTransformer._();

  String encode(TimeGranularity data) => data.value;

  /// Decodes a [dynamic value][data] to a TimeGranularity.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TimeGranularity? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Minutes': return TimeGranularity.minutes;
        case r'Hours': return TimeGranularity.hours;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TimeGranularityTypeTransformer] instance.
  static TimeGranularityTypeTransformer? _instance;
}

