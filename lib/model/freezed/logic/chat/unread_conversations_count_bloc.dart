import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'unread_conversations_count_bloc.freezed.dart';

@freezed
class UnreadConversationsCountData with _$UnreadConversationsCountData {
  const UnreadConversationsCountData._();

  factory UnreadConversationsCountData({
    @Default(0) int unreadConversations,
  }) = _UnreadConversationsCountData;
}
