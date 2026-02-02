import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_enabled.freezed.dart';

sealed class ChatEnableError {
  const ChatEnableError();
}

class ChatEnableErrorTooManyKeys extends ChatEnableError {
  const ChatEnableErrorTooManyKeys();
}

class ChatEnableErrorOther extends ChatEnableError {
  const ChatEnableErrorOther();
}

@freezed
class ChatEnabledData with _$ChatEnabledData {
  const factory ChatEnabledData({
    @Default(true) bool chatEnabled,
    @Default(false) bool isEnabling,
    ChatEnableError? enableError,
    @Default(false) bool showPendingMessagesWarning,
  }) = _ChatEnabledData;
}
