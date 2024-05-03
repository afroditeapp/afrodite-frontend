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
  int get messageCount => throw _privateConstructorErrorConversationData;
  ConversationChangeType? get messageCountChangeInfo => throw _privateConstructorErrorConversationData;
  MessageList get initialMessages => throw _privateConstructorErrorConversationData;

  ConversationData copyWith({
    AccountId? accountId,
    bool? isMatch,
    bool? isBlocked,
    bool? isSendSuccessful,
    int? messageCount,
    ConversationChangeType? messageCountChangeInfo,
    MessageList? initialMessages,
  }) => throw _privateConstructorErrorConversationData;
}

/// @nodoc
abstract class _ConversationData implements ConversationData {
  factory _ConversationData({
    required AccountId accountId,
    bool isMatch,
    bool isBlocked,
    bool isSendSuccessful,
    int messageCount,
    ConversationChangeType? messageCountChangeInfo,
    MessageList initialMessages,
  }) = _$ConversationDataImpl;
}

/// @nodoc
class _$ConversationDataImpl with DiagnosticableTreeMixin implements _ConversationData {
  static const bool _isMatchDefaultValue = true;
  static const bool _isBlockedDefaultValue = false;
  static const bool _isSendSuccessfulDefaultValue = false;
  static const int _messageCountDefaultValue = 0;
  static const MessageList _initialMessagesDefaultValue = MessageList([]);
  
  _$ConversationDataImpl({
    required this.accountId,
    this.isMatch = _isMatchDefaultValue,
    this.isBlocked = _isBlockedDefaultValue,
    this.isSendSuccessful = _isSendSuccessfulDefaultValue,
    this.messageCount = _messageCountDefaultValue,
    this.messageCountChangeInfo,
    this.initialMessages = _initialMessagesDefaultValue,
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
  final int messageCount;
  @override
  final ConversationChangeType? messageCountChangeInfo;
  @override
  final MessageList initialMessages;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationData(accountId: $accountId, isMatch: $isMatch, isBlocked: $isBlocked, isSendSuccessful: $isSendSuccessful, messageCount: $messageCount, messageCountChangeInfo: $messageCountChangeInfo, initialMessages: $initialMessages)';
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
      ..add(DiagnosticsProperty('messageCount', messageCount))
      ..add(DiagnosticsProperty('messageCountChangeInfo', messageCountChangeInfo))
      ..add(DiagnosticsProperty('initialMessages', initialMessages));
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
        (identical(other.messageCount, messageCount) ||
          other.messageCount == messageCount) &&
        (identical(other.messageCountChangeInfo, messageCountChangeInfo) ||
          other.messageCountChangeInfo == messageCountChangeInfo) &&
        (identical(other.initialMessages, initialMessages) ||
          other.initialMessages == initialMessages)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    isMatch,
    isBlocked,
    isSendSuccessful,
    messageCount,
    messageCountChangeInfo,
    initialMessages,
  );

  @override
  ConversationData copyWith({
    Object? accountId,
    Object? isMatch,
    Object? isBlocked,
    Object? isSendSuccessful,
    Object? messageCount,
    Object? messageCountChangeInfo = _detectDefaultValueInCopyWith,
    Object? initialMessages,
  }) => _$ConversationDataImpl(
    accountId: (accountId ?? this.accountId) as AccountId,
    isMatch: (isMatch ?? this.isMatch) as bool,
    isBlocked: (isBlocked ?? this.isBlocked) as bool,
    isSendSuccessful: (isSendSuccessful ?? this.isSendSuccessful) as bool,
    messageCount: (messageCount ?? this.messageCount) as int,
    messageCountChangeInfo: (messageCountChangeInfo == _detectDefaultValueInCopyWith ? this.messageCountChangeInfo : messageCountChangeInfo) as ConversationChangeType?,
    initialMessages: (initialMessages ?? this.initialMessages) as MessageList,
  );
}
