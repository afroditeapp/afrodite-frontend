// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_bloc.dart';

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
final _privateConstructorErrorConversationData = UnsupportedError(
    'Private constructor ConversationData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ConversationData {
  AccountId get accountId => throw _privateConstructorErrorConversationData;
  bool get isMatch => throw _privateConstructorErrorConversationData;
  bool get isBlocked => throw _privateConstructorErrorConversationData;
  bool get resetMessageInputField => throw _privateConstructorErrorConversationData;
  bool get isMessageSendingInProgress => throw _privateConstructorErrorConversationData;
  bool get isMessageRemovingInProgress => throw _privateConstructorErrorConversationData;
  bool get isMessageResendingInProgress => throw _privateConstructorErrorConversationData;
  bool get isRetryPublicKeyDownloadInProgress => throw _privateConstructorErrorConversationData;
  ReadyVisibleMessageListUpdate? get visibleMessages => throw _privateConstructorErrorConversationData;
  EntryAndJumpInfo? get rendererCurrentlyRendering => throw _privateConstructorErrorConversationData;

  ConversationData copyWith({
    AccountId? accountId,
    bool? isMatch,
    bool? isBlocked,
    bool? resetMessageInputField,
    bool? isMessageSendingInProgress,
    bool? isMessageRemovingInProgress,
    bool? isMessageResendingInProgress,
    bool? isRetryPublicKeyDownloadInProgress,
    ReadyVisibleMessageListUpdate? visibleMessages,
    EntryAndJumpInfo? rendererCurrentlyRendering,
  }) => throw _privateConstructorErrorConversationData;
}

/// @nodoc
abstract class _ConversationData extends ConversationData {
  factory _ConversationData({
    required AccountId accountId,
    bool isMatch,
    bool isBlocked,
    bool resetMessageInputField,
    bool isMessageSendingInProgress,
    bool isMessageRemovingInProgress,
    bool isMessageResendingInProgress,
    bool isRetryPublicKeyDownloadInProgress,
    ReadyVisibleMessageListUpdate? visibleMessages,
    EntryAndJumpInfo? rendererCurrentlyRendering,
  }) = _$ConversationDataImpl;
  const _ConversationData._() : super._();
}

/// @nodoc
class _$ConversationDataImpl extends _ConversationData with DiagnosticableTreeMixin {
  static const bool _isMatchDefaultValue = true;
  static const bool _isBlockedDefaultValue = false;
  static const bool _resetMessageInputFieldDefaultValue = false;
  static const bool _isMessageSendingInProgressDefaultValue = false;
  static const bool _isMessageRemovingInProgressDefaultValue = false;
  static const bool _isMessageResendingInProgressDefaultValue = false;
  static const bool _isRetryPublicKeyDownloadInProgressDefaultValue = false;
  
  _$ConversationDataImpl({
    required this.accountId,
    this.isMatch = _isMatchDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.resetMessageInputField = _resetMessageInputFieldDefaultValue,
    this.isMessageSendingInProgress = _isMessageSendingInProgressDefaultValue,
    this.isMessageRemovingInProgress = _isMessageRemovingInProgressDefaultValue,
    this.isMessageResendingInProgress = _isMessageResendingInProgressDefaultValue,
    this.isRetryPublicKeyDownloadInProgress = _isRetryPublicKeyDownloadInProgressDefaultValue,
    this.visibleMessages,
    this.rendererCurrentlyRendering,
  }) : super._();

  @override
  final AccountId accountId;
  @override
  final bool isMatch;
  @override
  final bool isBlocked;
  @override
  final bool resetMessageInputField;
  @override
  final bool isMessageSendingInProgress;
  @override
  final bool isMessageRemovingInProgress;
  @override
  final bool isMessageResendingInProgress;
  @override
  final bool isRetryPublicKeyDownloadInProgress;
  @override
  final ReadyVisibleMessageListUpdate? visibleMessages;
  @override
  final EntryAndJumpInfo? rendererCurrentlyRendering;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationData(accountId: $accountId, isMatch: $isMatch, isBlocked: $isBlocked, resetMessageInputField: $resetMessageInputField, isMessageSendingInProgress: $isMessageSendingInProgress, isMessageRemovingInProgress: $isMessageRemovingInProgress, isMessageResendingInProgress: $isMessageResendingInProgress, isRetryPublicKeyDownloadInProgress: $isRetryPublicKeyDownloadInProgress, visibleMessages: $visibleMessages, rendererCurrentlyRendering: $rendererCurrentlyRendering)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConversationData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('isMatch', isMatch))
      ..add(DiagnosticsProperty('isBlocked', isBlocked))
      ..add(DiagnosticsProperty('resetMessageInputField', resetMessageInputField))
      ..add(DiagnosticsProperty('isMessageSendingInProgress', isMessageSendingInProgress))
      ..add(DiagnosticsProperty('isMessageRemovingInProgress', isMessageRemovingInProgress))
      ..add(DiagnosticsProperty('isMessageResendingInProgress', isMessageResendingInProgress))
      ..add(DiagnosticsProperty('isRetryPublicKeyDownloadInProgress', isRetryPublicKeyDownloadInProgress))
      ..add(DiagnosticsProperty('visibleMessages', visibleMessages))
      ..add(DiagnosticsProperty('rendererCurrentlyRendering', rendererCurrentlyRendering));
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
        (identical(other.resetMessageInputField, resetMessageInputField) ||
          other.resetMessageInputField == resetMessageInputField) &&
        (identical(other.isMessageSendingInProgress, isMessageSendingInProgress) ||
          other.isMessageSendingInProgress == isMessageSendingInProgress) &&
        (identical(other.isMessageRemovingInProgress, isMessageRemovingInProgress) ||
          other.isMessageRemovingInProgress == isMessageRemovingInProgress) &&
        (identical(other.isMessageResendingInProgress, isMessageResendingInProgress) ||
          other.isMessageResendingInProgress == isMessageResendingInProgress) &&
        (identical(other.isRetryPublicKeyDownloadInProgress, isRetryPublicKeyDownloadInProgress) ||
          other.isRetryPublicKeyDownloadInProgress == isRetryPublicKeyDownloadInProgress) &&
        (identical(other.visibleMessages, visibleMessages) ||
          other.visibleMessages == visibleMessages) &&
        (identical(other.rendererCurrentlyRendering, rendererCurrentlyRendering) ||
          other.rendererCurrentlyRendering == rendererCurrentlyRendering)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    isMatch,
    isBlocked,
    resetMessageInputField,
    isMessageSendingInProgress,
    isMessageRemovingInProgress,
    isMessageResendingInProgress,
    isRetryPublicKeyDownloadInProgress,
    visibleMessages,
    rendererCurrentlyRendering,
  );

  @override
  ConversationData copyWith({
    Object? accountId,
    Object? isMatch,
    Object? isBlocked,
    Object? resetMessageInputField,
    Object? isMessageSendingInProgress,
    Object? isMessageRemovingInProgress,
    Object? isMessageResendingInProgress,
    Object? isRetryPublicKeyDownloadInProgress,
    Object? visibleMessages = _detectDefaultValueInCopyWith,
    Object? rendererCurrentlyRendering = _detectDefaultValueInCopyWith,
  }) => _$ConversationDataImpl(
    accountId: (accountId ?? this.accountId) as AccountId,
    isMatch: (isMatch ?? this.isMatch) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    resetMessageInputField: (resetMessageInputField ?? this.resetMessageInputField) as bool,
    isMessageSendingInProgress: (isMessageSendingInProgress ?? this.isMessageSendingInProgress) as bool,
    isMessageRemovingInProgress: (isMessageRemovingInProgress ?? this.isMessageRemovingInProgress) as bool,
    isMessageResendingInProgress: (isMessageResendingInProgress ?? this.isMessageResendingInProgress) as bool,
    isRetryPublicKeyDownloadInProgress: (isRetryPublicKeyDownloadInProgress ?? this.isRetryPublicKeyDownloadInProgress) as bool,
    visibleMessages: (visibleMessages == _detectDefaultValueInCopyWith ? this.visibleMessages : visibleMessages) as ReadyVisibleMessageListUpdate?,
    rendererCurrentlyRendering: (rendererCurrentlyRendering == _detectDefaultValueInCopyWith ? this.rendererCurrentlyRendering : rendererCurrentlyRendering) as EntryAndJumpInfo?,
  );
}
