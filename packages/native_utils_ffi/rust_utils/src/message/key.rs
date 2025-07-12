
use pgp::composed::{KeyType, SecretKeyParamsBuilder, SubkeyParamsBuilder};
use pgp::ser::Serialize;
use pgp::types::Password;
use pgp::crypto::{sym::SymmetricKeyAlgorithm, hash::HashAlgorithm};
use rand::rngs::OsRng;
use smallvec::smallvec;

use super::MessageEncryptionError;

pub struct PublicKeyBytes {
    pub value: Vec<u8>,
}

pub struct PrivateKeyBytes {
    pub value: Vec<u8>,
}

pub fn generate_keys(
    account_id: String,
) -> Result<(PublicKeyBytes, PrivateKeyBytes), MessageEncryptionError>  {
    let params = SecretKeyParamsBuilder::default()
        .key_type(KeyType::Ed25519)
        .can_encrypt(false)
        .can_certify(false)
        .can_sign(true)
        .primary_user_id(account_id)
        .preferred_symmetric_algorithms(smallvec![
            SymmetricKeyAlgorithm::AES128,
        ])
        .preferred_hash_algorithms(smallvec![
            HashAlgorithm::Sha256,
        ])
        .preferred_compression_algorithms(smallvec![])
        .subkey(
            SubkeyParamsBuilder::default()
                .key_type(KeyType::X25519)
                .can_authenticate(false)
                .can_encrypt(true)
                .can_sign(false)
                .build()
                .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeySubKeyParams)?
        )
        .build()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyParams)?;
    let private_key = params
        .generate(OsRng)
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyGenerate)?;
    let signed_private_key = private_key
        .sign(OsRng, &Password::empty())
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeySign)?;
    let private_key = signed_private_key
        .to_bytes()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyToBytes)?;

    let public_key = signed_private_key
        .signed_public_key()
        .to_bytes()
        .map_err(|_| MessageEncryptionError::GenerateKeysPublicKeyToBytes)?;

    Ok((
        PublicKeyBytes {
            value: public_key,
        },
        PrivateKeyBytes {
            value: private_key,
        }
    ))
}
