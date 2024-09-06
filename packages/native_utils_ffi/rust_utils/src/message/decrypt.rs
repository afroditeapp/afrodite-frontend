
use pgp::{Deserializable, Message, SignedSecretKey};

use super::MessageEncryptionError;

pub fn decrypt_data(
    // Sender public key can be used for message verification
    _data_sender_armored_public_key: &str,
    data_receiver_armored_private_key: &str,
    pgp_message: &[u8],
) -> Result<Vec<u8>, MessageEncryptionError> {
    // let (data_sender_public_key, _) = SignedPublicKey::from_string(data_sender_armored_public_key)
    //     .map_err(|_| MessageEncryptionError::DecryptDataPublicKeyParse)?;
    let (data_receiver_private_key, _) = SignedSecretKey::from_string(data_receiver_armored_private_key)
        .map_err(|_| MessageEncryptionError::DecryptDataPrivateKeyParse)?;

    let m = Message::from_bytes(pgp_message)
        .map_err(|_| MessageEncryptionError::DecryptDataMessageParse)?;
    // m.verify(&data_sender_public_key)
    //     .map_err(|_| MessageEncryptionError::DecryptDataVerify)?;
    let (m, _) = m.decrypt(String::new, &[&data_receiver_private_key])
        .map_err(|_| MessageEncryptionError::DecryptDataDecrypt)?;

    let data = m.get_literal().ok_or(MessageEncryptionError::DecryptDataDataNotFound)?.data();

    Ok(data.to_vec())
}
