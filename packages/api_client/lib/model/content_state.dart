//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ContentState {
  /// Instantiate a new enum with the provided [value].
  const ContentState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const inSlot = ContentState._(r'InSlot');
  static const inModeration = ContentState._(r'InModeration');
  static const moderatedAsAccepted = ContentState._(r'ModeratedAsAccepted');
  static const moderatedAsRejected = ContentState._(r'ModeratedAsRejected');

  /// List of all possible values in this [enum][ContentState].
  static const values = <ContentState>[
    inSlot,
    inModeration,
    moderatedAsAccepted,
    moderatedAsRejected,
  ];

  static ContentState? fromJson(dynamic value) => ContentStateTypeTransformer().decode(value);

  static List<ContentState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ContentState] to String,
/// and [decode] dynamic data back to [ContentState].
class ContentStateTypeTransformer {
  factory ContentStateTypeTransformer() => _instance ??= const ContentStateTypeTransformer._();

  const ContentStateTypeTransformer._();

  String encode(ContentState data) => data.value;

  /// Decodes a [dynamic value][data] to a ContentState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ContentState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'InSlot': return ContentState.inSlot;
        case r'InModeration': return ContentState.inModeration;
        case r'ModeratedAsAccepted': return ContentState.moderatedAsAccepted;
        case r'ModeratedAsRejected': return ContentState.moderatedAsRejected;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ContentStateTypeTransformer] instance.
  static ContentStateTypeTransformer? _instance;
}

