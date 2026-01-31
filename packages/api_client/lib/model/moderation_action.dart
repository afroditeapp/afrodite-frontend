//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ModerationAction {
  /// Instantiate a new enum with the provided [value].
  const ModerationAction._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accept = ModerationAction._(r'Accept');
  static const reject = ModerationAction._(r'Reject');
  static const moveToHuman = ModerationAction._(r'MoveToHuman');

  /// List of all possible values in this [enum][ModerationAction].
  static const values = <ModerationAction>[
    accept,
    reject,
    moveToHuman,
  ];

  static ModerationAction? fromJson(dynamic value) => ModerationActionTypeTransformer().decode(value);

  static List<ModerationAction> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModerationAction>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModerationAction.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ModerationAction] to String,
/// and [decode] dynamic data back to [ModerationAction].
class ModerationActionTypeTransformer {
  factory ModerationActionTypeTransformer() => _instance ??= const ModerationActionTypeTransformer._();

  const ModerationActionTypeTransformer._();

  String encode(ModerationAction data) => data.value;

  /// Decodes a [dynamic value][data] to a ModerationAction.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ModerationAction? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Accept': return ModerationAction.accept;
        case r'Reject': return ModerationAction.reject;
        case r'MoveToHuman': return ModerationAction.moveToHuman;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ModerationActionTypeTransformer] instance.
  static ModerationActionTypeTransformer? _instance;
}

