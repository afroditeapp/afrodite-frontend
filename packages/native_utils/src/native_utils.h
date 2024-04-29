#include <stdint.h>

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

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
