//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class BackupTransferClientRole {
  /// Instantiate a new enum with the provided [value].
  const BackupTransferClientRole._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const target = BackupTransferClientRole._(r'Target');
  static const source_ = BackupTransferClientRole._(r'Source');

  /// List of all possible values in this [enum][BackupTransferClientRole].
  static const values = <BackupTransferClientRole>[
    target,
    source_,
  ];

  static BackupTransferClientRole? fromJson(dynamic value) => BackupTransferClientRoleTypeTransformer().decode(value);

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

  String encode(BackupTransferClientRole data) => data.value;

  /// Decodes a [dynamic value][data] to a BackupTransferClientRole.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BackupTransferClientRole? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Target': return BackupTransferClientRole.target;
        case r'Source': return BackupTransferClientRole.source_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [BackupTransferClientRoleTypeTransformer] instance.
  static BackupTransferClientRoleTypeTransformer? _instance;
}

