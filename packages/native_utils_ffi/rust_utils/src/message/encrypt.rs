use pgp::{
    bytes::Bytes, composed::{Deserializable, MessageBuilder, SignedPublicKey, SignedSecretKey}, crypto::{aead::{AeadAlgorithm, ChunkSize}, hash::HashAlgorithm, sym::SymmetricKeyAlgorithm}, types::Password
};
use rand::rngs::OsRng;

use super::MessageEncryptionError;

// TODO(prod): Consider changing AES-256 to AES-128 for images.
//             SQLChipher uses AES-256.

pub fn encrypt_data(
    // The sender private key can be used for signing the message
    sender_private_key: &[u8],
    receiver_public_key: &[u8],
    data: impl Into<Bytes>,
) -> Result<(Vec<u8>, Vec<u8>), MessageEncryptionError> {
    let my_private_key = SignedSecretKey::from_bytes(sender_private_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPrivateKeyParse)?;
    let other_person_public_key = SignedPublicKey::from_bytes(receiver_public_key)
        .map_err(|_| MessageEncryptionError::EncryptDataPublicKeyParse)?;

    let encryption_public_subkey = other_person_public_key.public_subkeys
        .first()
        .ok_or(MessageEncryptionError::EncryptDataPublicSubkeyMissing)?;

    let mut builder = MessageBuilder::from_bytes("", Into::<Bytes>::into(data));
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
    let mut output = vec![];

    builder
        .to_writer(OsRng, &mut output)
        .map_err(|_| MessageEncryptionError::EncryptDataToWriter)?;

    Ok((output, session_key))
}
