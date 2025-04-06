
use pgp::{Deserializable, Message, SignedPublicKey, SignedSecretKey};

use super::MessageEncryptionError;

pub fn decrypt_data(
    // Sender public key can be used for message verification
    sender_public_key: &[u8],
    receiver_private_key: &[u8],
    pgp_message: &[u8],
) -> Result<Vec<u8>, MessageEncryptionError> {
    let sender_public_key = SignedPublicKey::from_bytes(sender_public_key)
        .map_err(|_| MessageEncryptionError::DecryptDataPublicKeyParse)?;
    let receiver_private_key = SignedSecretKey::from_bytes(receiver_private_key)
        .map_err(|_| MessageEncryptionError::DecryptDataPrivateKeyParse)?;

    let m = Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::DecryptDataMessageParse)?;
    m.verify(&sender_public_key)
        .map_err(|_| MessageEncryptionError::DecryptDataVerify)?;
    let (m, _) = m.decrypt(String::new, &[&receiver_private_key])
        .map_err(|_| MessageEncryptionError::DecryptDataDecrypt)?;

    let data = m.get_literal().ok_or(MessageEncryptionError::DecryptDataDataNotFound)?.data();

    Ok(data.to_vec())
}
