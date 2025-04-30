use bstr::BStr;
use pgp::{crypto::{aead::AeadAlgorithm, hash::HashAlgorithm, sym::SymmetricKeyAlgorithm}, ser::Serialize, Deserializable, Message, SignedPublicKey, SignedSecretKey};
use rand::rngs::OsRng;

use super::MessageEncryptionError;

// TODO(prod): Check is it possible to enable AES GCM and data packet V2
//             creation. Current library version is missing support for
//             creating V2 data packets at least using the Message API.
// TODO(prod): Consider changing AES-256 to AES-128 for images.
//             SQLChipher uses AES-256.

pub fn encrypt_data(
    // The sender private key can be used for signing the message
    sender_private_key: &[u8],
    receiver_public_key: &[u8],
    data: &[u8],
) -> Result<(Vec<u8>, Vec<u8>), MessageEncryptionError> {
    let my_private_key = SignedSecretKey::from_bytes(sender_private_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPrivateKeyParse)?;
    let other_person_public_key = SignedPublicKey::from_bytes(receiver_public_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPublicKeyParse)?;

    let empty_file_name: &BStr = b"".into();

    let encryption_public_subkey = other_person_public_key.public_subkeys
        .first()
        .ok_or(MessageEncryptionError::EncryptDataPublicSubkeyMissing)?;

    let (message, session_key) =
        Message::new_literal_bytes(empty_file_name, data)
            // Compression is not done for now as this library does not
            // have possibility to limit decompressed data size.
            // If the data would be compressed, then denial of service attacks
            // would be possible.
            .sign(OsRng, &my_private_key, String::new, HashAlgorithm::SHA2_256)
            .map_err(|_| MessageEncryptionError::EncryptDataSign)?
            .encrypt_to_keys_seipdv2_and_return_session_key(
                OsRng,
                SymmetricKeyAlgorithm::AES128,
                AeadAlgorithm::Gcm,
                // Use max chunk size as message size is small
                // and streaming decryption is not needed.
                16,
                &[encryption_public_subkey],
            )
            .map_err(|_| MessageEncryptionError::EncryptDataEncrypt)?;
    let message_bytes = message
        .to_bytes()
        .map_err(|_| MessageEncryptionError::EncryptDataToBytes)?;

    Ok((message_bytes, session_key.to_vec()))
}
