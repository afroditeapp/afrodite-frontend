
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
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
    @Default(0) int messageCount,
    ConversationChangeType? messageCountChangeInfo,
    @Default(MessageList([])) MessageList initialMessages,
  }) = _ConversationData;
}

/// Wrapper for messages to prevent printing to console
class MessageList {
  final List<MessageEntry> messages;
  const MessageList(this.messages);
}
