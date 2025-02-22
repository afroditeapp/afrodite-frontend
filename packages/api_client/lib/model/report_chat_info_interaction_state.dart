//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReportChatInfoInteractionState {
  /// Instantiate a new enum with the provided [value].
  const ReportChatInfoInteractionState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const none = ReportChatInfoInteractionState._(r'None');
  static const creatorLiked = ReportChatInfoInteractionState._(r'CreatorLiked');
  static const targetLiked = ReportChatInfoInteractionState._(r'TargetLiked');
  static const match = ReportChatInfoInteractionState._(r'Match');

  /// List of all possible values in this [enum][ReportChatInfoInteractionState].
  static const values = <ReportChatInfoInteractionState>[
    none,
    creatorLiked,
    targetLiked,
    match,
  ];

  static ReportChatInfoInteractionState? fromJson(dynamic value) => ReportChatInfoInteractionStateTypeTransformer().decode(value);

  static List<ReportChatInfoInteractionState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportChatInfoInteractionState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportChatInfoInteractionState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReportChatInfoInteractionState] to String,
/// and [decode] dynamic data back to [ReportChatInfoInteractionState].
class ReportChatInfoInteractionStateTypeTransformer {
  factory ReportChatInfoInteractionStateTypeTransformer() => _instance ??= const ReportChatInfoInteractionStateTypeTransformer._();

  const ReportChatInfoInteractionStateTypeTransformer._();

  String encode(ReportChatInfoInteractionState data) => data.value;

  /// Decodes a [dynamic value][data] to a ReportChatInfoInteractionState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReportChatInfoInteractionState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'None': return ReportChatInfoInteractionState.none;
        case r'CreatorLiked': return ReportChatInfoInteractionState.creatorLiked;
        case r'TargetLiked': return ReportChatInfoInteractionState.targetLiked;
        case r'Match': return ReportChatInfoInteractionState.match;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ReportChatInfoInteractionStateTypeTransformer] instance.
  static ReportChatInfoInteractionStateTypeTransformer? _instance;
}

