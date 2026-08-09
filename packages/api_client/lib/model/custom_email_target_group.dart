//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum CustomEmailTargetGroup {
  allAccounts._(r'AllAccounts'),
  associationMembers._(r'AssociationMembers'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const CustomEmailTargetGroup._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CustomEmailTargetGroup] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CustomEmailTargetGroup? fromJson(dynamic value) => CustomEmailTargetGroupTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CustomEmailTargetGroup]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CustomEmailTargetGroup> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomEmailTargetGroup>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomEmailTargetGroup.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CustomEmailTargetGroup] to String,
/// and [decode] dynamic data back to [CustomEmailTargetGroup].
class CustomEmailTargetGroupTypeTransformer {
  factory CustomEmailTargetGroupTypeTransformer() => _instance ??= const CustomEmailTargetGroupTypeTransformer._();

  const CustomEmailTargetGroupTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(CustomEmailTargetGroup data) => data._value;

  /// Returns the instance of [CustomEmailTargetGroup] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomEmailTargetGroup? decode(dynamic data, {bool allowNull = true}) {
    if (data is CustomEmailTargetGroup) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'AllAccounts': return CustomEmailTargetGroup.allAccounts;
        case r'AssociationMembers': return CustomEmailTargetGroup.associationMembers;
        case r'unknown_default_open_api': return CustomEmailTargetGroup.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CustomEmailTargetGroupTypeTransformer? _instance;
}

