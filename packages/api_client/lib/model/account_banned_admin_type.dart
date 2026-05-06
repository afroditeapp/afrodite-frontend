//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountBannedAdminType {
  /// Instantiate a new enum with the provided [value].
  const AccountBannedAdminType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const human = AccountBannedAdminType._(r'Human');
  static const bot = AccountBannedAdminType._(r'Bot');

  /// List of all possible values in this [enum][AccountBannedAdminType].
  static const values = <AccountBannedAdminType>[
    human,
    bot,
  ];

  static AccountBannedAdminType? fromJson(dynamic value) => AccountBannedAdminTypeTypeTransformer().decode(value);

  static List<AccountBannedAdminType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountBannedAdminType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountBannedAdminType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AccountBannedAdminType] to String,
/// and [decode] dynamic data back to [AccountBannedAdminType].
class AccountBannedAdminTypeTypeTransformer {
  factory AccountBannedAdminTypeTypeTransformer() => _instance ??= const AccountBannedAdminTypeTypeTransformer._();

  const AccountBannedAdminTypeTypeTransformer._();

  String encode(AccountBannedAdminType data) => data.value;

  /// Decodes a [dynamic value][data] to a AccountBannedAdminType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountBannedAdminType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Human': return AccountBannedAdminType.human;
        case r'Bot': return AccountBannedAdminType.bot;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AccountBannedAdminTypeTypeTransformer] instance.
  static AccountBannedAdminTypeTypeTransformer? _instance;
}

