//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CurrentAccountInteractionState {
  /// Instantiate a new enum with the provided [value].
  const CurrentAccountInteractionState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const empty = CurrentAccountInteractionState._(r'Empty');
  static const likeSent = CurrentAccountInteractionState._(r'LikeSent');
  static const likeReceived = CurrentAccountInteractionState._(r'LikeReceived');
  static const match = CurrentAccountInteractionState._(r'Match');
  static const blockSent = CurrentAccountInteractionState._(r'BlockSent');

  /// List of all possible values in this [enum][CurrentAccountInteractionState].
  static const values = <CurrentAccountInteractionState>[
    empty,
    likeSent,
    likeReceived,
    match,
    blockSent,
  ];

  static CurrentAccountInteractionState? fromJson(dynamic value) => CurrentAccountInteractionStateTypeTransformer().decode(value);

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

  String encode(CurrentAccountInteractionState data) => data.value;

  /// Decodes a [dynamic value][data] to a CurrentAccountInteractionState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CurrentAccountInteractionState? decode(dynamic data, {bool allowNull = true}) {
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

  /// Singleton [CurrentAccountInteractionStateTypeTransformer] instance.
  static CurrentAccountInteractionStateTypeTransformer? _instance;
}

