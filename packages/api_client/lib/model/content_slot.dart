//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ContentSlot {
  /// Instantiate a new enum with the provided [value].
  const ContentSlot._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const content0 = ContentSlot._(r'Content0');
  static const content1 = ContentSlot._(r'Content1');
  static const content2 = ContentSlot._(r'Content2');
  static const content3 = ContentSlot._(r'Content3');
  static const content4 = ContentSlot._(r'Content4');
  static const content5 = ContentSlot._(r'Content5');
  static const content6 = ContentSlot._(r'Content6');

  /// List of all possible values in this [enum][ContentSlot].
  static const values = <ContentSlot>[
    content0,
    content1,
    content2,
    content3,
    content4,
    content5,
    content6,
  ];

  static ContentSlot? fromJson(dynamic value) => ContentSlotTypeTransformer().decode(value);

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

  String encode(ContentSlot data) => data.value;

  /// Decodes a [dynamic value][data] to a ContentSlot.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentSlot? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Content0': return ContentSlot.content0;
        case r'Content1': return ContentSlot.content1;
        case r'Content2': return ContentSlot.content2;
        case r'Content3': return ContentSlot.content3;
        case r'Content4': return ContentSlot.content4;
        case r'Content5': return ContentSlot.content5;
        case r'Content6': return ContentSlot.content6;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ContentSlotTypeTransformer] instance.
  static ContentSlotTypeTransformer? _instance;
}

