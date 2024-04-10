//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaContentType {
  /// Instantiate a new enum with the provided [value].
  const MediaContentType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const jpegImage = MediaContentType._(r'JpegImage');

  /// List of all possible values in this [enum][MediaContentType].
  static const values = <MediaContentType>[
    jpegImage,
  ];

  static MediaContentType? fromJson(dynamic value) => MediaContentTypeTypeTransformer().decode(value);

  static List<MediaContentType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MediaContentType] to String,
/// and [decode] dynamic data back to [MediaContentType].
class MediaContentTypeTypeTransformer {
  factory MediaContentTypeTypeTransformer() => _instance ??= const MediaContentTypeTypeTransformer._();

  const MediaContentTypeTypeTransformer._();

  String encode(MediaContentType data) => data.value;

  /// Decodes a [dynamic value][data] to a MediaContentType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MediaContentType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'JpegImage': return MediaContentType.jpegImage;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MediaContentTypeTypeTransformer] instance.
  static MediaContentTypeTypeTransformer? _instance;
}

