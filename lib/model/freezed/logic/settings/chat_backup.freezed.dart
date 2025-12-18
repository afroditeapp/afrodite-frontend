// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_backup.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorChatBackupData = UnsupportedError(
    'Private constructor ChatBackupData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ChatBackupData {
  bool get isLoading => throw _privateConstructorErrorChatBackupData;
  bool get isError => throw _privateConstructorErrorChatBackupData;

  ChatBackupData copyWith({
    bool? isLoading,
    bool? isError,
  }) => throw _privateConstructorErrorChatBackupData;
}

/// @nodoc
abstract class _ChatBackupData extends ChatBackupData {
  factory _ChatBackupData({
    bool isLoading,
    bool isError,
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
  }) : super._();

  @override
  final bool isLoading;
  @override
  final bool isError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatBackupData(isLoading: $isLoading, isError: $isError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatBackupData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ChatBackupDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
  );

  @override
  ChatBackupData copyWith({
    Object? isLoading,
    Object? isError,
  }) => _$ChatBackupDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
  );
}
