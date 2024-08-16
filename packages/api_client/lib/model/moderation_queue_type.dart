//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Subset of NextQueueNumberType containing only moderation queue types.
class ModerationQueueType {
  /// Instantiate a new enum with the provided [value].
  const ModerationQueueType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const mediaModeration = ModerationQueueType._(r'MediaModeration');
  static const initialMediaModeration = ModerationQueueType._(r'InitialMediaModeration');

  /// List of all possible values in this [enum][ModerationQueueType].
  static const values = <ModerationQueueType>[
    mediaModeration,
    initialMediaModeration,
  ];

  static ModerationQueueType? fromJson(dynamic value) => ModerationQueueTypeTypeTransformer().decode(value);

  static List<ModerationQueueType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModerationQueueType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModerationQueueType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ModerationQueueType] to String,
/// and [decode] dynamic data back to [ModerationQueueType].
class ModerationQueueTypeTypeTransformer {
  factory ModerationQueueTypeTypeTransformer() => _instance ??= const ModerationQueueTypeTypeTransformer._();

  const ModerationQueueTypeTypeTransformer._();

  String encode(ModerationQueueType data) => data.value;

  /// Decodes a [dynamic value][data] to a ModerationQueueType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ModerationQueueType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'MediaModeration': return ModerationQueueType.mediaModeration;
        case r'InitialMediaModeration': return ModerationQueueType.initialMediaModeration;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ModerationQueueTypeTypeTransformer] instance.
  static ModerationQueueTypeTypeTransformer? _instance;
}

