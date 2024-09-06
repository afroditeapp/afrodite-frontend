use bstr::BStr;
use pgp::{ser::Serialize, Deserializable, Message, SignedPublicKey};
use rand::rngs::OsRng;

use super::MessageEncryptionError;

// TODO(prod): Check is it possible to enable AES GCM and data packet V2
//             creation. Current library version is missing support for
//             creating V2 data packets at least using the Message API.
// TODO(prod): Consider changing AES-256 to AES-128 for images.
//             SQLChipher uses AES-256.

pub fn encrypt_data(
    // The sender private key can be used for signing the message
    _data_sender_armored_private_key: &str,
    data_receiver_armored_public_key: &str,
    data: &[u8],
) -> Result<Vec<u8>, MessageEncryptionError> {
    // let (my_private_key, _) = SignedSecretKey::from_string(data_sender_armored_private_key)
    //     .map_err(|_| MessageEncryptionError::EncryptDataPrivateKeyParse)?;
    let (other_person_public_key, _) = SignedPublicKey::from_string(data_receiver_armored_public_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPublicKeyParse)?;

    let empty_file_name: &BStr = b"".into();

    let encryption_public_subkey = other_person_public_key.public_subkeys
        .first()
        .ok_or(MessageEncryptionError::EncryptDataPublicSubkeyMissing)?;

    let armored_message =
        Message::new_literal_bytes(empty_file_name, data)
            // Compression is not done for now as this library does not
            // have possibility to limit decompressed data size.
            // If the data would be compressed, then denial of service attacks
            // would be possible.
            .encrypt_to_keys(
                &mut OsRng,
                pgp::crypto::sym::SymmetricKeyAlgorithm::AES128,
                &[encryption_public_subkey],
            )
            .map_err(|_| MessageEncryptionError::EncryptDataEncrypt)?
            // .sign(&my_private_key, String::new, HashAlgorithm::SHA2_256)
            // .map_err(|_| MessageEncryptionError::EncryptDataSign)?
            .to_bytes()
            .map_err(|_| MessageEncryptionError::EncryptDataToBytes)?;

    Ok(armored_message)
}
