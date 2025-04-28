
use pgp::{Deserializable, Message};

use super::MessageEncryptionError;

pub fn get_message_content(
    pgp_message: &[u8],
) -> Result<Vec<u8>, MessageEncryptionError> {
    let m = Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::GetMessageContentMessageParse)?;
    m.get_content()
        .map_err(|_| MessageEncryptionError::GetMessageContentGetContent)?
        .ok_or(MessageEncryptionError::GetMessageContentNoContent)
}
