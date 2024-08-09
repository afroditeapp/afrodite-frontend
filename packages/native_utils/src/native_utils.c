#include "native_utils.h"

// Content encryption API

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

// Message encryption API

extern struct GenerateMessageKeysResult rust_generate_message_keys(
  const char* account_id
);
FFI_PLUGIN_EXPORT struct GenerateMessageKeysResult generate_message_keys(
  const char* account_id
) {
  return rust_generate_message_keys(account_id);
}

extern void rust_generate_message_keys_free_result(
  struct GenerateMessageKeysResult result
);
FFI_PLUGIN_EXPORT void generate_message_keys_free_result(
  struct GenerateMessageKeysResult result
) {
  return rust_generate_message_keys_free_result(result);
}

extern struct EncryptMessageResult rust_encrypt_message(
  const char* data_sender_armored_private_key,
  const char* data_receiver_armored_public_key,
  const uint8_t* data,
  intptr_t data_len
);
FFI_PLUGIN_EXPORT struct EncryptMessageResult encrypt_message(
  const char* data_sender_armored_private_key,
  const char* data_receiver_armored_public_key,
  const uint8_t* data,
  intptr_t data_len
) {
  return rust_encrypt_message(
    data_sender_armored_private_key,
    data_receiver_armored_public_key,
    data,
    data_len
  );
}

extern void rust_encrypt_message_free_result(
  struct EncryptMessageResult result
);
FFI_PLUGIN_EXPORT void encrypt_message_free_result(
  struct EncryptMessageResult result
) {
  rust_encrypt_message_free_result(result);
}

extern struct DecryptMessageResult rust_decrypt_message(
  const char* data_sender_armored_public_key,
  const char* data_receiver_armored_private_key,
  const uint8_t* pgp_message,
  intptr_t pgp_message_len
);
FFI_PLUGIN_EXPORT struct DecryptMessageResult decrypt_message(
  const char* data_sender_armored_public_key,
  const char* data_receiver_armored_private_key,
  const uint8_t* pgp_message,
  intptr_t pgp_message_len
) {
  return rust_decrypt_message(
    data_sender_armored_public_key,
    data_receiver_armored_private_key,
    pgp_message,
    pgp_message_len
  );
}

extern void rust_decrypt_message_free_result(
  struct DecryptMessageResult result
);
FFI_PLUGIN_EXPORT void decrypt_message_free_result(
  struct DecryptMessageResult result
) {
  rust_decrypt_message_free_result(result);
}
