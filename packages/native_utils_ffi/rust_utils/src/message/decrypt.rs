
use pgp::{composed::{Deserializable, Esk, Message, PlainSessionKey, SignedPublicKey, SignedSecretKey}, packet::PublicKeyEncryptedSessionKey, types::{EskType, Password}};

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
    let Some(receiver_private_subkey) = receiver_private_key.secret_subkeys.first() else {
        return Err(MessageEncryptionError::DecryptDataUnsupportedPrivateKey);
    };

    let m = Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::DecryptDataMessageParse)?;

    let session_key = if let Message::Encrypted { esk, .. } = &m {
        if let Some(Esk::PublicKeyEncryptedSessionKey(
                PublicKeyEncryptedSessionKey::V6 { values, .. }
        )) = esk.first() {
            receiver_private_subkey.decrypt_session_key(&Password::empty(), values, EskType::V6)
                .map_err(|_| MessageEncryptionError::DecryptDataSessionKeyDecryptionError1)?
                .map_err(|_| MessageEncryptionError::DecryptDataSessionKeyDecryptionError2)?
        } else {
            return Err(MessageEncryptionError::DecryptDataUnsupportedSessionKey);
        }
    } else {
        return Err(MessageEncryptionError::DecryptDataMessageUnsupported);
    };

    let mut m = m.decrypt_with_session_key(session_key.clone())
        .map_err(|_| MessageEncryptionError::DecryptDataDecrypt)?;

    let data = m
        .as_data_vec()
        .map_err(|_| MessageEncryptionError::DecryptDataAsDataVec)?;

    m
        .verify_read(&sender_public_key)
        .map_err(|_| MessageEncryptionError::DecryptDataVerify)?;

    match &session_key {
        PlainSessionKey::V3_4 { .. } |
        PlainSessionKey::V5 { .. } |
        PlainSessionKey::Unknown { .. } =>
            Err(MessageEncryptionError::DecryptDataUnsupportedSessionKeyVersion),
        PlainSessionKey::V6 { key } =>
            Ok((
                data.to_vec(),
                key.clone()
            ))
    }
}
