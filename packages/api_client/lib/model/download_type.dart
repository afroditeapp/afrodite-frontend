//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DownloadType {
  /// Instantiate a new enum with the provided [value].
  const DownloadType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const info = DownloadType._(r'Info');
  static const encryptedBinary = DownloadType._(r'EncryptedBinary');

  /// List of all possible values in this [enum][DownloadType].
  static const values = <DownloadType>[
    info,
    encryptedBinary,
  ];

  static DownloadType? fromJson(dynamic value) => DownloadTypeTypeTransformer().decode(value);

  static List<DownloadType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DownloadType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DownloadType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DownloadType] to String,
/// and [decode] dynamic data back to [DownloadType].
class DownloadTypeTypeTransformer {
  factory DownloadTypeTypeTransformer() => _instance ??= const DownloadTypeTypeTransformer._();

  const DownloadTypeTypeTransformer._();

  String encode(DownloadType data) => data.value;

  /// Decodes a [dynamic value][data] to a DownloadType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DownloadType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Info': return DownloadType.info;
        case r'EncryptedBinary': return DownloadType.encryptedBinary;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [DownloadTypeTypeTransformer] instance.
  static DownloadTypeTypeTransformer? _instance;
}

