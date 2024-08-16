//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class LimitedActionStatus {
  /// Instantiate a new enum with the provided [value].
  const LimitedActionStatus._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const success = LimitedActionStatus._(r'Success');
  static const successAndLimitReached = LimitedActionStatus._(r'SuccessAndLimitReached');
  static const failureLimitAlreadyReached = LimitedActionStatus._(r'FailureLimitAlreadyReached');

  /// List of all possible values in this [enum][LimitedActionStatus].
  static const values = <LimitedActionStatus>[
    success,
    successAndLimitReached,
    failureLimitAlreadyReached,
  ];

  static LimitedActionStatus? fromJson(dynamic value) => LimitedActionStatusTypeTransformer().decode(value);

  static List<LimitedActionStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LimitedActionStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LimitedActionStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [LimitedActionStatus] to String,
/// and [decode] dynamic data back to [LimitedActionStatus].
class LimitedActionStatusTypeTransformer {
  factory LimitedActionStatusTypeTransformer() => _instance ??= const LimitedActionStatusTypeTransformer._();

  const LimitedActionStatusTypeTransformer._();

  String encode(LimitedActionStatus data) => data.value;

  /// Decodes a [dynamic value][data] to a LimitedActionStatus.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  LimitedActionStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Success': return LimitedActionStatus.success;
        case r'SuccessAndLimitReached': return LimitedActionStatus.successAndLimitReached;
        case r'FailureLimitAlreadyReached': return LimitedActionStatus.failureLimitAlreadyReached;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [LimitedActionStatusTypeTransformer] instance.
  static LimitedActionStatusTypeTransformer? _instance;
}

