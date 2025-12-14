import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_enabled.freezed.dart';

@freezed
class ChatEnabledData with _$ChatEnabledData {
  const factory ChatEnabledData({
    @Default(true) bool chatEnabled,
    @Default(false) bool isEnabling,
    @Default(false) bool enableError,
  }) = _ChatEnabledData;
}
