//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class VerificationAction {
  /// Instantiate a new enum with the provided [value].
  const VerificationAction._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accept = VerificationAction._(r'Accept');
  static const reject = VerificationAction._(r'Reject');

  /// List of all possible values in this [enum][VerificationAction].
  static const values = <VerificationAction>[
    accept,
    reject,
  ];

  static VerificationAction? fromJson(dynamic value) => VerificationActionTypeTransformer().decode(value);

  static List<VerificationAction> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerificationAction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerificationAction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerificationAction] to String,
/// and [decode] dynamic data back to [VerificationAction].
class VerificationActionTypeTransformer {
  factory VerificationActionTypeTransformer() => _instance ??= const VerificationActionTypeTransformer._();

  const VerificationActionTypeTransformer._();

  String encode(VerificationAction data) => data.value;

  /// Decodes a [dynamic value][data] to a VerificationAction.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerificationAction? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Accept': return VerificationAction.accept;
        case r'Reject': return VerificationAction.reject;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [VerificationActionTypeTransformer] instance.
  static VerificationActionTypeTransformer? _instance;
}

