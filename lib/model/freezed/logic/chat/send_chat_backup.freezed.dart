// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_chat_backup.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorSendBackupData = UnsupportedError(
    'Private constructor SendBackupData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SendBackupData {
  SendBackupState get state => throw _privateConstructorErrorSendBackupData;

  SendBackupData copyWith({
    SendBackupState? state,
  }) => throw _privateConstructorErrorSendBackupData;
}

/// @nodoc
abstract class _SendBackupData implements SendBackupData {
  factory _SendBackupData({
    SendBackupState state,
  }) = _$SendBackupDataImpl;
}

/// @nodoc
class _$SendBackupDataImpl with DiagnosticableTreeMixin implements _SendBackupData {
  static const SendBackupState _stateDefaultValue = Idle();

  _$SendBackupDataImpl({
    this.state = _stateDefaultValue,
  });

  @override
  final SendBackupState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SendBackupData(state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SendBackupData'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SendBackupDataImpl &&
        (identical(other.state, state) ||
          other.state == state)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    state,
  );

  @override
  SendBackupData copyWith({
    Object? state,
  }) => _$SendBackupDataImpl(
    state: (state ?? this.state) as SendBackupState,
  );
}
