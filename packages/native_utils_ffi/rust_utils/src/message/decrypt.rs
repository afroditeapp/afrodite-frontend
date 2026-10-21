
use pgp::{composed::{Deserializable, Esk, Message, PlainSessionKey, SignedPublicKey, SignedSecretKey}, packet::PublicKeyEncryptedSessionKey, types::{DecryptionKey, EskType, Password}};
use wasm_bindgen::prelude::wasm_bindgen;

use crate::error::NativeUtilsError;

#[wasm_bindgen(getter_with_clone)]
pub struct DecryptingOutput {
    pub data: Vec<u8>,
    pub session_key: Vec<u8>,
}

#[wasm_bindgen]
pub fn decrypt_data_rust(
    // Sender public key can be used for message verification
    sender_public_key: &[u8],
    recipient_private_key: &[u8],
    pgp_message: &[u8],
) -> Result<DecryptingOutput, NativeUtilsError> {
    let sender_public_key = SignedPublicKey::from_bytes(sender_public_key)
        .map_err(|_| NativeUtilsError::DecryptDataPublicKeyParse)?;
    let recipient_private_key = SignedSecretKey::from_bytes(recipient_private_key)
        .map_err(|_| NativeUtilsError::DecryptDataPrivateKeyParse)?;
    let Some(recipient_private_subkey) = recipient_private_key.secret_subkeys.first() else {
        return Err(NativeUtilsError::DecryptDataUnsupportedPrivateKey);
    };

    let m = Message::from_bytes(pgp_message)
        .map_err(|_| NativeUtilsError::DecryptDataMessageParse)?;

    let session_key = if let Message::Encrypted { esk, .. } = &m {
        if let Some(Esk::PublicKeyEncryptedSessionKey(
                PublicKeyEncryptedSessionKey::V6 { values, .. }
        )) = esk.first() {
            recipient_private_subkey.decrypt(&Password::empty(), values, EskType::V6)
                .map_err(|_| NativeUtilsError::DecryptDataSessionKeyDecryptionError1)?
                .map_err(|_| NativeUtilsError::DecryptDataSessionKeyDecryptionError2)?
        } else {
            return Err(NativeUtilsError::DecryptDataUnsupportedSessionKey);
        }
    } else {
        return Err(NativeUtilsError::DecryptDataMessageUnsupported);
    };

    let mut m = m.decrypt_with_session_key(session_key.clone())
        .map_err(|_| NativeUtilsError::DecryptDataDecrypt)?;

    let data = m
        .as_data_vec()
        .map_err(|_| NativeUtilsError::DecryptDataAsDataVec)?;

    m
        .verify_read(&sender_public_key)
        .map_err(|_| NativeUtilsError::DecryptDataVerify)?;

    match &session_key {
        PlainSessionKey::V3_4 { .. } |
        PlainSessionKey::V5 { .. } =>
            Err(NativeUtilsError::DecryptDataUnsupportedSessionKeyVersion),
        PlainSessionKey::V6 { key } =>
            Ok(DecryptingOutput {
                data: data.to_vec(),
                session_key: key.as_ref().to_vec(),
            })
    }
}
