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
import "package:native_utils/native_utils.dart";
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
  GeneratedMessageKeys? _targetKeys;

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
            final parseResult = await _parseReceivedData(_receivedData.toBytes());
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

    // Generate keypair for E2EE
    final (keys, keyGenResult) = await generateMessageKeys(currentUser.aid);
    if (keys == null) {
      _log.severe("Failed to generate keypair: $keyGenResult");
      emit(state.copyWith(state: ErrorState(R.strings.generic_error)));
      await _cleanup();
      return;
    }
    _targetKeys = keys;

    // Calculate SHA256 of target data JSON to use as pairing code
    final targetData = jsonEncode({
      "account_id": currentUser.aid,
      "public_key": base64Url.encode(keys.public),
    });
    final targetDataBytes = utf8.encode(targetData);
    final hash = sha256.convert(targetDataBytes);
    final pairingCodeSha256 = base64Url.encode(hash.bytes);
    // Add version identifier ("1") as prefix
    final pairingCodeWithVersion = "1$pairingCodeSha256";

    // Create binary QR code data: version (1 byte) + SHA256 hash (32 bytes)
    final qrData = Uint8List(33);
    qrData[0] = 1; // version
    qrData.setRange(1, 33, hash.bytes);

    emit(
      state.copyWith(
        state: const Connecting(),
        pairingCode: pairingCodeWithVersion,
        qrCodeData: qrData,
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

  /// Parse received data: validate version byte, extract source's public key,
  /// decrypt backup data, and return decrypted backup
  Future<_ParseReceivedDataResult> _parseReceivedData(Uint8List data) async {
    // Minimum size: 1 byte (version) + 4 bytes (public key length) + public key + 4 bytes (encrypted data length)
    if (data.length < 9) {
      _log.severe("Received data too short: ${data.length} bytes");
      return _ParseErrorOther();
    }

    int offset = 0;

    // Validate version byte (must be 1)
    final version = data[offset];
    offset += 1;
    if (version != 1) {
      _log.severe("Unsupported backup transfer version: $version");
      return _ParseErrorVersion();
    }

    // Parse 32-bit little endian unsigned integer for source public key length
    final publicKeyLengthBytes = data.sublist(offset, offset + 4);
    final publicKeyByteData = ByteData.view(
      publicKeyLengthBytes.buffer,
      publicKeyLengthBytes.offsetInBytes,
    );
    final publicKeyLength = publicKeyByteData.getUint32(0, Endian.little);
    offset += 4;

    // Validate public key length is reasonable
    if (publicKeyLength == 0 || publicKeyLength > 10000 || offset + publicKeyLength > data.length) {
      _log.severe("Invalid public key length: $publicKeyLength");
      return _ParseErrorOther();
    }

    // Extract source's public key
    final sourcePublicKey = data.sublist(offset, offset + publicKeyLength);
    offset += publicKeyLength;

    // Parse 32-bit little endian unsigned integer for encrypted data length
    if (offset + 4 > data.length) {
      _log.severe("Data too short for encrypted data length");
      return _ParseErrorOther();
    }
    final encryptedDataLengthBytes = data.sublist(offset, offset + 4);
    final encryptedDataByteData = ByteData.view(
      encryptedDataLengthBytes.buffer,
      encryptedDataLengthBytes.offsetInBytes,
    );
    final encryptedDataLength = encryptedDataByteData.getUint32(0, Endian.little);
    offset += 4;

    // Validate that we received the expected amount of encrypted data
    final actualEncryptedDataLength = data.length - offset;
    if (actualEncryptedDataLength != encryptedDataLength) {
      _log.severe(
        "Encrypted data length mismatch: expected $encryptedDataLength, got $actualEncryptedDataLength",
      );
      return _ParseErrorOther();
    }

    // Extract encrypted backup data
    final encryptedBackupData = data.sublist(offset);

    // Decrypt the backup data
    final targetKeys = _targetKeys;
    if (targetKeys == null) {
      _log.severe("Target keys not available for decryption");
      return _ParseErrorOther();
    }

    final (decryptResult, decryptStatus) = await decryptMessage(
      sourcePublicKey,
      targetKeys.private,
      encryptedBackupData,
    );

    if (decryptResult == null) {
      _log.severe("Failed to decrypt backup data: $decryptStatus");
      return _ParseErrorOther();
    }

    // Return the decrypted backup data
    return _ParseSuccess(decryptResult.messageData);
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
    _targetKeys = null;
  }

  @override
  Future<void> close() async {
    await _cleanup();
    await super.close();
  }
}
