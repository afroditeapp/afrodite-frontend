//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ContentSlot {
  content0._(r'Content0'),
  content1._(r'Content1'),
  content2._(r'Content2'),
  content3._(r'Content3'),
  content4._(r'Content4'),
  content5._(r'Content5'),
  content6._(r'Content6'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ContentSlot._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ContentSlot] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ContentSlot? fromJson(dynamic value) => ContentSlotTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ContentSlot]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ContentSlot> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentSlot>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentSlot.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ContentSlot] to String,
/// and [decode] dynamic data back to [ContentSlot].
class ContentSlotTypeTransformer {
  factory ContentSlotTypeTransformer() => _instance ??= const ContentSlotTypeTransformer._();

  const ContentSlotTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ContentSlot data) => data._value;

  /// Returns the instance of [ContentSlot] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentSlot? decode(dynamic data, {bool allowNull = true}) {
    if (data is ContentSlot) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Content0': return ContentSlot.content0;
        case r'Content1': return ContentSlot.content1;
        case r'Content2': return ContentSlot.content2;
        case r'Content3': return ContentSlot.content3;
        case r'Content4': return ContentSlot.content4;
        case r'Content5': return ContentSlot.content5;
        case r'Content6': return ContentSlot.content6;
        case r'unknown_default_open_api': return ContentSlot.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ContentSlotTypeTransformer? _instance;
}

