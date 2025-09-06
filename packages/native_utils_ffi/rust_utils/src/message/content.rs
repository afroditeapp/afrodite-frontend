
use pgp::{composed::Message};
use wasm_bindgen::prelude::wasm_bindgen;

use super::MessageEncryptionError;

#[wasm_bindgen]
pub fn get_message_content_rust(
    pgp_message: &[u8],
) -> Result<Vec<u8>, MessageEncryptionError> {
    Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::GetMessageContentMessageParse)?
        .as_data_vec()
        .map_err(|_| MessageEncryptionError::GetMessageContentAsDataVec)
}
