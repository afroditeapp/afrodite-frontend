import "package:openapi/api.dart";

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
    @Default(false) bool isMessageSendingInProgress,
    @Default(false) bool isMessageRemovingInProgress,
    @Default(false) bool isMessageResendingInProgress,
    @Default(false) bool isDeliveryFailedMessageResendingInProgress,
    @Default(false) bool isRetryPublicKeyDownloadInProgress,
  }) = _ConversationData;

  bool isActionsInProgress() {
    return isMessageSendingInProgress ||
        isMessageRemovingInProgress ||
        isMessageResendingInProgress ||
        isDeliveryFailedMessageResendingInProgress ||
        isRetryPublicKeyDownloadInProgress;
  }
}
