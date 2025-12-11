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

sealed class _ParseReceivedDataResult {}

class _ParseSuccess extends _ParseReceivedDataResult {
  final Uint8List data;
  _ParseSuccess(this.data);
}

class _ParseErrorVersion extends _ParseReceivedDataResult {}

class _ParseErrorOther extends _ParseReceivedDataResult {}

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
            final parseResult = _parseReceivedData(_receivedData.toBytes());
            switch (parseResult) {
              case _ParseSuccess(:final data):
                await _importBackup(data);
              case _ParseErrorVersion():
                emit(
                  state.copyWith(state: ErrorState(R.strings.chat_backup_data_stream_unsupported)),
                );
                await _cleanup();
              case _ParseErrorOther():
                emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
                await _cleanup();
            }
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
    // Add version identifier ("1") as prefix
    final pairingCodeWithVersion = "1$pairingCodeSha256";

    emit(state.copyWith(state: const Connecting(), pairingCode: pairingCodeWithVersion));

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

  /// Parse received data: validate version byte and extract actual backup data
  _ParseReceivedDataResult _parseReceivedData(Uint8List data) {
    // Minimum size: 1 byte (version) + 4 bytes (length)
    if (data.length < 5) {
      _log.severe("Received data too short: ${data.length} bytes");
      return _ParseErrorOther();
    }

    // Validate version byte (must be 1)
    final version = data[0];
    if (version != 1) {
      _log.severe("Unsupported backup transfer version: $version");
      return _ParseErrorVersion();
    }

    // Parse 32-bit little endian unsigned integer for data length
    final lengthBytes = data.sublist(1, 5);
    final byteData = ByteData.view(lengthBytes.buffer, lengthBytes.offsetInBytes);
    final expectedLength = byteData.getUint32(0, Endian.little);

    // Validate that we received the expected amount of data
    final actualDataLength = data.length - 5;
    if (actualDataLength != expectedLength) {
      _log.severe("Data length mismatch: expected $expectedLength, got $actualDataLength");
      return _ParseErrorOther();
    }

    // Extract and return the actual backup data
    return _ParseSuccess(data.sublist(5));
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
    _receivedData.clear();
  }

  @override
  Future<void> close() async {
    await _cleanup();
    await super.close();
  }
}
