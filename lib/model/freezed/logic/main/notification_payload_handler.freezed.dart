// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_payload_handler.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorNotificationPayloadHandlerData = UnsupportedError(
    'Private constructor NotificationPayloadHandlerData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$NotificationPayloadHandlerData {
  UnmodifiableList<ParsedPayload> get toBeHandled => throw _privateConstructorErrorNotificationPayloadHandlerData;

  NotificationPayloadHandlerData copyWith({
    UnmodifiableList<ParsedPayload>? toBeHandled,
  }) => throw _privateConstructorErrorNotificationPayloadHandlerData;
}

/// @nodoc
abstract class _NotificationPayloadHandlerData implements NotificationPayloadHandlerData {
  factory _NotificationPayloadHandlerData({
    UnmodifiableList<ParsedPayload> toBeHandled,
  }) = _$NotificationPayloadHandlerDataImpl;
}

/// @nodoc
class _$NotificationPayloadHandlerDataImpl with DiagnosticableTreeMixin implements _NotificationPayloadHandlerData {
  static const UnmodifiableList<ParsedPayload> _toBeHandledDefaultValue = UnmodifiableList<ParsedPayload>.empty();
  
  _$NotificationPayloadHandlerDataImpl({
    this.toBeHandled = _toBeHandledDefaultValue,
  });

  @override
  final UnmodifiableList<ParsedPayload> toBeHandled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationPayloadHandlerData(toBeHandled: $toBeHandled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationPayloadHandlerData'))
      ..add(DiagnosticsProperty('toBeHandled', toBeHandled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$NotificationPayloadHandlerDataImpl &&
        (identical(other.toBeHandled, toBeHandled) ||
          other.toBeHandled == toBeHandled)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    toBeHandled,
  );

  @override
  NotificationPayloadHandlerData copyWith({
    Object? toBeHandled,
  }) => _$NotificationPayloadHandlerDataImpl(
    toBeHandled: (toBeHandled ?? this.toBeHandled) as UnmodifiableList<ParsedPayload>,
  );
}
