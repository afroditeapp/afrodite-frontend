//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum BackupTransferClientRole {
  target._(r'Target'),
  source_._(r'Source'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const BackupTransferClientRole._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BackupTransferClientRole] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BackupTransferClientRole? fromJson(dynamic value) => BackupTransferClientRoleTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BackupTransferClientRole]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BackupTransferClientRole> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BackupTransferClientRole>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BackupTransferClientRole.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BackupTransferClientRole] to String,
/// and [decode] dynamic data back to [BackupTransferClientRole].
class BackupTransferClientRoleTypeTransformer {
  factory BackupTransferClientRoleTypeTransformer() => _instance ??= const BackupTransferClientRoleTypeTransformer._();

  const BackupTransferClientRoleTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(BackupTransferClientRole data) => data._value;

  /// Returns the instance of [BackupTransferClientRole] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BackupTransferClientRole? decode(dynamic data, {bool allowNull = true}) {
    if (data is BackupTransferClientRole) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Target': return BackupTransferClientRole.target;
        case r'Source': return BackupTransferClientRole.source_;
        case r'unknown_default_open_api': return BackupTransferClientRole.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BackupTransferClientRoleTypeTransformer? _instance;
}

