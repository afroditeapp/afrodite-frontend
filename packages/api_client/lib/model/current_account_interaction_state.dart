//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum CurrentAccountInteractionState {
  empty._(r'Empty'),
  likeSent._(r'LikeSent'),
  likeReceived._(r'LikeReceived'),
  match._(r'Match'),
  blockSent._(r'BlockSent'),
  ;

  /// Instantiate a new enum with the provided value.
  const CurrentAccountInteractionState._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CurrentAccountInteractionState] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CurrentAccountInteractionState? fromJson(dynamic value) => CurrentAccountInteractionStateTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CurrentAccountInteractionState]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CurrentAccountInteractionState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CurrentAccountInteractionState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CurrentAccountInteractionState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CurrentAccountInteractionState] to String,
/// and [decode] dynamic data back to [CurrentAccountInteractionState].
class CurrentAccountInteractionStateTypeTransformer {
  factory CurrentAccountInteractionStateTypeTransformer() => _instance ??= const CurrentAccountInteractionStateTypeTransformer._();

  const CurrentAccountInteractionStateTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(CurrentAccountInteractionState data) => data._value;

  /// Returns the instance of [CurrentAccountInteractionState] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CurrentAccountInteractionState? decode(dynamic data, {bool allowNull = true}) {
    if (data is CurrentAccountInteractionState) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Empty': return CurrentAccountInteractionState.empty;
        case r'LikeSent': return CurrentAccountInteractionState.likeSent;
        case r'LikeReceived': return CurrentAccountInteractionState.likeReceived;
        case r'Match': return CurrentAccountInteractionState.match;
        case r'BlockSent': return CurrentAccountInteractionState.blockSent;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CurrentAccountInteractionStateTypeTransformer? _instance;
}

