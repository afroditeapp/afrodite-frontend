

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:native_utils_common/native_utils_common.dart';
import 'package:native_utils_ffi/src/bindings.dart';

/// If generation fails, null is returned.
(GeneratedMessageKeys?, int) generateMessageKeys(String accountId) {
  final cAccountId = accountId.toNativeUtf8();
  final keyGenerationResult = getBindings().generate_message_keys(cAccountId.cast());
  malloc.free(cAccountId);

  final result = keyGenerationResult.result;
  final (GeneratedMessageKeys?, int) returnValue;
  if (result == 0) {
    final keys = GeneratedMessageKeys(
      public: copyToList(keyGenerationResult.public_key, keyGenerationResult.public_key_len),
      private: copyToList(keyGenerationResult.private_key, keyGenerationResult.private_key_len),
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
  Uint8List senderPrivateKey,
  Uint8List receiverPublicKey,
  Uint8List data,
) {
  final Pointer<Uint8> cSender = malloc.allocate(senderPrivateKey.length);
  cSender.asTypedList(senderPrivateKey.length).setAll(0, senderPrivateKey);
  final Pointer<Uint8> cReceiver = malloc.allocate(receiverPublicKey.length);
  cReceiver.asTypedList(receiverPublicKey.length).setAll(0, receiverPublicKey);
  final Pointer<Uint8> cData = malloc.allocate(data.length);
  cData.asTypedList(data.length).setAll(0, data);
  final encryptResult = getBindings().encrypt_message(
    cSender,
    senderPrivateKey.length,
    cReceiver,
    receiverPublicKey.length,
    cData,
    data.length,
  );
  malloc.free(cSender);
  malloc.free(cReceiver);
  malloc.free(cData);

  final result = encryptResult.result;
  final (Uint8List?, int) returnValue;
  if (result == 0) {
    final Uint8List cDataView = encryptResult.data.asTypedList(encryptResult.data_len);
    final encryptedData = Uint8List(encryptResult.data_len);
    encryptedData.setAll(0, cDataView);
    returnValue = (encryptedData, 0);
  } else {
    returnValue = (null, result);
  }
  getBindings().free_binary_data_result(encryptResult);
  return returnValue;
}

/// If decrypting fails, null is returned
(Uint8List?, int) decryptMessage(
  Uint8List senderPublicKey,
  Uint8List receiverPrivateKey,
  Uint8List pgpMessage,
) {
  final Pointer<Uint8> cSenderPublicKey = malloc.allocate(senderPublicKey.length);
  cSenderPublicKey.asTypedList(senderPublicKey.length).setAll(0, senderPublicKey);
  final Pointer<Uint8> cReceiverPrivateKey = malloc.allocate(receiverPrivateKey.length);
  cReceiverPrivateKey.asTypedList(receiverPrivateKey.length).setAll(0, receiverPrivateKey);
  final Pointer<Uint8> cMessageData = malloc.allocate(pgpMessage.length);
  cMessageData.asTypedList(pgpMessage.length).setAll(0, pgpMessage);
  final decryptResult = getBindings().decrypt_message(
    cSenderPublicKey,
    senderPublicKey.length,
    cReceiverPrivateKey,
    receiverPrivateKey.length,
    cMessageData,
    pgpMessage.length
  );
  malloc.free(cSenderPublicKey);
  malloc.free(cReceiverPrivateKey);
  malloc.free(cMessageData);

  final result = decryptResult.result;
  final (Uint8List?, int) returnValue;
  if (result == 0) {
    final decryptedData = copyToList(decryptResult.data, decryptResult.data_len);
    returnValue = (decryptedData, 0);
  } else {
    returnValue = (null, result);
  }
  getBindings().free_binary_data_result(decryptResult);
  return returnValue;
}

Uint8List copyToList(Pointer<Uint8> data, int len) {
  final Uint8List cDataView = data.asTypedList(len);
  final newData = Uint8List(len);
  newData.setAll(0, cDataView);
  return newData;
}
