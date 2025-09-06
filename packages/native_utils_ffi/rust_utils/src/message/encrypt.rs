use pgp::{
    bytes::Bytes, composed::{Deserializable, MessageBuilder, SignedPublicKey, SignedSecretKey}, crypto::{aead::{AeadAlgorithm, ChunkSize}, hash::HashAlgorithm, sym::SymmetricKeyAlgorithm}, types::Password
};
use rand::rngs::OsRng;
use wasm_bindgen::prelude::wasm_bindgen;

use super::MessageEncryptionError;

#[wasm_bindgen(getter_with_clone)]
pub struct EncryptingOutput {
    pub message: Vec<u8>,
    pub session_key: Vec<u8>,
}

#[wasm_bindgen]
pub fn encrypt_data_rust(
    // The sender private key can be used for signing the message
    sender_private_key: &[u8],
    receiver_public_key: &[u8],
    data: Vec<u8>,
) -> Result<EncryptingOutput, MessageEncryptionError> {
    encrypt_data_internal(sender_private_key, receiver_public_key, data)
}

pub(crate) fn encrypt_data_internal(
    // The sender private key can be used for signing the message
    sender_private_key: &[u8],
    receiver_public_key: &[u8],
    data: impl Into<Bytes>,
) -> Result<EncryptingOutput, MessageEncryptionError> {
    let my_private_key = SignedSecretKey::from_bytes(sender_private_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPrivateKeyParse)?;
    let other_person_public_key = SignedPublicKey::from_bytes(receiver_public_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPublicKeyParse)?;

    let encryption_public_subkey = other_person_public_key.public_subkeys
        .first()
        .ok_or(MessageEncryptionError::EncryptDataPublicSubkeyMissing)?;
    // let data = Into::<Bytes>::into(data);
    let mut builder = MessageBuilder::from_bytes("", data);
    // Compression is not done for now as this library does not
    // have possibility to limit decompressed data size.
    // If the data would be compressed, then denial of service attacks
    // would be possible.
    builder.sign(
        &my_private_key.primary_key,
        Password::empty(),
        HashAlgorithm::Sha256,
    );
    let mut builder = builder.seipd_v2(
        OsRng,
        SymmetricKeyAlgorithm::AES128,
        AeadAlgorithm::Gcm,
        // Use max chunk size as message size is small
        // and streaming decryption is not needed.
        ChunkSize::C4MiB,
    );
    builder
        .encrypt_to_key(OsRng, encryption_public_subkey)
        .map_err(|_| MessageEncryptionError::EncryptDataEncrypt)?;

    let session_key = builder.session_key().to_vec();
    let mut message = vec![];

    builder
        .to_writer(OsRng, &mut message)
        .map_err(|_| MessageEncryptionError::EncryptDataToWriter)?;

    Ok(EncryptingOutput{ message, session_key })
}
