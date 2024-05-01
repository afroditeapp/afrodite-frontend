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
  UnmodifiableList<NotificationPayload> get toBeHandled => throw _privateConstructorErrorNotificationPayloadHandlerData;

  NotificationPayloadHandlerData copyWith({
    UnmodifiableList<NotificationPayload>? toBeHandled,
  }) => throw _privateConstructorErrorNotificationPayloadHandlerData;
}

/// @nodoc
abstract class _NotificationPayloadHandlerData implements NotificationPayloadHandlerData {
  factory _NotificationPayloadHandlerData({
    UnmodifiableList<NotificationPayload> toBeHandled,
  }) = _$NotificationPayloadHandlerDataImpl;
}

/// @nodoc
class _$NotificationPayloadHandlerDataImpl with DiagnosticableTreeMixin implements _NotificationPayloadHandlerData {
  static const UnmodifiableList<NotificationPayload> _toBeHandledDefaultValue = UnmodifiableList<NotificationPayload>.empty();
  
  _$NotificationPayloadHandlerDataImpl({
    this.toBeHandled = _toBeHandledDefaultValue,
  });

  @override
  final UnmodifiableList<NotificationPayload> toBeHandled;

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
    toBeHandled: (toBeHandled ?? this.toBeHandled) as UnmodifiableList<NotificationPayload>,
  );
}
