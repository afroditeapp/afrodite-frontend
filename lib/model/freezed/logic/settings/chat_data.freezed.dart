// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data.dart';

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
final _privateConstructorErrorChatDataData = UnsupportedError(
    'Private constructor ChatDataData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ChatDataData {
  bool get isLoading => throw _privateConstructorErrorChatDataData;
  bool get isError => throw _privateConstructorErrorChatDataData;
  ChatDataBackup? get backup => throw _privateConstructorErrorChatDataData;

  ChatDataData copyWith({
    bool? isLoading,
    bool? isError,
    ChatDataBackup? backup,
  }) => throw _privateConstructorErrorChatDataData;
}

/// @nodoc
abstract class _ChatDataData extends ChatDataData {
  factory _ChatDataData({
    bool isLoading,
    bool isError,
    ChatDataBackup? backup,
  }) = _$ChatDataDataImpl;
  _ChatDataData._() : super._();
}

/// @nodoc
class _$ChatDataDataImpl extends _ChatDataData with DiagnosticableTreeMixin {
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  
  _$ChatDataDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.backup,
  }) : super._();

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final ChatDataBackup? backup;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatDataData(isLoading: $isLoading, isError: $isError, backup: $backup)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatDataData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('backup', backup));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ChatDataDataImpl &&
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
  ChatDataData copyWith({
    Object? isLoading,
    Object? isError,
    Object? backup = _detectDefaultValueInCopyWith,
  }) => _$ChatDataDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    backup: (backup == _detectDefaultValueInCopyWith ? this.backup : backup) as ChatDataBackup?,
  );
}
