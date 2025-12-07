import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'chat_data.freezed.dart';

@freezed
class ChatDataData with _$ChatDataData {
  ChatDataData._();
  factory ChatDataData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    ChatDataBackup? backup,
  }) = _ChatDataData;
}

class ChatDataBackup {
  final String fileName;
  final Uint8List data;
  ChatDataBackup(this.fileName, this.data);
}
