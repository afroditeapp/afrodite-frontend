import 'dart:typed_data';

import 'package:native_utils/native_utils.dart';

// Message API

/// If generation fails, null is returned.
Future<(GeneratedMessageKeys?, int)> generateMessageKeys(String accountId) =>
    throw UnsupportedError("Not implemented");

/// If encrypting fails, null is returned
Future<(EncryptResult?, int)> encryptMessage(
  Uint8List senderPrivateKey,
  Uint8List receiverPublicKey,
  Uint8List data,
) => throw UnsupportedError("Not implemented");

/// If decrypting fails, null is returned
Future<(DecryptResult?, int)> decryptMessage(
  Uint8List senderPublicKey,
  Uint8List receiverPrivateKey,
  Uint8List pgpMessage,
) => throw UnsupportedError("Not implemented");

/// When getting message content fails, null is returned
Future<(Uint8List?, int)> getMessageContent(Uint8List pgpMessage) =>
    throw UnsupportedError("Not implemented");
