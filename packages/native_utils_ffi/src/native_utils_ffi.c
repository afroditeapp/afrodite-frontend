#include "native_utils_ffi.h"

// Make sure that required symbols are not removed
void do_not_call() {
  generate_content_encryption_key(0, 0);
  encrypt_content(0, 0, 0, 0);
  decrypt_content(0, 0, 0, 0);
  struct GenerateMessageKeysResult generateMessageKeysResult = generate_message_keys(0);
  generate_message_keys_free_result(generateMessageKeysResult);
  struct BinaryDataResult encryptMessageResult = encrypt_message(0, 0, 0, 0, 0, 0);
  free_binary_data_result(encryptMessageResult);
  struct BinaryDataResult decryptMessageResult = decrypt_message(0, 0, 0, 0, 0, 0);
  free_binary_data_result(decryptMessageResult);
}
