//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class IconLocation {
  /// Instantiate a new enum with the provided [value].
  const IconLocation._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const material = IconLocation._(r'Material');

  /// List of all possible values in this [enum][IconLocation].
  static const values = <IconLocation>[
    material,
  ];

  static IconLocation? fromJson(dynamic value) => IconLocationTypeTransformer().decode(value);

  static List<IconLocation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <IconLocation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IconLocation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [IconLocation] to String,
/// and [decode] dynamic data back to [IconLocation].
class IconLocationTypeTransformer {
  factory IconLocationTypeTransformer() => _instance ??= const IconLocationTypeTransformer._();

  const IconLocationTypeTransformer._();

  String encode(IconLocation data) => data.value;

  /// Decodes a [dynamic value][data] to a IconLocation.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  IconLocation? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Material': return IconLocation.material;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [IconLocationTypeTransformer] instance.
  static IconLocationTypeTransformer? _instance;
}

