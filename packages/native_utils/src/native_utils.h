#include <stdint.h>

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

// Content encryption API

// Generate a new content encryption key.
//
// The buffer for key generation must be 32 bytes long.
//
// The buffer can contain random data as it will be overwritten.
//
// Returns 0 if operation was successful.
FFI_PLUGIN_EXPORT intptr_t generate_content_encryption_key(
  uint8_t* key,
  intptr_t key_len
);

// Replace plaintext with chiphertext and nonce.
//
// Data buffer needs to have 28 bytes empty space at the end.
//
// The buffer can contain random data as it will be overwritten.
//
// Returns 0 if operation was successful.
FFI_PLUGIN_EXPORT intptr_t encrypt_content(
  uint8_t* data,
  intptr_t data_len,
  const uint8_t* key,
  intptr_t key_len
);

// Replace chiphertext and nonce with plaintext data.
//
// The plaintext data is 28 bytes shorter than the data buffer size.
//
// Returns 0 if operation was successful.
FFI_PLUGIN_EXPORT intptr_t decrypt_content(
  uint8_t* data,
  intptr_t data_len,
  const uint8_t* key,
  intptr_t key_len
);

// Message encryption API

struct GenerateMessageKeysResult {
  intptr_t result;
  // Null if failure
  const char* public_key;
  // Null if failure
  const char* private_key;
};

// Generate a new message encryption keys.
//
// Run equivalent free function for the result.
FFI_PLUGIN_EXPORT struct GenerateMessageKeysResult generate_message_keys(
  const char* account_id
);

FFI_PLUGIN_EXPORT void generate_message_keys_free_result(
  struct GenerateMessageKeysResult result
);

struct EncryptMessageResult {
  intptr_t result;
  // Null if failure
  const char* encrypted_message;
};

// Encrypt message data.
//
// Run equivalent free function for the result.
FFI_PLUGIN_EXPORT struct EncryptMessageResult encrypt_message(
  const char* data_sender_armored_private_key,
  const char* data_receiver_armored_public_key,
  const uint8_t* data,
  intptr_t data_len
);

FFI_PLUGIN_EXPORT void encrypt_message_free_result(
  struct EncryptMessageResult result
);

struct DecryptMessageResult {
  intptr_t result;
  // Null if failure
  const uint8_t* decrypted_message;
  intptr_t decrypted_message_len;
  intptr_t decrypted_message_capacity;
};

// Decrypt message data.
//
// Run equivalent free function for the result.
FFI_PLUGIN_EXPORT struct DecryptMessageResult decrypt_message(
  const char* data_sender_armored_public_key,
  const char* data_receiver_armored_private_key,
  const char* armored_pgp_message
);

FFI_PLUGIN_EXPORT void decrypt_message_free_result(
  struct DecryptMessageResult result
);
