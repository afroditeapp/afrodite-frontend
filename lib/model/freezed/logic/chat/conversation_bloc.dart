import "package:openapi/api.dart";
import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'conversation_bloc.freezed.dart';

@freezed
class ConversationData with _$ConversationData {
  const ConversationData._();

  factory ConversationData({
    required AccountId accountId,
    @Default(true) bool isMatch,
    @Default(false) bool isBlocked,
    @Default(false) bool resetMessageInputField,
    @Default(false) bool isMessageSendingInProgress,
    @Default(false) bool isMessageRemovingInProgress,
    @Default(false) bool isMessageResendingInProgress,
    @Default(false) bool isRetryPublicKeyDownloadInProgress,
    ReadyVisibleMessageListUpdate? visibleMessages,

    // Message renderer
    EntryAndJumpInfo? rendererCurrentlyRendering,
  }) = _ConversationData;

  bool isActionsInProgress() {
    return isMessageSendingInProgress ||
        isMessageRemovingInProgress ||
        isMessageResendingInProgress ||
        isRetryPublicKeyDownloadInProgress;
  }
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
