
import 'dart:typed_data';

import 'package:native_utils/native_utils.dart';

/// If generation fails, null is returned.
(Uint8List?, int) generate256BitSecretKey() =>
  throw UnsupportedError("Not implemented");

(Uint8List?, int) encryptContentData(Uint8List input, Uint8List key) =>
  throw UnsupportedError("Not implemented");

(Uint8List?, int) decryptContentData(Uint8List input, Uint8List key) =>
  throw UnsupportedError("Not implemented");

// Message API

/// If generation fails, null is returned.
(GeneratedMessageKeys?, int) generateMessageKeys(String accountId) =>
  throw UnsupportedError("Not implemented");

/// If encrypting fails, null is returned
(Uint8List?, int) encryptMessage(
  String dataSenderArmoredPrivateKey,
  String dataReceiverArmoredPublicKey,
  Uint8List data,
) => throw UnsupportedError("Not implemented");

/// If decrypting fails, null is returned
(Uint8List?, int) decryptMessage(
  String dataSenderArmoredPublicKey,
  String dataReceiverArmoredPrivateKey,
  Uint8List pgpMessage,
) => throw UnsupportedError("Not implemented");
