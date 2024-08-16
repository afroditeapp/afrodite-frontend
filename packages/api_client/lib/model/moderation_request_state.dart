//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ModerationRequestState {
  /// Instantiate a new enum with the provided [value].
  const ModerationRequestState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const waiting = ModerationRequestState._(r'Waiting');
  static const inProgress = ModerationRequestState._(r'InProgress');
  static const accepted = ModerationRequestState._(r'Accepted');
  static const rejected = ModerationRequestState._(r'Rejected');

  /// List of all possible values in this [enum][ModerationRequestState].
  static const values = <ModerationRequestState>[
    waiting,
    inProgress,
    accepted,
    rejected,
  ];

  static ModerationRequestState? fromJson(dynamic value) => ModerationRequestStateTypeTransformer().decode(value);

  static List<ModerationRequestState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModerationRequestState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModerationRequestState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ModerationRequestState] to String,
/// and [decode] dynamic data back to [ModerationRequestState].
class ModerationRequestStateTypeTransformer {
  factory ModerationRequestStateTypeTransformer() => _instance ??= const ModerationRequestStateTypeTransformer._();

  const ModerationRequestStateTypeTransformer._();

  String encode(ModerationRequestState data) => data.value;

  /// Decodes a [dynamic value][data] to a ModerationRequestState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ModerationRequestState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Waiting': return ModerationRequestState.waiting;
        case r'InProgress': return ModerationRequestState.inProgress;
        case r'Accepted': return ModerationRequestState.accepted;
        case r'Rejected': return ModerationRequestState.rejected;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ModerationRequestStateTypeTransformer] instance.
  static ModerationRequestStateTypeTransformer? _instance;
}

