#include <stdint.h>

#if _WIN32
#define FFI_PLUGIN_EXPORT extern __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT extern
#endif

// Message encryption API

struct BinaryData {
  // Null if failure
  const uint8_t* data;
  intptr_t len;
  intptr_t capacity;
};

struct BinaryDataResult2 {
  intptr_t result;
  // Null if failure
  struct BinaryData first_data;
  struct BinaryData second_data;
};

FFI_PLUGIN_EXPORT void free_binary_data_result_2(
  struct BinaryDataResult2 result
);

// Generate a new message encryption keys.
//
// Run equivalent free function for the result.
//
// First result value is public key and second is private key.
FFI_PLUGIN_EXPORT struct BinaryDataResult2 generate_message_keys(
  const char* account_id
);

struct BinaryDataResult {
  intptr_t result;
  struct BinaryData data;
};

FFI_PLUGIN_EXPORT void free_binary_data_result(
  struct BinaryDataResult result
);

// Encrypt message data.
//
// The result must be freed using free_binary_data_result.
//
// First result value is PGP message and second is session key.
FFI_PLUGIN_EXPORT struct BinaryDataResult2 encrypt_message(
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
//
// First result value is message data and second is session key.
FFI_PLUGIN_EXPORT struct BinaryDataResult2 decrypt_message(
  const uint8_t* sender_public_key,
  intptr_t sender_public_key_len,
  const uint8_t* receiver_private_key,
  intptr_t receiver_private_key_len,
  const uint8_t* pgp_message,
  intptr_t pgp_message_len
);

// Get message content from PGP message if possible.
//
// The result must be freed using free_binary_data_result.
FFI_PLUGIN_EXPORT struct BinaryDataResult get_message_content(
  const uint8_t* pgp_message,
  intptr_t pgp_message_len
);
