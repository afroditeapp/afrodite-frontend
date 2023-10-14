//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Identifier for event.
class EventType {
  /// Instantiate a new enum with the provided [value].
  const EventType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const accountStateChanged = EventType._(r'AccountStateChanged');
  static const accountCapabilitiesChanged = EventType._(r'AccountCapabilitiesChanged');

  /// List of all possible values in this [enum][EventType].
  static const values = <EventType>[
    accountStateChanged,
    accountCapabilitiesChanged,
  ];

  static EventType? fromJson(dynamic value) => EventTypeTypeTransformer().decode(value);

  static List<EventType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EventType] to String,
/// and [decode] dynamic data back to [EventType].
class EventTypeTypeTransformer {
  factory EventTypeTypeTransformer() => _instance ??= const EventTypeTypeTransformer._();

  const EventTypeTypeTransformer._();

  String encode(EventType data) => data.value;

  /// Decodes a [dynamic value][data] to a EventType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EventType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'AccountStateChanged': return EventType.accountStateChanged;
        case r'AccountCapabilitiesChanged': return EventType.accountCapabilitiesChanged;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EventTypeTypeTransformer] instance.
  static EventTypeTypeTransformer? _instance;
}

