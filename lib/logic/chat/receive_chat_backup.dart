import "dart:async";
import "dart:typed_data";

import "package:app/data/chat/message_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/logic/chat/receive_chat_backup/websocket.dart";
import "package:app/model/freezed/logic/chat/receive_chat_backup.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";

final _log = Logger("ReceiveChatBackupBloc");

abstract class ReceiveChatBackupEvent {}

class ConnectIfIdleOrConnecting extends ReceiveChatBackupEvent {}

class DisconnectIfIdle extends ReceiveChatBackupEvent {}

class _WebSocketEvent extends ReceiveChatBackupEvent {
  final ReceiveChatBackupWebSocketEvent event;
  _WebSocketEvent(this.event);
}

class _ImportComplete extends ReceiveChatBackupEvent {
  final Result<void, ImportChatBackupError> result;
  _ImportComplete(this.result);
}

class ReceiveChatBackupBloc extends Bloc<ReceiveChatBackupEvent, ReceiveBackupData>
    with ActionRunner {
  final ChatRepository chatRepository;
  final AccountDatabaseManager accountDb;
  final AccountId currentUser;
  StreamSubscription<ReceiveChatBackupWebSocketEvent>? _webSocketSubscription;
  ReceiveChatBackupWebSocket? _webSocket;
  final BytesBuilder _receivedData = BytesBuilder();

  ReceiveChatBackupBloc(RepositoryInstances r)
    : currentUser = r.accountId,
      chatRepository = r.chat,
      accountDb = r.accountDb,
      super(ReceiveBackupData()) {
    on<ConnectIfIdleOrConnecting>((event, emit) async {
      await runOnce(() async {
        if (_isIdle() || state.state == ReceiveBackupConnectionState.connecting) {
          await _connectToTransferApi(emit);
        }
      });
    });

    on<DisconnectIfIdle>((event, emit) async {
      if (_isIdle()) {
        await _cleanup();
      }
    });

    on<_WebSocketEvent>((event, emit) async {
      switch (event.event) {
        case ByteCountReceived(:final byteCount):
          emit(
            state.copyWith(
              state: ReceiveBackupConnectionState.transferring,
              totalBytes: byteCount,
              transferredBytes: 0,
            ),
          );
        case BinaryDataReceived(:final data):
          _receivedData.add(data);
          emit(state.copyWith(transferredBytes: _receivedData.length));

          // Check if transfer is complete
          if (state.totalBytes != null && _receivedData.length >= state.totalBytes!) {
            emit(state.copyWith(state: ReceiveBackupConnectionState.importing));
            await _importBackup(_receivedData.toBytes());
          }
        case WebSocketConnectionClosed(:final closeCode):
          if (closeCode != 1000) {
            // Close code 1008 means policy violation (transfer budget exceeded)
            final errorMessage = closeCode == 1008
                ? R.strings.chat_backup_transfer_budget_exceeded
                : R.strings.generic_error;
            emit(state.copyWith(errorMessage: errorMessage));
          }
          await _cleanup();
        case WebSocketConnectionError():
          emit(state.copyWith(errorMessage: R.strings.generic_error_occurred));
          await _cleanup();
      }
    });

    on<_ImportComplete>((event, emit) {
      switch (event.result) {
        case Ok():
          emit(state.copyWith(state: ReceiveBackupConnectionState.success, errorMessage: null));
        case Err(:final e):
          String errorMessage;
          switch (e) {
            case InvalidBackupFile():
              errorMessage = R.strings.chat_data_screen_import_error_invalid_backup_file;
            case UnsupportedBackupVersion():
              errorMessage = R.strings.chat_data_screen_import_error_unsupported_version;
            case WrongAccount():
              errorMessage = R.strings.chat_data_screen_import_error_wrong_account;
            case OtherImportError():
              errorMessage = R.strings.generic_error;
          }
          emit(state.copyWith(errorMessage: errorMessage));
      }
    });
  }

  bool _isIdle() =>
      state.state == ReceiveBackupConnectionState.waitingForSource ||
      state.state == ReceiveBackupConnectionState.success ||
      state.errorMessage == null;

  Future<void> _connectToTransferApi(Emitter<ReceiveBackupData> emit) async {
    await _cleanup();
    emit(
      state.copyWith(
        state: ReceiveBackupConnectionState.connecting,
        pairingCode: currentUser.aid,
        errorMessage: null,
      ),
    );

    // Query access token from database
    final accessTokenResult = await accountDb.accountStreamSingle(
      (db) => db.loginSession.watchAccessToken(),
    );

    final AccessToken accessToken;
    switch (accessTokenResult) {
      case Ok(:final v):
        accessToken = v;
      case Err(:final e):
        _log.severe("Failed to get access token: $e");
        emit(state.copyWith(errorMessage: R.strings.generic_error_occurred));
        await _cleanup();
        return;
    }

    final webSocket = ReceiveChatBackupWebSocket();
    _webSocket = webSocket;

    final publicKey = "dummy_public_key"; // TODO: Replace with actual public key
    final connected = await webSocket.connect(accessToken, publicKey);

    if (!connected) {
      emit(state.copyWith(errorMessage: R.strings.generic_error_occurred));
      await _cleanup();
      return;
    }

    emit(state.copyWith(state: ReceiveBackupConnectionState.waitingForSource));

    // Subscribe to WebSocket events
    _webSocketSubscription = webSocket.events.listen((event) {
      add(_WebSocketEvent(event));
    });
  }

  Future<void> _importBackup(Uint8List data) async {
    final result = await chatRepository.importChatBackup(data);
    await _cleanup();
    add(_ImportComplete(result));
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
