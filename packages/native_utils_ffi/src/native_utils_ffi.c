#include "native_utils_ffi.h"

// Make sure that required symbols are not removed
void do_not_call() {
  struct BinaryDataResult2 generateMessageKeysResult = generate_message_keys(0);
  free_binary_data_result_2(generateMessageKeysResult);
  struct BinaryDataResult2 encryptMessageResult = encrypt_message(0, 0, 0, 0, 0, 0);
  free_binary_data_result_2(encryptMessageResult);
  struct BinaryDataResult2 decryptMessageResult = decrypt_message(0, 0, 0, 0, 0, 0);
  free_binary_data_result_2(decryptMessageResult);
  struct BinaryDataResult getMessageContentResult = get_message_content(0, 0);
  free_binary_data_result(getMessageContentResult);
}
