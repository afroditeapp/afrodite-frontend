
import "package:openapi/api.dart";
import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/logic/chat/conversation_bloc.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

part 'conversation_bloc.freezed.dart';

@freezed
class ConversationData with _$ConversationData {
  factory ConversationData({
    required AccountId accountId,
    @Default(true) bool isMatch,
    @Default(false) bool isBlocked,
    /// Resets chat box to empty state
    @Default(false) bool isSendSuccessful,
    @Default(ReadyVisibleMessageListUpdate(MessageList([]), null, false)) ReadyVisibleMessageListUpdate visibleMessages,
    MessageList? pendingMessages,
    MessageListUpdate? currentMessageListUpdate,
    @Default(UnmodifiableList<MessageListUpdate>.empty()) UnmodifiableList<MessageListUpdate> pendingMessageListUpdates,
  }) = _ConversationData;
}

/// Wrapper for messages to prevent printing to console
class MessageList {
  final List<MessageEntry> messages;
  const MessageList(this.messages);
}

class OnMessageListUpdate {
  final bool jumpToLatestMessage;
  final double? newMessageHeight;
  OnMessageListUpdate(this.jumpToLatestMessage, this.newMessageHeight);
}

class ReadyVisibleMessageListUpdate {
  final MessageList messages;
  final double? addedHeight;
  final bool jumpToLatestMessage;
  const ReadyVisibleMessageListUpdate(this.messages, this.addedHeight, this.jumpToLatestMessage);
}
