import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'receive_chat_backup.freezed.dart';

enum ReceiveBackupConnectionState { connecting, waitingForSource, transferring, importing, success }

@freezed
class ReceiveBackupData with _$ReceiveBackupData {
  factory ReceiveBackupData({
    @Default(ReceiveBackupConnectionState.connecting) ReceiveBackupConnectionState state,
    String? pairingCode,
    int? totalBytes,
    @Default(0) int transferredBytes,
    String? errorMessage,
  }) = _ReceiveBackupData;
}
