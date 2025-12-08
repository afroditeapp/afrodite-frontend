import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'send_chat_backup.freezed.dart';

enum SendBackupState { idle, connecting, creatingBackup, transferring, success }

@freezed
class SendBackupData with _$SendBackupData {
  factory SendBackupData({
    @Default(SendBackupState.idle) SendBackupState state,
    String? errorMessage,
  }) = _SendBackupData;
}
