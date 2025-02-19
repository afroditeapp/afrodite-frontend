//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReportIteratorMode {
  /// Instantiate a new enum with the provided [value].
  const ReportIteratorMode._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const received = ReportIteratorMode._(r'Received');
  static const sent = ReportIteratorMode._(r'Sent');

  /// List of all possible values in this [enum][ReportIteratorMode].
  static const values = <ReportIteratorMode>[
    received,
    sent,
  ];

  static ReportIteratorMode? fromJson(dynamic value) => ReportIteratorModeTypeTransformer().decode(value);

  static List<ReportIteratorMode> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportIteratorMode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportIteratorMode.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReportIteratorMode] to String,
/// and [decode] dynamic data back to [ReportIteratorMode].
class ReportIteratorModeTypeTransformer {
  factory ReportIteratorModeTypeTransformer() => _instance ??= const ReportIteratorModeTypeTransformer._();

  const ReportIteratorModeTypeTransformer._();

  String encode(ReportIteratorMode data) => data.value;

  /// Decodes a [dynamic value][data] to a ReportIteratorMode.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReportIteratorMode? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Received': return ReportIteratorMode.received;
        case r'Sent': return ReportIteratorMode.sent;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReportIteratorModeTypeTransformer] instance.
  static ReportIteratorModeTypeTransformer? _instance;
}

