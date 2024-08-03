// ignore_for_file: always_specify_types
// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

/// Bindings for `src/native_utils.h`.
///
/// Regenerate bindings with `flutter pub run ffigen --config ffigen.yaml`.
///
class NativeUtilsBindings {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  NativeUtilsBindings(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  NativeUtilsBindings.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  /// Generate a new content encryption key.
  ///
  /// The buffer for key generation must be 32 bytes long.
  ///
  /// The buffer can contain random data as it will be overwritten.
  ///
  /// Returns 0 if operation was successful.
  int generate_content_encryption_key(
    ffi.Pointer<ffi.Uint8> key,
    int key_len,
  ) {
    return _generate_content_encryption_key(
      key,
      key_len,
    );
  }

  late final _generate_content_encryption_keyPtr = _lookup<
      ffi.NativeFunction<
          ffi.IntPtr Function(ffi.Pointer<ffi.Uint8>,
              ffi.IntPtr)>>('generate_content_encryption_key');
  late final _generate_content_encryption_key =
      _generate_content_encryption_keyPtr
          .asFunction<int Function(ffi.Pointer<ffi.Uint8>, int)>(isLeaf: true);

  /// Replace plaintext with chiphertext and nonce.
  ///
  /// Data buffer needs to have 28 bytes empty space at the end.
  ///
  /// The buffer can contain random data as it will be overwritten.
  ///
  /// Returns 0 if operation was successful.
  int encrypt_content(
    ffi.Pointer<ffi.Uint8> data,
    int data_len,
    ffi.Pointer<ffi.Uint8> key,
    int key_len,
  ) {
    return _encrypt_content(
      data,
      data_len,
      key,
      key_len,
    );
  }

  late final _encrypt_contentPtr = _lookup<
      ffi.NativeFunction<
          ffi.IntPtr Function(ffi.Pointer<ffi.Uint8>, ffi.IntPtr,
              ffi.Pointer<ffi.Uint8>, ffi.IntPtr)>>('encrypt_content');
  late final _encrypt_content = _encrypt_contentPtr.asFunction<
      int Function(ffi.Pointer<ffi.Uint8>, int, ffi.Pointer<ffi.Uint8>,
          int)>(isLeaf: true);

  /// Replace chiphertext and nonce with plaintext data.
  ///
  /// The plaintext data is 28 bytes shorter than the data buffer size.
  ///
  /// Returns 0 if operation was successful.
  int decrypt_content(
    ffi.Pointer<ffi.Uint8> data,
    int data_len,
    ffi.Pointer<ffi.Uint8> key,
    int key_len,
  ) {
    return _decrypt_content(
      data,
      data_len,
      key,
      key_len,
    );
  }

  late final _decrypt_contentPtr = _lookup<
      ffi.NativeFunction<
          ffi.IntPtr Function(ffi.Pointer<ffi.Uint8>, ffi.IntPtr,
              ffi.Pointer<ffi.Uint8>, ffi.IntPtr)>>('decrypt_content');
  late final _decrypt_content = _decrypt_contentPtr.asFunction<
      int Function(ffi.Pointer<ffi.Uint8>, int, ffi.Pointer<ffi.Uint8>,
          int)>(isLeaf: true);

  /// Generate a new message encryption keys.
  ///
  /// Run equivalent free function for the result.
  GenerateMessageKeysResult generate_message_keys(
    ffi.Pointer<ffi.Char> account_id,
  ) {
    return _generate_message_keys(
      account_id,
    );
  }

  late final _generate_message_keysPtr = _lookup<
      ffi.NativeFunction<
          GenerateMessageKeysResult Function(
              ffi.Pointer<ffi.Char>)>>('generate_message_keys');
  late final _generate_message_keys = _generate_message_keysPtr
      .asFunction<GenerateMessageKeysResult Function(ffi.Pointer<ffi.Char>)>(
          isLeaf: true);

  void generate_message_keys_free_result(
    GenerateMessageKeysResult result,
  ) {
    return _generate_message_keys_free_result(
      result,
    );
  }

  late final _generate_message_keys_free_resultPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(GenerateMessageKeysResult)>>(
          'generate_message_keys_free_result');
  late final _generate_message_keys_free_result =
      _generate_message_keys_free_resultPtr
          .asFunction<void Function(GenerateMessageKeysResult)>(isLeaf: true);

  /// Encrypt message data.
  ///
  /// Run equivalent free function for the result.
  EncryptMessageResult encrypt_message(
    ffi.Pointer<ffi.Char> data_sender_armored_private_key,
    ffi.Pointer<ffi.Char> data_receiver_armored_public_key,
    ffi.Pointer<ffi.Uint8> data,
    int data_len,
  ) {
    return _encrypt_message(
      data_sender_armored_private_key,
      data_receiver_armored_public_key,
      data,
      data_len,
    );
  }

  late final _encrypt_messagePtr = _lookup<
      ffi.NativeFunction<
          EncryptMessageResult Function(
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Uint8>,
              ffi.IntPtr)>>('encrypt_message');
  late final _encrypt_message = _encrypt_messagePtr.asFunction<
      EncryptMessageResult Function(ffi.Pointer<ffi.Char>,
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Uint8>, int)>(isLeaf: true);

  void encrypt_message_free_result(
    EncryptMessageResult result,
  ) {
    return _encrypt_message_free_result(
      result,
    );
  }

  late final _encrypt_message_free_resultPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(EncryptMessageResult)>>(
          'encrypt_message_free_result');
  late final _encrypt_message_free_result = _encrypt_message_free_resultPtr
      .asFunction<void Function(EncryptMessageResult)>(isLeaf: true);

  /// Decrypt message data.
  ///
  /// Run equivalent free function for the result.
  DecryptMessageResult decrypt_message(
    ffi.Pointer<ffi.Char> data_sender_armored_public_key,
    ffi.Pointer<ffi.Char> data_receiver_armored_private_key,
    ffi.Pointer<ffi.Char> armored_pgp_message,
  ) {
    return _decrypt_message(
      data_sender_armored_public_key,
      data_receiver_armored_private_key,
      armored_pgp_message,
    );
  }

  late final _decrypt_messagePtr = _lookup<
      ffi.NativeFunction<
          DecryptMessageResult Function(
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>,
              ffi.Pointer<ffi.Char>)>>('decrypt_message');
  late final _decrypt_message = _decrypt_messagePtr.asFunction<
      DecryptMessageResult Function(ffi.Pointer<ffi.Char>,
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>)>(isLeaf: true);

  void decrypt_message_free_result(
    DecryptMessageResult result,
  ) {
    return _decrypt_message_free_result(
      result,
    );
  }

  late final _decrypt_message_free_resultPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DecryptMessageResult)>>(
          'decrypt_message_free_result');
  late final _decrypt_message_free_result = _decrypt_message_free_resultPtr
      .asFunction<void Function(DecryptMessageResult)>(isLeaf: true);
}

/// Message encryption API
final class GenerateMessageKeysResult extends ffi.Struct {
  @ffi.IntPtr()
  external int result;

  /// Null if failure
  external ffi.Pointer<ffi.Char> public_key;

  /// Null if failure
  external ffi.Pointer<ffi.Char> private_key;
}

final class EncryptMessageResult extends ffi.Struct {
  @ffi.IntPtr()
  external int result;

  /// Null if failure
  external ffi.Pointer<ffi.Char> encrypted_message;
}

final class DecryptMessageResult extends ffi.Struct {
  @ffi.IntPtr()
  external int result;

  /// Null if failure
  external ffi.Pointer<ffi.Uint8> decrypted_message;

  @ffi.IntPtr()
  external int decrypted_message_len;

  @ffi.IntPtr()
  external int decrypted_message_capacity;
}
