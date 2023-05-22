//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class EventToClient {
  /// Instantiate a new enum with the provided [value].
  const EventToClient._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accountStateChanged = EventToClient._(r'AccountStateChanged');

  /// List of all possible values in this [enum][EventToClient].
  static const values = <EventToClient>[
    accountStateChanged,
  ];

  static EventToClient? fromJson(dynamic value) => EventToClientTypeTransformer().decode(value);

  static List<EventToClient>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventToClient>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventToClient.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EventToClient] to String,
/// and [decode] dynamic data back to [EventToClient].
class EventToClientTypeTransformer {
  factory EventToClientTypeTransformer() => _instance ??= const EventToClientTypeTransformer._();

  const EventToClientTypeTransformer._();

  String encode(EventToClient data) => data.value;

  /// Decodes a [dynamic value][data] to a EventToClient.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EventToClient? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AccountStateChanged': return EventToClient.accountStateChanged;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EventToClientTypeTransformer] instance.
  static EventToClientTypeTransformer? _instance;
}

