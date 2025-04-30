
use pgp::{Deserializable, Message, PlainSessionKey, SignedPublicKey, SignedSecretKey};

use super::MessageEncryptionError;

pub fn decrypt_data(
    // Sender public key can be used for message verification
    sender_public_key: &[u8],
    receiver_private_key: &[u8],
    pgp_message: &[u8],
) -> Result<(Vec<u8>, Vec<u8>), MessageEncryptionError> {
    let sender_public_key = SignedPublicKey::from_bytes(sender_public_key)
        .map_err(|_| MessageEncryptionError::DecryptDataPublicKeyParse)?;
    let receiver_private_key = SignedSecretKey::from_bytes(receiver_private_key)
        .map_err(|_| MessageEncryptionError::DecryptDataPrivateKeyParse)?;

    let m = Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::DecryptDataMessageParse)?;
    let (m, _, session_key) = m.decrypt_and_return_session_key(String::new, &[&receiver_private_key])
        .map_err(|_| MessageEncryptionError::DecryptDataDecrypt)?;
    m.verify(&sender_public_key)
        .map_err(|_| MessageEncryptionError::DecryptDataVerify)?;

    let data = m.get_literal().ok_or(MessageEncryptionError::DecryptDataDataNotFound)?.data();

    match &session_key {
        PlainSessionKey::V3_4 { .. } |
        PlainSessionKey::V5 { .. } =>
            Err(MessageEncryptionError::DecryptDataUnsupportedSessionKeyVersion),
        PlainSessionKey::V6 { key } =>
            Ok((
                data.to_vec(),
                key.clone()
            ))
    }
}
