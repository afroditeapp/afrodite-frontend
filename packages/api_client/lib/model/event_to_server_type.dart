//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class EventToServerType {
  /// Instantiate a new enum with the provided [value].
  const EventToServerType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const typingStart = EventToServerType._(r'TypingStart');
  static const typingStop = EventToServerType._(r'TypingStop');
  static const checkOnlineStatus = EventToServerType._(r'CheckOnlineStatus');

  /// List of all possible values in this [enum][EventToServerType].
  static const values = <EventToServerType>[
    typingStart,
    typingStop,
    checkOnlineStatus,
  ];

  static EventToServerType? fromJson(dynamic value) => EventToServerTypeTypeTransformer().decode(value);

  static List<EventToServerType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EventToServerType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EventToServerType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [EventToServerType] to String,
/// and [decode] dynamic data back to [EventToServerType].
class EventToServerTypeTypeTransformer {
  factory EventToServerTypeTypeTransformer() => _instance ??= const EventToServerTypeTypeTransformer._();

  const EventToServerTypeTypeTransformer._();

  String encode(EventToServerType data) => data.value;

  /// Decodes a [dynamic value][data] to a EventToServerType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  EventToServerType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'TypingStart': return EventToServerType.typingStart;
        case r'TypingStop': return EventToServerType.typingStop;
        case r'CheckOnlineStatus': return EventToServerType.checkOnlineStatus;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [EventToServerTypeTypeTransformer] instance.
  static EventToServerTypeTypeTransformer? _instance;
}

