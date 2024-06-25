
import "package:openapi/api.dart";
import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'conversation_bloc.freezed.dart';

@freezed
class ConversationData with _$ConversationData {
  factory ConversationData({
    required AccountId accountId,
    @Default(true) bool isMatch,
    @Default(false) bool isBlocked,
    /// Resets chat box to empty state
    @Default(false) bool isSendSuccessful,
    ReadyVisibleMessageListUpdate? visibleMessages,

    // Message renderer
    EntryAndJumpInfo? rendererCurrentlyRendering,
  }) = _ConversationData;
}

/// Wrapper for messages to prevent printing to console
class MessageList {
  final List<MessageEntry> messages;
  const MessageList(this.messages);
}

class ReadyVisibleMessageListUpdate {
  final MessageList messages;
  final double? addedHeight;
  final bool jumpToLatestMessage;
  const ReadyVisibleMessageListUpdate(this.messages, this.addedHeight, this.jumpToLatestMessage);
}

class EntryAndJumpInfo {
  final MessageEntry entry;
  final bool jumpToLatestMessage;
  EntryAndJumpInfo(this.entry, this.jumpToLatestMessage);
}
