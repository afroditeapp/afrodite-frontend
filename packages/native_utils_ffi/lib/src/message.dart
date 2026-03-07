import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:native_utils_common/native_utils_common.dart';
import 'package:native_utils_ffi/src/bindings.dart';
import 'package:native_utils_ffi/src/native_utils_ffi_bindings_generated.dart';

/// If generation fails, null is returned.
Future<(GeneratedMessageKeys?, int)> generateMessageKeys(String accountId) async {
  final cAccountId = accountId.toNativeUtf8();
  final keyGenerationResult = getBindings().generate_message_keys(cAccountId.cast());
  malloc.free(cAccountId);

  final (public, private, result) = handleBinaryDataResult2(keyGenerationResult);
  if (public != null && private != null) {
    final keys = GeneratedMessageKeys(public: public, private: private);
    return (keys, result);
  } else {
    return (null, result);
  }
}

/// If encrypting fails, null is returned
Future<(EncryptResult?, int)> encryptMessage(
  Uint8List senderPrivateKey,
  Uint8List recipientPublicKey,
  Uint8List data,
) async {
  final Pointer<Uint8> cSender = malloc.allocate(senderPrivateKey.length);
  cSender.asTypedList(senderPrivateKey.length).setAll(0, senderPrivateKey);
  final Pointer<Uint8> cRecipient = malloc.allocate(recipientPublicKey.length);
  cRecipient.asTypedList(recipientPublicKey.length).setAll(0, recipientPublicKey);
  final Pointer<Uint8> cData = malloc.allocate(data.length);
  cData.asTypedList(data.length).setAll(0, data);

  final encryptResult = getBindings().encrypt_message(
    cSender,
    senderPrivateKey.length,
    cRecipient,
    recipientPublicKey.length,
    cData,
    data.length,
  );

  malloc.free(cSender);
  malloc.free(cRecipient);
  malloc.free(cData);

  final (pgpMessage, sessionKey, result) = handleBinaryDataResult2(encryptResult);
  if (pgpMessage != null && sessionKey != null) {
    return (EncryptResult(pgpMessage: pgpMessage, sessionKey: sessionKey), result);
  } else {
    return (null, result);
  }
}

/// If decrypting fails, null is returned
Future<(DecryptResult?, int)> decryptMessage(
  Uint8List senderPublicKey,
  Uint8List recipientPrivateKey,
  Uint8List pgpMessage,
) async {
  final Pointer<Uint8> cSenderPublicKey = malloc.allocate(senderPublicKey.length);
  cSenderPublicKey.asTypedList(senderPublicKey.length).setAll(0, senderPublicKey);
  final Pointer<Uint8> cRecipientPrivateKey = malloc.allocate(recipientPrivateKey.length);
  cRecipientPrivateKey.asTypedList(recipientPrivateKey.length).setAll(0, recipientPrivateKey);
  final Pointer<Uint8> cMessageData = malloc.allocate(pgpMessage.length);
  cMessageData.asTypedList(pgpMessage.length).setAll(0, pgpMessage);

  final decryptResult = getBindings().decrypt_message(
    cSenderPublicKey,
    senderPublicKey.length,
    cRecipientPrivateKey,
    recipientPrivateKey.length,
    cMessageData,
    pgpMessage.length,
  );

  malloc.free(cSenderPublicKey);
  malloc.free(cRecipientPrivateKey);
  malloc.free(cMessageData);

  final (messageData, sessionKey, result) = handleBinaryDataResult2(decryptResult);
  if (messageData != null && sessionKey != null) {
    return (DecryptResult(messageData: messageData, sessionKey: sessionKey), result);
  } else {
    return (null, result);
  }
}

/// When getting the PGP message content fails, null is returned
Future<(Uint8List?, int)> getMessageContent(Uint8List pgpMessage) async {
  final Pointer<Uint8> cMessageData = malloc.allocate(pgpMessage.length);
  cMessageData.asTypedList(pgpMessage.length).setAll(0, pgpMessage);

  final getMessageContentResult = getBindings().get_message_content(
    cMessageData,
    pgpMessage.length,
  );

  malloc.free(cMessageData);

  return handleBinaryDataResult(getMessageContentResult);
}

Uint8List copyToList(Pointer<Uint8> data, int len) {
  final Uint8List cDataView = data.asTypedList(len);
  final newData = Uint8List(len);
  newData.setAll(0, cDataView);
  return newData;
}

(Uint8List?, int) handleBinaryDataResult(BinaryDataResult r) {
  final result = r.result;
  final (Uint8List?, int) returnValue;
  if (result == 0) {
    final copiedData = copyToList(r.data.data, r.data.len);
    returnValue = (copiedData, 0);
  } else {
    returnValue = (null, result);
  }
  getBindings().free_binary_data_result(r);
  return returnValue;
}

(Uint8List?, Uint8List?, int) handleBinaryDataResult2(BinaryDataResult2 r) {
  final result = r.result;
  final (Uint8List?, Uint8List?, int) returnValue;
  if (result == 0) {
    final firstCopiedData = copyToList(r.first_data.data, r.first_data.len);
    final secondCopiedData = copyToList(r.second_data.data, r.second_data.len);
    returnValue = (firstCopiedData, secondCopiedData, 0);
  } else {
    returnValue = (null, null, result);
  }
  getBindings().free_binary_data_result_2(r);
  return returnValue;
}
