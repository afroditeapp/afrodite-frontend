//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountState {
  /// Instantiate a new enum with the provided [value].
  const AccountState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const initialSetup = AccountState._(r'InitialSetup');
  static const normal = AccountState._(r'Normal');
  static const banned = AccountState._(r'Banned');
  static const pendingDeletion = AccountState._(r'PendingDeletion');

  /// List of all possible values in this [enum][AccountState].
  static const values = <AccountState>[
    initialSetup,
    normal,
    banned,
    pendingDeletion,
  ];

  static AccountState? fromJson(dynamic value) => AccountStateTypeTransformer().decode(value);

  static List<AccountState>? listFromJson(dynamic json, {bool growable = false,}) {
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

  String encode(AccountState data) => data.value;

  /// Decodes a [dynamic value][data] to a AccountState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AccountState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'InitialSetup': return AccountState.initialSetup;
        case r'Normal': return AccountState.normal;
        case r'Banned': return AccountState.banned;
        case r'PendingDeletion': return AccountState.pendingDeletion;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AccountStateTypeTransformer] instance.
  static AccountStateTypeTransformer? _instance;
}

