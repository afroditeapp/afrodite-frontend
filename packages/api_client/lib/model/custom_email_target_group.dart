//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CustomEmailTargetGroup {
  /// Instantiate a new enum with the provided [value].
  const CustomEmailTargetGroup._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const allAccounts = CustomEmailTargetGroup._(r'AllAccounts');
  static const associationMembers = CustomEmailTargetGroup._(r'AssociationMembers');

  /// List of all possible values in this [enum][CustomEmailTargetGroup].
  static const values = <CustomEmailTargetGroup>[
    allAccounts,
    associationMembers,
  ];

  static CustomEmailTargetGroup? fromJson(dynamic value) => CustomEmailTargetGroupTypeTransformer().decode(value);

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

  String encode(CustomEmailTargetGroup data) => data.value;

  /// Decodes a [dynamic value][data] to a CustomEmailTargetGroup.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CustomEmailTargetGroup? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AllAccounts': return CustomEmailTargetGroup.allAccounts;
        case r'AssociationMembers': return CustomEmailTargetGroup.associationMembers;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CustomEmailTargetGroupTypeTransformer] instance.
  static CustomEmailTargetGroupTypeTransformer? _instance;
}

