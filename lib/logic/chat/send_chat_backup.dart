import "dart:async";
import "dart:convert";

import "package:app/database/database_manager.dart";
import "package:app/localizations.dart";
import "package:app/logic/chat/send_chat_backup/websocket.dart";
import "package:app/model/freezed/logic/chat/send_chat_backup.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:database/database.dart";
import "package:database_provider/database_provider.dart";
import "package:database_utils/database_utils.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:utils/utils.dart";

final _log = Logger("SendChatBackupBloc");

abstract class SendChatBackupEvent {}

class StartSendBackup extends SendChatBackupEvent {
  final String pairingCode;
  StartSendBackup(this.pairingCode);
}

class ResetToInitialState extends SendChatBackupEvent {}

class _WebSocketEvent extends SendChatBackupEvent {
  final SendChatBackupWebSocketEvent event;
  _WebSocketEvent(this.event);
}

class SendChatBackupBloc extends Bloc<SendChatBackupEvent, SendBackupData> with ActionRunner {
  StreamSubscription<SendChatBackupWebSocketEvent>? _webSocketSubscription;
  SendChatBackupWebSocket? _webSocket;

  SendChatBackupBloc() : super(SendBackupData()) {
    on<StartSendBackup>((event, emit) async {
      await runOnce(() async {
        await _connectToServer(emit, event.pairingCode);
      });
    });

    on<ResetToInitialState>((event, emit) async {
      await _cleanup();
      emit(SendBackupData());
    });

    on<_WebSocketEvent>((event, emit) async {
      switch (event.event) {
        case TargetDataReceived(:final targetData):
          // Target data received from server, start backup creation
          _log.info("Received target data: $targetData");
          await _createAndSendBackup(emit, targetData);
        case WebSocketConnectionClosed(:final closeCode):
          // Close code 1000 means normal closure (transfer completed successfully)
          if (closeCode == 1000) {
            emit(state.copyWith(state: const Success()));
          } else if (closeCode == 1008) {
            // Close code 1008 means policy violation (transfer budget exceeded)
            emit(state.copyWith(state: ErrorState(R.strings.chat_backup_transfer_budget_exceeded)));
          } else {
            emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
          }
          await _cleanup();
        case WebSocketConnectionError():
          emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
          await _cleanup();
      }
    });
  }

  Future<void> _connectToServer(Emitter<SendBackupData> emit, String pairingCode) async {
    await _cleanup();

    // Connect to transfer API
    emit(state.copyWith(state: const Connecting()));

    // Convert base64url pairing code to hex for server
    final String pairingCodeHex;
    try {
      final bytes = base64Url.decode(pairingCode);
      pairingCodeHex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    } catch (e) {
      _log.warning("Invalid pairing code format: $e");
      emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
      return;
    }

    _webSocket = SendChatBackupWebSocket();
    final connected = await _webSocket!.connect(pairingCodeHex);

    if (!connected) {
      emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
      return;
    }

    // Subscribe to WebSocket events
    _webSocketSubscription = _webSocket!.events.listen((event) {
      add(_WebSocketEvent(event));
    });
  }

  Future<void> _createAndSendBackup(Emitter<SendBackupData> emit, String targetData) async {
    try {
      // Parse target data to get account ID
      final targetJson = jsonDecode(targetData) as Map<String, dynamic>;
      final accountIdStr = targetJson['account_id'] as String;
      final accountId = AccountId(aid: accountIdStr);

      // Check if database exists before trying to open it
      final dbFile = AccountDbFile(accountId.aid);
      if (!await databaseExists(dbFile)) {
        _log.fine("Database does not exist for account ID: ${accountId.aid}");
        emit(state.copyWith(state: ErrorState(R.strings.chat_backup_database_not_found)));
        await _cleanup();
        return;
      }

      // Create backup
      emit(state.copyWith(state: const CreatingBackup()));

      // Manually open database for the account ID
      final databaseManager = DatabaseManager.getInstance();
      final accountDbManager = await databaseManager.getAccountDatabaseManager(accountId);

      // Create backup from the database
      final backupResult = await accountDbManager.accountData(
        (db) => db.backup.createBackup(accountId),
      );

      final ChatBackupData backupData;
      switch (backupResult) {
        case Ok(:final v):
          backupData = v;
        case Err():
          emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
          await _cleanup();
          return;
      }

      // Compress and serialize
      final backupFile = backupData.compress();
      final backupBytes = backupFile.toBytes();

      // Send data in chunks
      emit(state.copyWith(state: const Transferring()));
      await _webSocket!.sendData(backupBytes);
    } catch (e) {
      _log.error("Failed to create and send backup: $e");
      emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
      await _cleanup();
    }
  }

  Future<void> _cleanup() async {
    await _webSocketSubscription?.cancel();
    _webSocketSubscription = null;
    await _webSocket?.close();
    _webSocket = null;
  }

  @override
  Future<void> close() async {
    await _cleanup();
    await super.close();
  }
}
