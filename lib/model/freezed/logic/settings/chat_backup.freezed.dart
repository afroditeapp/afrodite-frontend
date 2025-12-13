// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_backup.dart';

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
final _privateConstructorErrorChatBackupData = UnsupportedError(
    'Private constructor ChatBackupData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ChatBackupData {
  bool get isLoading => throw _privateConstructorErrorChatBackupData;
  bool get isError => throw _privateConstructorErrorChatBackupData;
  ChatBackupInfo? get backup => throw _privateConstructorErrorChatBackupData;

  ChatBackupData copyWith({
    bool? isLoading,
    bool? isError,
    ChatBackupInfo? backup,
  }) => throw _privateConstructorErrorChatBackupData;
}

/// @nodoc
abstract class _ChatBackupData extends ChatBackupData {
  factory _ChatBackupData({
    bool isLoading,
    bool isError,
    ChatBackupInfo? backup,
  }) = _$ChatBackupDataImpl;
  _ChatBackupData._() : super._();
}

/// @nodoc
class _$ChatBackupDataImpl extends _ChatBackupData with DiagnosticableTreeMixin {
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  
  _$ChatBackupDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.backup,
  }) : super._();

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final ChatBackupInfo? backup;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatBackupData(isLoading: $isLoading, isError: $isError, backup: $backup)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatBackupData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('backup', backup));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ChatBackupDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.backup, backup) ||
          other.backup == backup)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    backup,
  );

  @override
  ChatBackupData copyWith({
    Object? isLoading,
    Object? isError,
    Object? backup = _detectDefaultValueInCopyWith,
  }) => _$ChatBackupDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    backup: (backup == _detectDefaultValueInCopyWith ? this.backup : backup) as ChatBackupInfo?,
  );
}
