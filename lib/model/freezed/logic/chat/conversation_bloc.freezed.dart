// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_bloc.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorConversationData = UnsupportedError(
    'Private constructor ConversationData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ConversationData {
  AccountId get accountId => throw _privateConstructorErrorConversationData;
  bool get isMatch => throw _privateConstructorErrorConversationData;
  bool get isBlocked => throw _privateConstructorErrorConversationData;
  bool get isMessageSendingInProgress => throw _privateConstructorErrorConversationData;
  bool get isMessageRemovingInProgress => throw _privateConstructorErrorConversationData;
  bool get isMessageResendingInProgress => throw _privateConstructorErrorConversationData;
  bool get isRetryPublicKeyDownloadInProgress => throw _privateConstructorErrorConversationData;

  ConversationData copyWith({
    AccountId? accountId,
    bool? isMatch,
    bool? isBlocked,
    bool? isMessageSendingInProgress,
    bool? isMessageRemovingInProgress,
    bool? isMessageResendingInProgress,
    bool? isRetryPublicKeyDownloadInProgress,
  }) => throw _privateConstructorErrorConversationData;
}

/// @nodoc
abstract class _ConversationData extends ConversationData {
  factory _ConversationData({
    required AccountId accountId,
    bool isMatch,
    bool isBlocked,
    bool isMessageSendingInProgress,
    bool isMessageRemovingInProgress,
    bool isMessageResendingInProgress,
    bool isRetryPublicKeyDownloadInProgress,
  }) = _$ConversationDataImpl;
  const _ConversationData._() : super._();
}

/// @nodoc
class _$ConversationDataImpl extends _ConversationData with DiagnosticableTreeMixin {
  static const bool _isMatchDefaultValue = true;
  static const bool _isBlockedDefaultValue = false;
  static const bool _isMessageSendingInProgressDefaultValue = false;
  static const bool _isMessageRemovingInProgressDefaultValue = false;
  static const bool _isMessageResendingInProgressDefaultValue = false;
  static const bool _isRetryPublicKeyDownloadInProgressDefaultValue = false;

  _$ConversationDataImpl({
    required this.accountId,
    this.isMatch = _isMatchDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.isMessageSendingInProgress = _isMessageSendingInProgressDefaultValue,
    this.isMessageRemovingInProgress = _isMessageRemovingInProgressDefaultValue,
    this.isMessageResendingInProgress = _isMessageResendingInProgressDefaultValue,
    this.isRetryPublicKeyDownloadInProgress = _isRetryPublicKeyDownloadInProgressDefaultValue,
  }) : super._();

  @override
  final AccountId accountId;
  @override
  final bool isMatch;
  @override
  final bool isBlocked;
  @override
  final bool isMessageSendingInProgress;
  @override
  final bool isMessageRemovingInProgress;
  @override
  final bool isMessageResendingInProgress;
  @override
  final bool isRetryPublicKeyDownloadInProgress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationData(accountId: $accountId, isMatch: $isMatch, isBlocked: $isBlocked, isMessageSendingInProgress: $isMessageSendingInProgress, isMessageRemovingInProgress: $isMessageRemovingInProgress, isMessageResendingInProgress: $isMessageResendingInProgress, isRetryPublicKeyDownloadInProgress: $isRetryPublicKeyDownloadInProgress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConversationData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('isMatch', isMatch))
      ..add(DiagnosticsProperty('isBlocked', isBlocked))
      ..add(DiagnosticsProperty('isMessageSendingInProgress', isMessageSendingInProgress))
      ..add(DiagnosticsProperty('isMessageRemovingInProgress', isMessageRemovingInProgress))
      ..add(DiagnosticsProperty('isMessageResendingInProgress', isMessageResendingInProgress))
      ..add(DiagnosticsProperty('isRetryPublicKeyDownloadInProgress', isRetryPublicKeyDownloadInProgress));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ConversationDataImpl &&
        (identical(other.accountId, accountId) ||
          other.accountId == accountId) &&
        (identical(other.isMatch, isMatch) ||
          other.isMatch == isMatch) &&
        (identical(other.isBlocked, isBlocked) ||
          other.isBlocked == isBlocked) &&
        (identical(other.isMessageSendingInProgress, isMessageSendingInProgress) ||
          other.isMessageSendingInProgress == isMessageSendingInProgress) &&
        (identical(other.isMessageRemovingInProgress, isMessageRemovingInProgress) ||
          other.isMessageRemovingInProgress == isMessageRemovingInProgress) &&
        (identical(other.isMessageResendingInProgress, isMessageResendingInProgress) ||
          other.isMessageResendingInProgress == isMessageResendingInProgress) &&
        (identical(other.isRetryPublicKeyDownloadInProgress, isRetryPublicKeyDownloadInProgress) ||
          other.isRetryPublicKeyDownloadInProgress == isRetryPublicKeyDownloadInProgress)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    isMatch,
    isBlocked,
    isMessageSendingInProgress,
    isMessageRemovingInProgress,
    isMessageResendingInProgress,
    isRetryPublicKeyDownloadInProgress,
  );

  @override
  ConversationData copyWith({
    Object? accountId,
    Object? isMatch,
    Object? isBlocked,
    Object? isMessageSendingInProgress,
    Object? isMessageRemovingInProgress,
    Object? isMessageResendingInProgress,
    Object? isRetryPublicKeyDownloadInProgress,
  }) => _$ConversationDataImpl(
    accountId: (accountId ?? this.accountId) as AccountId,
    isMatch: (isMatch ?? this.isMatch) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    isMessageSendingInProgress: (isMessageSendingInProgress ?? this.isMessageSendingInProgress) as bool,
    isMessageRemovingInProgress: (isMessageRemovingInProgress ?? this.isMessageRemovingInProgress) as bool,
    isMessageResendingInProgress: (isMessageResendingInProgress ?? this.isMessageResendingInProgress) as bool,
    isRetryPublicKeyDownloadInProgress: (isRetryPublicKeyDownloadInProgress ?? this.isRetryPublicKeyDownloadInProgress) as bool,
  );
}
