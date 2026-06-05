//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class MediaContentModerationType {
  /// Instantiate a new enum with the provided [value].
  const MediaContentModerationType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const normal = MediaContentModerationType._(r'Normal');
  static const initial = MediaContentModerationType._(r'Initial');

  /// List of all possible values in this [enum][MediaContentModerationType].
  static const values = <MediaContentModerationType>[
    normal,
    initial,
  ];

  static MediaContentModerationType? fromJson(dynamic value) => MediaContentModerationTypeTypeTransformer().decode(value);

  static List<MediaContentModerationType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentModerationType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentModerationType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MediaContentModerationType] to String,
/// and [decode] dynamic data back to [MediaContentModerationType].
class MediaContentModerationTypeTypeTransformer {
  factory MediaContentModerationTypeTypeTransformer() => _instance ??= const MediaContentModerationTypeTypeTransformer._();

  const MediaContentModerationTypeTypeTransformer._();

  String encode(MediaContentModerationType data) => data.value;

  /// Decodes a [dynamic value][data] to a MediaContentModerationType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MediaContentModerationType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Normal': return MediaContentModerationType.normal;
        case r'Initial': return MediaContentModerationType.initial;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MediaContentModerationTypeTypeTransformer] instance.
  static MediaContentModerationTypeTypeTransformer? _instance;
}

