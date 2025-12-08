// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_chat_backup.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorSendBackupData = UnsupportedError(
    'Private constructor SendBackupData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$SendBackupData {
  SendBackupState get state => throw _privateConstructorErrorSendBackupData;
  String? get errorMessage => throw _privateConstructorErrorSendBackupData;

  SendBackupData copyWith({
    SendBackupState? state,
    String? errorMessage,
  }) => throw _privateConstructorErrorSendBackupData;
}

/// @nodoc
abstract class _SendBackupData implements SendBackupData {
  factory _SendBackupData({
    SendBackupState state,
    String? errorMessage,
  }) = _$SendBackupDataImpl;
}

/// @nodoc
class _$SendBackupDataImpl with DiagnosticableTreeMixin implements _SendBackupData {
  static const SendBackupState _stateDefaultValue = SendBackupState.idle;
  
  _$SendBackupDataImpl({
    this.state = _stateDefaultValue,
    this.errorMessage,
  });

  @override
  final SendBackupState state;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SendBackupData(state: $state, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SendBackupData'))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$SendBackupDataImpl &&
        (identical(other.state, state) ||
          other.state == state) &&
        (identical(other.errorMessage, errorMessage) ||
          other.errorMessage == errorMessage)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    state,
    errorMessage,
  );

  @override
  SendBackupData copyWith({
    Object? state,
    Object? errorMessage = _detectDefaultValueInCopyWith,
  }) => _$SendBackupDataImpl(
    state: (state ?? this.state) as SendBackupState,
    errorMessage: (errorMessage == _detectDefaultValueInCopyWith ? this.errorMessage : errorMessage) as String?,
  );
}
