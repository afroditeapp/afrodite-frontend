import "dart:async";
import "dart:convert";
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
import "package:crypto/crypto.dart";
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
        if (_isIdle() || state.state is Connecting) {
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
            state.copyWith(state: const Transferring(), totalBytes: byteCount, transferredBytes: 0),
          );
        case BinaryDataReceived(:final data):
          _receivedData.add(data);
          emit(state.copyWith(transferredBytes: _receivedData.length));

          // Check if transfer is complete
          if (state.totalBytes != null && _receivedData.length >= state.totalBytes!) {
            emit(state.copyWith(state: const Importing()));
            await _importBackup(_receivedData.toBytes());
          }
        case WebSocketConnectionClosed(:final closeCode):
          if (closeCode != 1000) {
            // Close code 1008 means policy violation (transfer budget exceeded)
            final errorMessage = closeCode == 1008
                ? R.strings.chat_backup_transfer_budget_exceeded
                : R.strings.generic_error;
            emit(state.copyWith(state: ErrorState(errorMessage)));
          }
          await _cleanup();
        case WebSocketConnectionError():
          emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
          await _cleanup();
      }
    });

    on<_ImportComplete>((event, emit) {
      switch (event.result) {
        case Ok():
          emit(state.copyWith(state: const Success()));
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
          emit(state.copyWith(state: ErrorState(errorMessage)));
      }
    });
  }

  bool _isIdle() =>
      state.state is WaitingForSource || state.state is Success || state.state is ErrorState;

  Future<void> _connectToTransferApi(Emitter<ReceiveBackupData> emit) async {
    await _cleanup();

    // Calculate SHA256 of target data JSON to use as pairing code
    final targetData = jsonEncode({"account_id": currentUser.aid});
    final targetDataBytes = utf8.encode(targetData);
    final hash = sha256.convert(targetDataBytes);
    final pairingCodeSha256 = base64Url.encode(hash.bytes);

    emit(state.copyWith(state: const Connecting(), pairingCode: pairingCodeSha256));

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
        emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
        await _cleanup();
        return;
    }

    final webSocket = ReceiveChatBackupWebSocket();
    _webSocket = webSocket;

    final connected = await webSocket.connect(accessToken, targetData);

    if (!connected) {
      emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
      await _cleanup();
      return;
    }

    emit(state.copyWith(state: const WaitingForSource()));

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
