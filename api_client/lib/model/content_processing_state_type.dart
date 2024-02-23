//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ContentProcessingStateType {
  /// Instantiate a new enum with the provided [value].
  const ContentProcessingStateType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const empty = ContentProcessingStateType._(r'Empty');
  static const inQueue = ContentProcessingStateType._(r'InQueue');
  static const processing = ContentProcessingStateType._(r'Processing');
  static const completed = ContentProcessingStateType._(r'Completed');
  static const failed = ContentProcessingStateType._(r'Failed');

  /// List of all possible values in this [enum][ContentProcessingStateType].
  static const values = <ContentProcessingStateType>[
    empty,
    inQueue,
    processing,
    completed,
    failed,
  ];

  static ContentProcessingStateType? fromJson(dynamic value) => ContentProcessingStateTypeTypeTransformer().decode(value);

  static List<ContentProcessingStateType>? listFromJson(dynamic json, {bool growable = false,}) {
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

  String encode(ContentProcessingStateType data) => data.value;

  /// Decodes a [dynamic value][data] to a ContentProcessingStateType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentProcessingStateType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Empty': return ContentProcessingStateType.empty;
        case r'InQueue': return ContentProcessingStateType.inQueue;
        case r'Processing': return ContentProcessingStateType.processing;
        case r'Completed': return ContentProcessingStateType.completed;
        case r'Failed': return ContentProcessingStateType.failed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ContentProcessingStateTypeTypeTransformer] instance.
  static ContentProcessingStateTypeTypeTransformer? _instance;
}

