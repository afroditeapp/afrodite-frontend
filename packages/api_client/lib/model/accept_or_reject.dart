//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum AcceptOrReject {
  accept._(r'Accept'),
  reject._(r'Reject'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const AcceptOrReject._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AcceptOrReject] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AcceptOrReject? fromJson(dynamic value) => AcceptOrRejectTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AcceptOrReject]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AcceptOrReject> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AcceptOrReject>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AcceptOrReject.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AcceptOrReject] to String,
/// and [decode] dynamic data back to [AcceptOrReject].
class AcceptOrRejectTypeTransformer {
  factory AcceptOrRejectTypeTransformer() => _instance ??= const AcceptOrRejectTypeTransformer._();

  const AcceptOrRejectTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(AcceptOrReject data) => data._value;

  /// Returns the instance of [AcceptOrReject] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AcceptOrReject? decode(dynamic data, {bool allowNull = true}) {
    if (data is AcceptOrReject) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Accept': return AcceptOrReject.accept;
        case r'Reject': return AcceptOrReject.reject;
        case r'unknown_default_open_api': return AcceptOrReject.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AcceptOrRejectTypeTransformer? _instance;
}

