//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaContentUploadType {
  /// Instantiate a new enum with the provided [value].
  const MediaContentUploadType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const image = MediaContentUploadType._(r'Image');

  /// List of all possible values in this [enum][MediaContentUploadType].
  static const values = <MediaContentUploadType>[
    image,
  ];

  static MediaContentUploadType? fromJson(dynamic value) => MediaContentUploadTypeTypeTransformer().decode(value);

  static List<MediaContentUploadType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentUploadType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentUploadType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MediaContentUploadType] to String,
/// and [decode] dynamic data back to [MediaContentUploadType].
class MediaContentUploadTypeTypeTransformer {
  factory MediaContentUploadTypeTypeTransformer() => _instance ??= const MediaContentUploadTypeTypeTransformer._();

  const MediaContentUploadTypeTypeTransformer._();

  String encode(MediaContentUploadType data) => data.value;

  /// Decodes a [dynamic value][data] to a MediaContentUploadType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MediaContentUploadType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Image': return MediaContentUploadType.image;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MediaContentUploadTypeTypeTransformer] instance.
  static MediaContentUploadTypeTypeTransformer? _instance;
}

