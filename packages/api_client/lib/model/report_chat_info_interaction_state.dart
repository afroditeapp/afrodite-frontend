//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ReportChatInfoInteractionState {
  none._(r'None'),
  creatorLiked._(r'CreatorLiked'),
  targetLiked._(r'TargetLiked'),
  match._(r'Match'),
  ;

  /// Instantiate a new enum with the provided value.
  const ReportChatInfoInteractionState._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ReportChatInfoInteractionState] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ReportChatInfoInteractionState? fromJson(dynamic value) => ReportChatInfoInteractionStateTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ReportChatInfoInteractionState]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(ReportChatInfoInteractionState data) => data._value;

  /// Returns the instance of [ReportChatInfoInteractionState] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReportChatInfoInteractionState? decode(dynamic data, {bool allowNull = true}) {
    if (data is ReportChatInfoInteractionState) {
      return data;
    }
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

  /// The singleton instance of this transformer.
  static ReportChatInfoInteractionStateTypeTransformer? _instance;
}

