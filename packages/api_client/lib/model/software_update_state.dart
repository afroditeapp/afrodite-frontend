//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SoftwareUpdateState {
  /// Instantiate a new enum with the provided [value].
  const SoftwareUpdateState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const idle = SoftwareUpdateState._(r'Idle');
  static const downloading = SoftwareUpdateState._(r'Downloading');
  static const installing = SoftwareUpdateState._(r'Installing');

  /// List of all possible values in this [enum][SoftwareUpdateState].
  static const values = <SoftwareUpdateState>[
    idle,
    downloading,
    installing,
  ];

  static SoftwareUpdateState? fromJson(dynamic value) => SoftwareUpdateStateTypeTransformer().decode(value);

  static List<SoftwareUpdateState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SoftwareUpdateState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SoftwareUpdateState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SoftwareUpdateState] to String,
/// and [decode] dynamic data back to [SoftwareUpdateState].
class SoftwareUpdateStateTypeTransformer {
  factory SoftwareUpdateStateTypeTransformer() => _instance ??= const SoftwareUpdateStateTypeTransformer._();

  const SoftwareUpdateStateTypeTransformer._();

  String encode(SoftwareUpdateState data) => data.value;

  /// Decodes a [dynamic value][data] to a SoftwareUpdateState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SoftwareUpdateState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Idle': return SoftwareUpdateState.idle;
        case r'Downloading': return SoftwareUpdateState.downloading;
        case r'Installing': return SoftwareUpdateState.installing;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SoftwareUpdateStateTypeTransformer] instance.
  static SoftwareUpdateStateTypeTransformer? _instance;
}

