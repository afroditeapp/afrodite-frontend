// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_chat_backup.dart';

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
final _privateConstructorErrorReceiveBackupData = UnsupportedError(
    'Private constructor ReceiveBackupData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ReceiveBackupData {
  ReceiveBackupConnectionState get state => throw _privateConstructorErrorReceiveBackupData;
  String? get pairingCode => throw _privateConstructorErrorReceiveBackupData;
  int? get totalBytes => throw _privateConstructorErrorReceiveBackupData;
  int get transferredBytes => throw _privateConstructorErrorReceiveBackupData;
  String? get errorMessage => throw _privateConstructorErrorReceiveBackupData;

  ReceiveBackupData copyWith({
    ReceiveBackupConnectionState? state,
    String? pairingCode,
    int? totalBytes,
    int? transferredBytes,
    String? errorMessage,
  }) => throw _privateConstructorErrorReceiveBackupData;
}

/// @nodoc
abstract class _ReceiveBackupData implements ReceiveBackupData {
  factory _ReceiveBackupData({
    ReceiveBackupConnectionState state,
    String? pairingCode,
    int? totalBytes,
    int transferredBytes,
    String? errorMessage,
  }) = _$ReceiveBackupDataImpl;
}

/// @nodoc
class _$ReceiveBackupDataImpl with DiagnosticableTreeMixin implements _ReceiveBackupData {
  static const ReceiveBackupConnectionState _stateDefaultValue = ReceiveBackupConnectionState.connecting;
  static const int _transferredBytesDefaultValue = 0;
  
  _$ReceiveBackupDataImpl({
    this.state = _stateDefaultValue,
    this.pairingCode,
    this.totalBytes,
    this.transferredBytes = _transferredBytesDefaultValue,
    this.errorMessage,
  });

  @override
  final ReceiveBackupConnectionState state;
  @override
  final String? pairingCode;
  @override
  final int? totalBytes;
  @override
  final int transferredBytes;
  @override
  final String? errorMessage;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReceiveBackupData(state: $state, pairingCode: $pairingCode, totalBytes: $totalBytes, transferredBytes: $transferredBytes, errorMessage: $errorMessage)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReceiveBackupData'))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('pairingCode', pairingCode))
      ..add(DiagnosticsProperty('totalBytes', totalBytes))
      ..add(DiagnosticsProperty('transferredBytes', transferredBytes))
      ..add(DiagnosticsProperty('errorMessage', errorMessage));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ReceiveBackupDataImpl &&
        (identical(other.state, state) ||
          other.state == state) &&
        (identical(other.pairingCode, pairingCode) ||
          other.pairingCode == pairingCode) &&
        (identical(other.totalBytes, totalBytes) ||
          other.totalBytes == totalBytes) &&
        (identical(other.transferredBytes, transferredBytes) ||
          other.transferredBytes == transferredBytes) &&
        (identical(other.errorMessage, errorMessage) ||
          other.errorMessage == errorMessage)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    state,
    pairingCode,
    totalBytes,
    transferredBytes,
    errorMessage,
  );

  @override
  ReceiveBackupData copyWith({
    Object? state,
    Object? pairingCode = _detectDefaultValueInCopyWith,
    Object? totalBytes = _detectDefaultValueInCopyWith,
    Object? transferredBytes,
    Object? errorMessage = _detectDefaultValueInCopyWith,
  }) => _$ReceiveBackupDataImpl(
    state: (state ?? this.state) as ReceiveBackupConnectionState,
    pairingCode: (pairingCode == _detectDefaultValueInCopyWith ? this.pairingCode : pairingCode) as String?,
    totalBytes: (totalBytes == _detectDefaultValueInCopyWith ? this.totalBytes : totalBytes) as int?,
    transferredBytes: (transferredBytes ?? this.transferredBytes) as int,
    errorMessage: (errorMessage == _detectDefaultValueInCopyWith ? this.errorMessage : errorMessage) as String?,
  );
}
