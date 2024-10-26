//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProfileStatisticsHistoryValueType {
  /// Instantiate a new enum with the provided [value].
  const ProfileStatisticsHistoryValueType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accounts = ProfileStatisticsHistoryValueType._(r'Accounts');
  static const public = ProfileStatisticsHistoryValueType._(r'Public');
  static const publicMan = ProfileStatisticsHistoryValueType._(r'PublicMan');
  static const publicWoman = ProfileStatisticsHistoryValueType._(r'PublicWoman');
  static const publicNonBinary = ProfileStatisticsHistoryValueType._(r'PublicNonBinary');
  static const ageChange = ProfileStatisticsHistoryValueType._(r'AgeChange');
  static const ageChangeMan = ProfileStatisticsHistoryValueType._(r'AgeChangeMan');
  static const ageChangeWoman = ProfileStatisticsHistoryValueType._(r'AgeChangeWoman');
  static const ageChangeNonBinary = ProfileStatisticsHistoryValueType._(r'AgeChangeNonBinary');

  /// List of all possible values in this [enum][ProfileStatisticsHistoryValueType].
  static const values = <ProfileStatisticsHistoryValueType>[
    accounts,
    public,
    publicMan,
    publicWoman,
    publicNonBinary,
    ageChange,
    ageChangeMan,
    ageChangeWoman,
    ageChangeNonBinary,
  ];

  static ProfileStatisticsHistoryValueType? fromJson(dynamic value) => ProfileStatisticsHistoryValueTypeTypeTransformer().decode(value);

  static List<ProfileStatisticsHistoryValueType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProfileStatisticsHistoryValueType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProfileStatisticsHistoryValueType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProfileStatisticsHistoryValueType] to String,
/// and [decode] dynamic data back to [ProfileStatisticsHistoryValueType].
class ProfileStatisticsHistoryValueTypeTypeTransformer {
  factory ProfileStatisticsHistoryValueTypeTypeTransformer() => _instance ??= const ProfileStatisticsHistoryValueTypeTypeTransformer._();

  const ProfileStatisticsHistoryValueTypeTypeTransformer._();

  String encode(ProfileStatisticsHistoryValueType data) => data.value;

  /// Decodes a [dynamic value][data] to a ProfileStatisticsHistoryValueType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStatisticsHistoryValueType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Accounts': return ProfileStatisticsHistoryValueType.accounts;
        case r'Public': return ProfileStatisticsHistoryValueType.public;
        case r'PublicMan': return ProfileStatisticsHistoryValueType.publicMan;
        case r'PublicWoman': return ProfileStatisticsHistoryValueType.publicWoman;
        case r'PublicNonBinary': return ProfileStatisticsHistoryValueType.publicNonBinary;
        case r'AgeChange': return ProfileStatisticsHistoryValueType.ageChange;
        case r'AgeChangeMan': return ProfileStatisticsHistoryValueType.ageChangeMan;
        case r'AgeChangeWoman': return ProfileStatisticsHistoryValueType.ageChangeWoman;
        case r'AgeChangeNonBinary': return ProfileStatisticsHistoryValueType.ageChangeNonBinary;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProfileStatisticsHistoryValueTypeTypeTransformer] instance.
  static ProfileStatisticsHistoryValueTypeTypeTransformer? _instance;
}

