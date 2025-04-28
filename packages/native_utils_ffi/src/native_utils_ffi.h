#include <stdint.h>

#if _WIN32
#define FFI_PLUGIN_EXPORT extern __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT extern
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
  const uint8_t* public_key;
  intptr_t public_key_len;
  intptr_t public_key_capacity;
  // Null if failure
  const uint8_t* private_key;
  intptr_t private_key_len;
  intptr_t private_key_capacity;
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

struct BinaryDataResult {
  intptr_t result;
  // Null if failure
  const uint8_t* data;
  intptr_t data_len;
  intptr_t data_capacity;
};

FFI_PLUGIN_EXPORT void free_binary_data_result(
  struct BinaryDataResult result
);

// Encrypt message data.
//
// The result must be freed using free_binary_data_result.
FFI_PLUGIN_EXPORT struct BinaryDataResult encrypt_message(
  const uint8_t* sender_private_key,
  intptr_t sender_private_key_len,
  const uint8_t* receiver_public_key,
  intptr_t receiver_public_key_len,
  const uint8_t* data,
  intptr_t data_len
);

// Decrypt message data.
//
// The result must be freed using free_binary_data_result.
FFI_PLUGIN_EXPORT struct BinaryDataResult decrypt_message(
  const uint8_t* sender_public_key,
  intptr_t sender_public_key_len,
  const uint8_t* receiver_private_key,
  intptr_t receiver_private_key_len,
  const uint8_t* pgp_message,
  intptr_t pgp_message_len
);
