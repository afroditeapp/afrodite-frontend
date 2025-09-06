import 'dart:typed_data';

import 'package:native_utils_common/native_utils_common.dart';

(Uint8List?, int) encryptContentData(Uint8List input, Uint8List key) =>
    throw UnsupportedError("Not implemented");

(Uint8List?, int) decryptContentData(Uint8List input, Uint8List key) =>
    throw UnsupportedError("Not implemented");

// Message API

/// If generation fails, null is returned.
(GeneratedMessageKeys?, int) generateMessageKeys(String accountId) =>
    throw UnsupportedError("Not implemented");

/// If encrypting fails, null is returned
(EncryptResult?, int) encryptMessage(
  Uint8List senderPrivateKey,
  Uint8List receiverPublicKey,
  Uint8List data,
) => throw UnsupportedError("Not implemented");

/// If decrypting fails, null is returned
(DecryptResult?, int) decryptMessage(
  Uint8List senderPublicKey,
  Uint8List receiverPrivateKey,
  Uint8List pgpMessage,
) => throw UnsupportedError("Not implemented");

/// When getting message content fails, null is returned
(Uint8List?, int) getMessageContent(Uint8List pgpMessage) =>
    throw UnsupportedError("Not implemented");
