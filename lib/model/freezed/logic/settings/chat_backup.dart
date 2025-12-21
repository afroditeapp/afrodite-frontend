import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:utils/utils.dart';

part 'chat_backup.freezed.dart';

sealed class DialogTrigger {
  const DialogTrigger();
}

class NoPreviousBackup extends DialogTrigger {
  const NoPreviousBackup();
}

class OldBackup extends DialogTrigger {
  final int daysSinceBackup;
  const OldBackup(this.daysSinceBackup);
}

@freezed
class ChatBackupData with _$ChatBackupData {
  ChatBackupData._();
  factory ChatBackupData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    int? reminderIntervalDays,
    UtcDateTime? lastBackupTime,
    UtcDateTime? lastDialogOpenedTime,
    DialogTrigger? dialogTrigger,
  }) = _ChatBackupData;

  int valueReminderIntervalDays() => reminderIntervalDays ?? 60;
}
