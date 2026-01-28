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
  int? get reminderIntervalDays => throw _privateConstructorErrorChatBackupData;
  UtcDateTime? get lastBackupTime => throw _privateConstructorErrorChatBackupData;
  UtcDateTime? get lastDialogOpenedTime => throw _privateConstructorErrorChatBackupData;
  DialogTrigger? get dialogTrigger => throw _privateConstructorErrorChatBackupData;

  ChatBackupData copyWith({
    bool? isLoading,
    bool? isError,
    int? reminderIntervalDays,
    UtcDateTime? lastBackupTime,
    UtcDateTime? lastDialogOpenedTime,
    DialogTrigger? dialogTrigger,
  }) => throw _privateConstructorErrorChatBackupData;
}

/// @nodoc
abstract class _ChatBackupData extends ChatBackupData {
  factory _ChatBackupData({
    bool isLoading,
    bool isError,
    int? reminderIntervalDays,
    UtcDateTime? lastBackupTime,
    UtcDateTime? lastDialogOpenedTime,
    DialogTrigger? dialogTrigger,
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
    this.reminderIntervalDays,
    this.lastBackupTime,
    this.lastDialogOpenedTime,
    this.dialogTrigger,
  }) : super._();

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final int? reminderIntervalDays;
  @override
  final UtcDateTime? lastBackupTime;
  @override
  final UtcDateTime? lastDialogOpenedTime;
  @override
  final DialogTrigger? dialogTrigger;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatBackupData(isLoading: $isLoading, isError: $isError, reminderIntervalDays: $reminderIntervalDays, lastBackupTime: $lastBackupTime, lastDialogOpenedTime: $lastDialogOpenedTime, dialogTrigger: $dialogTrigger)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatBackupData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('reminderIntervalDays', reminderIntervalDays))
      ..add(DiagnosticsProperty('lastBackupTime', lastBackupTime))
      ..add(DiagnosticsProperty('lastDialogOpenedTime', lastDialogOpenedTime))
      ..add(DiagnosticsProperty('dialogTrigger', dialogTrigger));
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
        (identical(other.reminderIntervalDays, reminderIntervalDays) ||
          other.reminderIntervalDays == reminderIntervalDays) &&
        (identical(other.lastBackupTime, lastBackupTime) ||
          other.lastBackupTime == lastBackupTime) &&
        (identical(other.lastDialogOpenedTime, lastDialogOpenedTime) ||
          other.lastDialogOpenedTime == lastDialogOpenedTime) &&
        (identical(other.dialogTrigger, dialogTrigger) ||
          other.dialogTrigger == dialogTrigger)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    reminderIntervalDays,
    lastBackupTime,
    lastDialogOpenedTime,
    dialogTrigger,
  );

  @override
  ChatBackupData copyWith({
    Object? isLoading,
    Object? isError,
    Object? reminderIntervalDays = _detectDefaultValueInCopyWith,
    Object? lastBackupTime = _detectDefaultValueInCopyWith,
    Object? lastDialogOpenedTime = _detectDefaultValueInCopyWith,
    Object? dialogTrigger = _detectDefaultValueInCopyWith,
  }) => _$ChatBackupDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    reminderIntervalDays: (reminderIntervalDays == _detectDefaultValueInCopyWith ? this.reminderIntervalDays : reminderIntervalDays) as int?,
    lastBackupTime: (lastBackupTime == _detectDefaultValueInCopyWith ? this.lastBackupTime : lastBackupTime) as UtcDateTime?,
    lastDialogOpenedTime: (lastDialogOpenedTime == _detectDefaultValueInCopyWith ? this.lastDialogOpenedTime : lastDialogOpenedTime) as UtcDateTime?,
    dialogTrigger: (dialogTrigger == _detectDefaultValueInCopyWith ? this.dialogTrigger : dialogTrigger) as DialogTrigger?,
  );
}
