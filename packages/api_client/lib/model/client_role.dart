//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Client role in data transfer
class ClientRole {
  /// Instantiate a new enum with the provided [value].
  const ClientRole._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const target = ClientRole._(r'Target');
  static const source_ = ClientRole._(r'Source');

  /// List of all possible values in this [enum][ClientRole].
  static const values = <ClientRole>[
    target,
    source_,
  ];

  static ClientRole? fromJson(dynamic value) => ClientRoleTypeTransformer().decode(value);

  static List<ClientRole> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientRole>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientRole.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ClientRole] to String,
/// and [decode] dynamic data back to [ClientRole].
class ClientRoleTypeTransformer {
  factory ClientRoleTypeTransformer() => _instance ??= const ClientRoleTypeTransformer._();

  const ClientRoleTypeTransformer._();

  String encode(ClientRole data) => data.value;

  /// Decodes a [dynamic value][data] to a ClientRole.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ClientRole? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Target': return ClientRole.target;
        case r'Source': return ClientRole.source_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ClientRoleTypeTransformer] instance.
  static ClientRoleTypeTransformer? _instance;
}

