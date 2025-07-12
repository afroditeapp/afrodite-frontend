
use pgp::{composed::Message};

use super::MessageEncryptionError;

pub fn get_message_content(
    pgp_message: &[u8],
) -> Result<Vec<u8>, MessageEncryptionError> {
    Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::GetMessageContentMessageParse)?
        .as_data_vec()
        .map_err(|_| MessageEncryptionError::GetMessageContentAsDataVec)
}
