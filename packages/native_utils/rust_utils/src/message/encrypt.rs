use bstr::BStr;
use pgp::{crypto::hash::HashAlgorithm, ArmorOptions, Deserializable, Message, SignedPublicKey, SignedSecretKey};
use rand::rngs::OsRng;

use super::MessageEncryptionError;

// TODO(prod): Check is it possible to enable AES GCM and data packet V2
//             creation. Current library version is missing support for
//             creating V2 data packets at least using the Message API.
// TODO(prod): Consider changing AES-256 to AES-128.

pub fn encrypt_data(
    data_sender_armored_private_key: &str,
    data_receiver_armored_public_key: &str,
    data: &[u8],
) -> Result<String, MessageEncryptionError> {
    let (my_private_key, _) = SignedSecretKey::from_string(data_sender_armored_private_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPrivateKeyParse)?;
    let (other_person_public_key, _) = SignedPublicKey::from_string(data_receiver_armored_public_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPublicKeyParse)?;

    let empty_file_name: &BStr = b"".into();
    let armored_message =
        Message::new_literal_bytes(empty_file_name, data)
            // Compression is done for now as this library does not
            // have possibility to limit decompressed data size.
            // If the data would be compressed, then denial of service attacks
            // would be possible.
            .encrypt_to_keys(
                &mut OsRng,
                pgp::crypto::sym::SymmetricKeyAlgorithm::AES256,
                &[&other_person_public_key],
            )
            .map_err(|_| MessageEncryptionError::EncryptDataEncrypt)?
            .sign(&my_private_key, String::new, HashAlgorithm::SHA2_256)
            .map_err(|_| MessageEncryptionError::EncryptDataSign)?
            .to_armored_string(ArmorOptions::default())
            .map_err(|_| MessageEncryptionError::EncryptDataArmor)?;

    Ok(armored_message)
}
