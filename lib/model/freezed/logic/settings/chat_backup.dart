import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'chat_backup.freezed.dart';

@freezed
class ChatBackupData with _$ChatBackupData {
  ChatBackupData._();
  factory ChatBackupData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    ChatBackupInfo? backup,
  }) = _ChatBackupData;
}

class ChatBackupInfo {
  final String fileName;
  final Uint8List data;
  ChatBackupInfo(this.fileName, this.data);
}
