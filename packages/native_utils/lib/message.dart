

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:native_utils/bindings.dart';

class GeneratedMessageKeys {
  final String armoredPublicKey;
  final String armoredPrivateKey;
  GeneratedMessageKeys({required this.armoredPublicKey, required this.armoredPrivateKey});
}

/// If generation fails, null is returned.
(GeneratedMessageKeys?, int) generateMessageKeys(String accountId) {
  final cAccountId = accountId.toNativeUtf8();
  final keyGenerationResult = getBindings().generate_message_keys(cAccountId.cast());
  malloc.free(cAccountId);

  final result = keyGenerationResult.result;
  final (GeneratedMessageKeys?, int) returnValue;
  if (result == 0) {
    final keys = GeneratedMessageKeys(
      armoredPublicKey: keyGenerationResult.public_key.cast<Utf8>().toDartString(),
      armoredPrivateKey: keyGenerationResult.private_key.cast<Utf8>().toDartString(),
    );
    returnValue = (keys, 0);
  } else {
    returnValue = (null, result);
  }
  getBindings().generate_message_keys_free_result(keyGenerationResult);
  return returnValue;
}

/// If encrypting fails, null is returned
(Uint8List?, int) encryptMessage(
  String dataSenderArmoredPrivateKey,
  String dataReceiverArmoredPublicKey,
  Uint8List data,
) {
  final cDataSender = dataSenderArmoredPrivateKey.toNativeUtf8();
  final cDataReceiver = dataReceiverArmoredPublicKey.toNativeUtf8();
  final Pointer<Uint8> cData = malloc.allocate(data.length);
  cData.asTypedList(data.length).setAll(0, data);
  final encryptResult = getBindings().encrypt_message(cDataSender.cast(), cDataReceiver.cast(), cData, data.length);
  malloc.free(cDataSender);
  malloc.free(cDataReceiver);
  malloc.free(cData);

  final result = encryptResult.result;
  final (Uint8List?, int) returnValue;
  if (result == 0) {
    final Uint8List cDataView = encryptResult.encrypted_message.asTypedList(encryptResult.encrypted_message_len);
    final encryptedData = Uint8List(encryptResult.encrypted_message_len);
    encryptedData.setAll(0, cDataView);
    returnValue = (encryptedData, 0);
  } else {
    returnValue = (null, result);
  }
  getBindings().encrypt_message_free_result(encryptResult);
  return returnValue;
}

/// If decrypting fails, null is returned
(Uint8List?, int) decryptMessage(
  String dataSenderArmoredPublicKey,
  String dataReceiverArmoredPrivateKey,
  Uint8List pgpMessage,
) {
  final cDataSender = dataSenderArmoredPublicKey.toNativeUtf8();
  final cDataReceiver = dataReceiverArmoredPrivateKey.toNativeUtf8();
  final Pointer<Uint8> cMessageData = malloc.allocate(pgpMessage.length);
  cMessageData.asTypedList(pgpMessage.length).setAll(0, pgpMessage);
  final decryptResult = getBindings().decrypt_message(cDataSender.cast(), cDataReceiver.cast(), cMessageData, pgpMessage.length);
  malloc.free(cDataSender);
  malloc.free(cDataReceiver);
  malloc.free(cMessageData);

  final result = decryptResult.result;
  final (Uint8List?, int) returnValue;
  if (result == 0) {
    final Uint8List cDataView = decryptResult.decrypted_message.asTypedList(decryptResult.decrypted_message_len);
    final decryptedData = Uint8List(decryptResult.decrypted_message_len);
    decryptedData.setAll(0, cDataView);
    returnValue = (decryptedData, 0);
  } else {
    returnValue = (null, result);
  }
  getBindings().decrypt_message_free_result(decryptResult);
  return returnValue;
}
