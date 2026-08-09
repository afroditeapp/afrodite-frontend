//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ContentProcessingStateType {
  inQueue._(r'InQueue'),
  processing._(r'Processing'),
  completed._(r'Completed'),
  failed._(r'Failed'),
  nsfwDetected._(r'NsfwDetected'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ContentProcessingStateType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ContentProcessingStateType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ContentProcessingStateType? fromJson(dynamic value) => ContentProcessingStateTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ContentProcessingStateType]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ContentProcessingStateType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentProcessingStateType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentProcessingStateType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ContentProcessingStateType] to String,
/// and [decode] dynamic data back to [ContentProcessingStateType].
class ContentProcessingStateTypeTypeTransformer {
  factory ContentProcessingStateTypeTypeTransformer() => _instance ??= const ContentProcessingStateTypeTypeTransformer._();

  const ContentProcessingStateTypeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ContentProcessingStateType data) => data._value;

  /// Returns the instance of [ContentProcessingStateType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentProcessingStateType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ContentProcessingStateType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'InQueue': return ContentProcessingStateType.inQueue;
        case r'Processing': return ContentProcessingStateType.processing;
        case r'Completed': return ContentProcessingStateType.completed;
        case r'Failed': return ContentProcessingStateType.failed;
        case r'NsfwDetected': return ContentProcessingStateType.nsfwDetected;
        case r'unknown_default_open_api': return ContentProcessingStateType.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ContentProcessingStateTypeTypeTransformer? _instance;
}

