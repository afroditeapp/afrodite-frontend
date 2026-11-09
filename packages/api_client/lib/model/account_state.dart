//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum AccountState {
  initialSetup._(r'InitialSetup'),
  normal._(r'Normal'),
  banned._(r'Banned'),
  pendingDeletion._(r'PendingDeletion'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const AccountState._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AccountState] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AccountState? fromJson(dynamic value) => AccountStateTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AccountState]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AccountState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AccountState] to String,
/// and [decode] dynamic data back to [AccountState].
class AccountStateTypeTransformer {
  factory AccountStateTypeTransformer() => _instance ??= const AccountStateTypeTransformer._();

  const AccountStateTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(AccountState data) => data._value;

  /// Returns the instance of [AccountState] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountState? decode(dynamic data, {bool allowNull = true}) {
    if (data is AccountState) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'InitialSetup': return AccountState.initialSetup;
        case r'Normal': return AccountState.normal;
        case r'Banned': return AccountState.banned;
        case r'PendingDeletion': return AccountState.pendingDeletion;
        case r'unknown_default_open_api': return AccountState.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AccountStateTypeTransformer? _instance;
}

