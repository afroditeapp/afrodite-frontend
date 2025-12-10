import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'send_chat_backup.freezed.dart';

sealed class SendBackupState {
  const SendBackupState();
}

class Idle extends SendBackupState {
  const Idle();
}

class Connecting extends SendBackupState {
  const Connecting();
}

class CreatingBackup extends SendBackupState {
  const CreatingBackup();
}

class Transferring extends SendBackupState {
  const Transferring();
}

class Success extends SendBackupState {
  const Success();
}

class ErrorState extends SendBackupState {
  final String message;
  const ErrorState(this.message);
}

@freezed
class SendBackupData with _$SendBackupData {
  factory SendBackupData({@Default(Idle()) SendBackupState state}) = _SendBackupData;
}
