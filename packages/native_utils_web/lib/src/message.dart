import 'dart:js_interop';
import 'dart:typed_data';

import 'package:native_utils_common/native_utils_common.dart';

@JS('rust_utils')
external JSPromise get _rustUtils;

extension type RustUtils._(JSObject _) implements JSObject {
  @JS('generate_message_keys_rust')
  external JSFunction get generateMessageKeysRust;
  @JS('encrypt_data_rust')
  external JSFunction get encryptDataRust;
  @JS('decrypt_data_rust')
  external JSFunction get decryptDataRust;
  @JS('get_message_content_rust')
  external JSFunction get getMessageContentRust;
}

@JS('KeyPairBytes')
extension type KeyPairBytes._(JSObject _) implements JSObject {
  external JSUint8Array get public;
  external JSUint8Array get private;
}

@JS('EncryptingOutput')
extension type EncryptingOutput._(JSObject _) implements JSObject {
  external JSUint8Array get message;
  @JS('session_key')
  external JSUint8Array get sessionKey;
}

@JS('DecryptingOutput')
extension type DecryptingOutput._(JSObject _) implements JSObject {
  external JSUint8Array get data;
  @JS('session_key')
  external JSUint8Array get sessionKey;
}

Future<(GeneratedMessageKeys?, int)> generateMessageKeys(String accountId) async {
  try {
    final module = await _rustUtils.toDart as RustUtils;
    final result =
        module.generateMessageKeysRust.callAsFunction(null, accountId.toJS) as KeyPairBytes;
    return (GeneratedMessageKeys(public: result.public.toDart, private: result.private.toDart), 0);
  } catch (_) {
    return (null, -1);
  }
}

Future<(EncryptResult?, int)> encryptMessage(
  Uint8List senderPrivateKey,
  Uint8List receiverPublicKey,
  Uint8List data,
) async {
  try {
    final module = await _rustUtils.toDart as RustUtils;
    final result =
        module.encryptDataRust.callAsFunction(
              null,
              senderPrivateKey.toJS,
              receiverPublicKey.toJS,
              data.toJS,
            )
            as EncryptingOutput;
    return (
      EncryptResult(pgpMessage: result.message.toDart, sessionKey: result.sessionKey.toDart),
      0,
    );
  } catch (_) {
    return (null, -1);
  }
}

Future<(DecryptResult?, int)> decryptMessage(
  Uint8List senderPublicKey,
  Uint8List receiverPrivateKey,
  Uint8List pgpMessage,
) async {
  try {
    final module = await _rustUtils.toDart as RustUtils;
    final result =
        module.decryptDataRust.callAsFunction(
              null,
              senderPublicKey.toJS,
              receiverPrivateKey.toJS,
              pgpMessage.toJS,
            )
            as DecryptingOutput;
    return (
      DecryptResult(messageData: result.data.toDart, sessionKey: result.sessionKey.toDart),
      0,
    );
  } catch (_) {
    return (null, -1);
  }
}

Future<(Uint8List?, int)> getMessageContent(Uint8List pgpMessage) async {
  try {
    final module = await _rustUtils.toDart as RustUtils;
    final result =
        module.getMessageContentRust.callAsFunction(null, pgpMessage.toJS) as JSUint8Array;
    return (result.toDart, 0);
  } catch (_) {
    return (null, -1);
  }
}
