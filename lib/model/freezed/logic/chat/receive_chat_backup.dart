import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'receive_chat_backup.freezed.dart';

sealed class ReceiveBackupConnectionState {
  const ReceiveBackupConnectionState();
}

class Connecting extends ReceiveBackupConnectionState {
  const Connecting();
}

class WaitingForSource extends ReceiveBackupConnectionState {
  const WaitingForSource();
}

class Transferring extends ReceiveBackupConnectionState {
  const Transferring();
}

class Importing extends ReceiveBackupConnectionState {
  const Importing();
}

class Success extends ReceiveBackupConnectionState {
  const Success();
}

class ErrorState extends ReceiveBackupConnectionState {
  final String message;
  const ErrorState(this.message);
}

@freezed
class ReceiveBackupData with _$ReceiveBackupData {
  factory ReceiveBackupData({
    @Default(Connecting()) ReceiveBackupConnectionState state,
    String? pairingCode,
    Uint8List? qrCodeData,
    int? totalBytes,
    @Default(0) int transferredBytes,
  }) = _ReceiveBackupData;
}
