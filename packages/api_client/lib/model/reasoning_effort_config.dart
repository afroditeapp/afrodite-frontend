//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Reasoning effort for LLM models that support it.  Mirrors the OpenAI chat completion API values.
enum ReasoningEffortConfig {
  none._(r'none'),
  minimal._(r'minimal'),
  low._(r'low'),
  medium._(r'medium'),
  high._(r'high'),
  xhigh._(r'xhigh'),
  unknownDefaultOpenApi._(r'unknown_default_open_api'),
  ;

  /// Instantiate a new enum with the provided value.
  const ReasoningEffortConfig._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ReasoningEffortConfig] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ReasoningEffortConfig? fromJson(dynamic value) => ReasoningEffortConfigTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ReasoningEffortConfig]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ReasoningEffortConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReasoningEffortConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReasoningEffortConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReasoningEffortConfig] to String,
/// and [decode] dynamic data back to [ReasoningEffortConfig].
class ReasoningEffortConfigTypeTransformer {
  factory ReasoningEffortConfigTypeTransformer() => _instance ??= const ReasoningEffortConfigTypeTransformer._();

  const ReasoningEffortConfigTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ReasoningEffortConfig data) => data._value;

  /// Returns the instance of [ReasoningEffortConfig] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReasoningEffortConfig? decode(dynamic data, {bool allowNull = true}) {
    if (data is ReasoningEffortConfig) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'none': return ReasoningEffortConfig.none;
        case r'minimal': return ReasoningEffortConfig.minimal;
        case r'low': return ReasoningEffortConfig.low;
        case r'medium': return ReasoningEffortConfig.medium;
        case r'high': return ReasoningEffortConfig.high;
        case r'xhigh': return ReasoningEffortConfig.xhigh;
        case r'unknown_default_open_api': return ReasoningEffortConfig.unknownDefaultOpenApi;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ReasoningEffortConfigTypeTransformer? _instance;
}

