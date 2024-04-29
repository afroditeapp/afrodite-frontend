#include "native_utils.h"

extern intptr_t rust_generate_content_encryption_key(
  uint8_t* key,
  intptr_t key_len
);
extern intptr_t rust_encrypt_content(
  uint8_t* data,
  intptr_t data_len,
  const uint8_t* key,
  intptr_t key_len
);
extern intptr_t rust_decrypt_content(
  uint8_t* data,
  intptr_t data_len,
  const uint8_t* key,
  intptr_t key_len
);

FFI_PLUGIN_EXPORT intptr_t generate_content_encryption_key(
  uint8_t* key,
  intptr_t key_len
) {
  return rust_generate_content_encryption_key(key, key_len);
}

FFI_PLUGIN_EXPORT intptr_t encrypt_content(
  uint8_t* data,
  intptr_t data_len,
  const uint8_t* key,
  intptr_t key_len
) {
  return rust_encrypt_content(data, data_len, key, key_len);
}

FFI_PLUGIN_EXPORT intptr_t decrypt_content(
  uint8_t* data,
  intptr_t data_len,
  const uint8_t* key,
  intptr_t key_len
) {
  return rust_decrypt_content(data, data_len, key, key_len);
}
