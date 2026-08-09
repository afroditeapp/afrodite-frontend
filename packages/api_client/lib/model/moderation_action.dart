//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ModerationAction {
  accept._(r'Accept'),
  reject._(r'Reject'),
  moveToHuman._(r'MoveToHuman'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ModerationAction._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ModerationAction] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ModerationAction? fromJson(dynamic value) => ModerationActionTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ModerationAction]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(ModerationAction data) => data._value;

  /// Returns the instance of [ModerationAction] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ModerationAction? decode(dynamic data, {bool allowNull = true}) {
    if (data is ModerationAction) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'Accept': return ModerationAction.accept;
        case r'Reject': return ModerationAction.reject;
        case r'MoveToHuman': return ModerationAction.moveToHuman;
        case r'unknown_default_open_api': return ModerationAction.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ModerationActionTypeTransformer? _instance;
}

