//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SoftwareOptions {
  /// Instantiate a new enum with the provided [value].
  const SoftwareOptions._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const manager = SoftwareOptions._(r'Manager');
  static const backend = SoftwareOptions._(r'Backend');

  /// List of all possible values in this [enum][SoftwareOptions].
  static const values = <SoftwareOptions>[
    manager,
    backend,
  ];

  static SoftwareOptions? fromJson(dynamic value) => SoftwareOptionsTypeTransformer().decode(value);

  static List<SoftwareOptions>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SoftwareOptions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SoftwareOptions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SoftwareOptions] to String,
/// and [decode] dynamic data back to [SoftwareOptions].
class SoftwareOptionsTypeTransformer {
  factory SoftwareOptionsTypeTransformer() => _instance ??= const SoftwareOptionsTypeTransformer._();

  const SoftwareOptionsTypeTransformer._();

  String encode(SoftwareOptions data) => data.value;

  /// Decodes a [dynamic value][data] to a SoftwareOptions.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SoftwareOptions? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Manager': return SoftwareOptions.manager;
        case r'Backend': return SoftwareOptions.backend;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SoftwareOptionsTypeTransformer] instance.
  static SoftwareOptionsTypeTransformer? _instance;
}

