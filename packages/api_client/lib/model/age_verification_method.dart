//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AgeVerificationMethod {
  /// Instantiate a new enum with the provided [value].
  const AgeVerificationMethod._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const debug = AgeVerificationMethod._(r'Debug');
  static const eudi = AgeVerificationMethod._(r'Eudi');

  /// List of all possible values in this [enum][AgeVerificationMethod].
  static const values = <AgeVerificationMethod>[
    debug,
    eudi,
  ];

  static AgeVerificationMethod? fromJson(dynamic value) => AgeVerificationMethodTypeTransformer().decode(value);

  static List<AgeVerificationMethod> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AgeVerificationMethod>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AgeVerificationMethod.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AgeVerificationMethod] to String,
/// and [decode] dynamic data back to [AgeVerificationMethod].
class AgeVerificationMethodTypeTransformer {
  factory AgeVerificationMethodTypeTransformer() => _instance ??= const AgeVerificationMethodTypeTransformer._();

  const AgeVerificationMethodTypeTransformer._();

  String encode(AgeVerificationMethod data) => data.value;

  /// Decodes a [dynamic value][data] to a AgeVerificationMethod.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AgeVerificationMethod? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Debug': return AgeVerificationMethod.debug;
        case r'Eudi': return AgeVerificationMethod.eudi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AgeVerificationMethodTypeTransformer] instance.
  static AgeVerificationMethodTypeTransformer? _instance;
}

