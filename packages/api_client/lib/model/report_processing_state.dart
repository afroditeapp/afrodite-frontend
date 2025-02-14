//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReportProcessingState {
  /// Instantiate a new enum with the provided [value].
  const ReportProcessingState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const empty = ReportProcessingState._(r'Empty');
  static const waiting = ReportProcessingState._(r'Waiting');
  static const done = ReportProcessingState._(r'Done');

  /// List of all possible values in this [enum][ReportProcessingState].
  static const values = <ReportProcessingState>[
    empty,
    waiting,
    done,
  ];

  static ReportProcessingState? fromJson(dynamic value) => ReportProcessingStateTypeTransformer().decode(value);

  static List<ReportProcessingState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportProcessingState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportProcessingState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReportProcessingState] to String,
/// and [decode] dynamic data back to [ReportProcessingState].
class ReportProcessingStateTypeTransformer {
  factory ReportProcessingStateTypeTransformer() => _instance ??= const ReportProcessingStateTypeTransformer._();

  const ReportProcessingStateTypeTransformer._();

  String encode(ReportProcessingState data) => data.value;

  /// Decodes a [dynamic value][data] to a ReportProcessingState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReportProcessingState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Empty': return ReportProcessingState.empty;
        case r'Waiting': return ReportProcessingState.waiting;
        case r'Done': return ReportProcessingState.done;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReportProcessingStateTypeTransformer] instance.
  static ReportProcessingStateTypeTransformer? _instance;
}

