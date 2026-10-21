
use pgp::{composed::Message};
use wasm_bindgen::prelude::wasm_bindgen;

use super::NativeUtilsError;

#[wasm_bindgen]
pub fn get_message_content_rust(
    pgp_message: &[u8],
) -> Result<Vec<u8>, NativeUtilsError> {
    Message::from_bytes(pgp_message)
        .map_err(|_| NativeUtilsError::GetMessageContentMessageParse)?
        .as_data_vec()
        .map_err(|_| NativeUtilsError::GetMessageContentAsDataVec)
}
