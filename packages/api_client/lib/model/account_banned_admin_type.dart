//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum AccountBannedAdminType {
  human._(r'Human'),
  bot._(r'Bot'),
  server._(r'Server'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const AccountBannedAdminType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AccountBannedAdminType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AccountBannedAdminType? fromJson(dynamic value) => AccountBannedAdminTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AccountBannedAdminType]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(AccountBannedAdminType data) => data._value;

  /// Returns the instance of [AccountBannedAdminType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountBannedAdminType? decode(dynamic data, {bool allowNull = true}) {
    if (data is AccountBannedAdminType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Human': return AccountBannedAdminType.human;
        case r'Bot': return AccountBannedAdminType.bot;
        case r'Server': return AccountBannedAdminType.server;
        case r'unknown_default_open_api': return AccountBannedAdminType.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AccountBannedAdminTypeTypeTransformer? _instance;
}

