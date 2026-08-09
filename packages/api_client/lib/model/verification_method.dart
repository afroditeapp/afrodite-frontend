//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum VerificationMethod {
  debug._(r'Debug'),
  eudi._(r'Eudi'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const VerificationMethod._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VerificationMethod] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VerificationMethod? fromJson(dynamic value) => VerificationMethodTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VerificationMethod]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VerificationMethod> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerificationMethod>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerificationMethod.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VerificationMethod] to String,
/// and [decode] dynamic data back to [VerificationMethod].
class VerificationMethodTypeTransformer {
  factory VerificationMethodTypeTransformer() => _instance ??= const VerificationMethodTypeTransformer._();

  const VerificationMethodTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(VerificationMethod data) => data._value;

  /// Returns the instance of [VerificationMethod] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VerificationMethod? decode(dynamic data, {bool allowNull = true}) {
    if (data is VerificationMethod) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Debug': return VerificationMethod.debug;
        case r'Eudi': return VerificationMethod.eudi;
        case r'unknown_default_open_api': return VerificationMethod.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VerificationMethodTypeTransformer? _instance;
}

