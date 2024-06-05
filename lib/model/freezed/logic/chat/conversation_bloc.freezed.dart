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
  bool get isSendSuccessful => throw _privateConstructorErrorConversationData;
  ReadyVisibleMessageListUpdate get visibleMessages => throw _privateConstructorErrorConversationData;
  MessageList? get pendingMessages => throw _privateConstructorErrorConversationData;
  MessageListUpdate? get currentMessageListUpdate => throw _privateConstructorErrorConversationData;
  UnmodifiableList<MessageListUpdate> get pendingMessageListUpdates => throw _privateConstructorErrorConversationData;

  ConversationData copyWith({
    AccountId? accountId,
    bool? isMatch,
    bool? isBlocked,
    bool? isSendSuccessful,
    ReadyVisibleMessageListUpdate? visibleMessages,
    MessageList? pendingMessages,
    MessageListUpdate? currentMessageListUpdate,
    UnmodifiableList<MessageListUpdate>? pendingMessageListUpdates,
  }) => throw _privateConstructorErrorConversationData;
}

/// @nodoc
abstract class _ConversationData implements ConversationData {
  factory _ConversationData({
    required AccountId accountId,
    bool isMatch,
    bool isBlocked,
    bool isSendSuccessful,
    ReadyVisibleMessageListUpdate visibleMessages,
    MessageList? pendingMessages,
    MessageListUpdate? currentMessageListUpdate,
    UnmodifiableList<MessageListUpdate> pendingMessageListUpdates,
  }) = _$ConversationDataImpl;
}

/// @nodoc
class _$ConversationDataImpl with DiagnosticableTreeMixin implements _ConversationData {
  static const bool _isMatchDefaultValue = true;
  static const bool _isBlockedDefaultValue = false;
  static const bool _isSendSuccessfulDefaultValue = false;
  static const ReadyVisibleMessageListUpdate _visibleMessagesDefaultValue = ReadyVisibleMessageListUpdate(MessageList([]), null, false);
  static const UnmodifiableList<MessageListUpdate> _pendingMessageListUpdatesDefaultValue = UnmodifiableList<MessageListUpdate>.empty();
  
  _$ConversationDataImpl({
    required this.accountId,
    this.isMatch = _isMatchDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.isSendSuccessful = _isSendSuccessfulDefaultValue,
    this.visibleMessages = _visibleMessagesDefaultValue,
    this.pendingMessages,
    this.currentMessageListUpdate,
    this.pendingMessageListUpdates = _pendingMessageListUpdatesDefaultValue,
  });

  @override
  final AccountId accountId;
  @override
  final bool isMatch;
  @override
  final bool isBlocked;
  @override
  final bool isSendSuccessful;
  @override
  final ReadyVisibleMessageListUpdate visibleMessages;
  @override
  final MessageList? pendingMessages;
  @override
  final MessageListUpdate? currentMessageListUpdate;
  @override
  final UnmodifiableList<MessageListUpdate> pendingMessageListUpdates;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationData(accountId: $accountId, isMatch: $isMatch, isBlocked: $isBlocked, isSendSuccessful: $isSendSuccessful, visibleMessages: $visibleMessages, pendingMessages: $pendingMessages, currentMessageListUpdate: $currentMessageListUpdate, pendingMessageListUpdates: $pendingMessageListUpdates)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConversationData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('isMatch', isMatch))
      ..add(DiagnosticsProperty('isBlocked', isBlocked))
      ..add(DiagnosticsProperty('isSendSuccessful', isSendSuccessful))
      ..add(DiagnosticsProperty('visibleMessages', visibleMessages))
      ..add(DiagnosticsProperty('pendingMessages', pendingMessages))
      ..add(DiagnosticsProperty('currentMessageListUpdate', currentMessageListUpdate))
      ..add(DiagnosticsProperty('pendingMessageListUpdates', pendingMessageListUpdates));
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
        (identical(other.isSendSuccessful, isSendSuccessful) ||
          other.isSendSuccessful == isSendSuccessful) &&
        (identical(other.visibleMessages, visibleMessages) ||
          other.visibleMessages == visibleMessages) &&
        (identical(other.pendingMessages, pendingMessages) ||
          other.pendingMessages == pendingMessages) &&
        (identical(other.currentMessageListUpdate, currentMessageListUpdate) ||
          other.currentMessageListUpdate == currentMessageListUpdate) &&
        (identical(other.pendingMessageListUpdates, pendingMessageListUpdates) ||
          other.pendingMessageListUpdates == pendingMessageListUpdates)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    isMatch,
    isBlocked,
    isSendSuccessful,
    visibleMessages,
    pendingMessages,
    currentMessageListUpdate,
    pendingMessageListUpdates,
  );

  @override
  ConversationData copyWith({
    Object? accountId,
    Object? isMatch,
    Object? isBlocked,
    Object? isSendSuccessful,
    Object? visibleMessages,
    Object? pendingMessages = _detectDefaultValueInCopyWith,
    Object? currentMessageListUpdate = _detectDefaultValueInCopyWith,
    Object? pendingMessageListUpdates,
  }) => _$ConversationDataImpl(
    accountId: (accountId ?? this.accountId) as AccountId,
    isMatch: (isMatch ?? this.isMatch) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    isSendSuccessful: (isSendSuccessful ?? this.isSendSuccessful) as bool,
    visibleMessages: (visibleMessages ?? this.visibleMessages) as ReadyVisibleMessageListUpdate,
    pendingMessages: (pendingMessages == _detectDefaultValueInCopyWith ? this.pendingMessages : pendingMessages) as MessageList?,
    currentMessageListUpdate: (currentMessageListUpdate == _detectDefaultValueInCopyWith ? this.currentMessageListUpdate : currentMessageListUpdate) as MessageListUpdate?,
    pendingMessageListUpdates: (pendingMessageListUpdates ?? this.pendingMessageListUpdates) as UnmodifiableList<MessageListUpdate>,
  );
}
