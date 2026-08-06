//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProfileStatisticsHistoryValueType {
  accounts._(r'Accounts'),
  public._(r'Public'),
  publicMan._(r'PublicMan'),
  publicWoman._(r'PublicWoman'),
  publicNonBinary._(r'PublicNonBinary'),
  ageChange._(r'AgeChange'),
  ageChangeMan._(r'AgeChangeMan'),
  ageChangeWoman._(r'AgeChangeWoman'),
  ageChangeNonBinary._(r'AgeChangeNonBinary'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProfileStatisticsHistoryValueType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProfileStatisticsHistoryValueType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProfileStatisticsHistoryValueType? fromJson(dynamic value) => ProfileStatisticsHistoryValueTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProfileStatisticsHistoryValueType]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProfileStatisticsHistoryValueType data) => data._value;

  /// Returns the instance of [ProfileStatisticsHistoryValueType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProfileStatisticsHistoryValueType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProfileStatisticsHistoryValueType) {
      return data;
    }
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

  /// The singleton instance of this transformer.
  static ProfileStatisticsHistoryValueTypeTypeTransformer? _instance;
}

