

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:native_utils_ffi/src/bindings.dart';

/// If generation fails, null is returned.
(Uint8List?, int) generate256BitSecretKey() {
  const int keyLength = 32; // 256 bits

  final Pointer<Uint8> data = malloc.allocate(keyLength);
  final keyGenerationResult = getBindings().generate_content_encryption_key(data, keyLength);
  final l = data.asTypedList(keyLength);
  final key = Uint8List.fromList(l);
  malloc.free(data);

  if (keyGenerationResult != 0) {
    return (null, keyGenerationResult);
  } else {
    return (key, keyGenerationResult);
  }
}

const _ENCRYPTION_EXTRA_SPACE = 28;

(Uint8List?, int) encryptContentData(Uint8List input, Uint8List key) {
  int dataLenght = input.length + _ENCRYPTION_EXTRA_SPACE;

  final Pointer<Uint8> data = malloc.allocate(dataLenght);
  final l = data.asTypedList(dataLenght);
  l.setAll(0, input);

  final Pointer<Uint8> keyData = malloc.allocate(key.length);
  final keyL = keyData.asTypedList(key.length);
  keyL.setAll(0, key);

  final encryptionResult = getBindings().encrypt_content(data, dataLenght, keyData, key.length);

  final output = Uint8List.fromList(l);
  malloc.free(data);
  malloc.free(keyData);

  if (encryptionResult != 0) {
    return (null, encryptionResult);
  } else {
    return (output, encryptionResult);
  }
}

(Uint8List?, int) decryptContentData(Uint8List input, Uint8List key) {
  final Pointer<Uint8> data = malloc.allocate(input.length);
  final l = data.asTypedList(input.length);
  l.setAll(0, input);

  final Pointer<Uint8> keyData = malloc.allocate(key.length);
  final keyL = keyData.asTypedList(key.length);
  keyL.setAll(0, key);

  final decryptionResult = getBindings().decrypt_content(data, input.length, keyData, key.length);

  final plaintextLenght = input.length - _ENCRYPTION_EXTRA_SPACE;
  final output = Uint8List(plaintextLenght);
  output.setRange(0, plaintextLenght, l);
  malloc.free(data);
  malloc.free(keyData);

  if (decryptionResult != 0) {
    return (null, decryptionResult);
  } else {
    return (output, decryptionResult);
  }
}
