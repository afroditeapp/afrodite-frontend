
use pgp::composed::{EncryptionCaps, KeyType, SecretKeyParamsBuilder, SubkeyParamsBuilder};
use pgp::ser::Serialize;
use pgp::crypto::{sym::SymmetricKeyAlgorithm, hash::HashAlgorithm};
use rand::rngs::OsRng;
use smallvec::smallvec;
use wasm_bindgen::prelude::wasm_bindgen;

use super::MessageEncryptionError;

#[wasm_bindgen(getter_with_clone)]
pub struct KeyPairBytes {
    pub public: Vec<u8>,
    pub private: Vec<u8>,
}

#[wasm_bindgen]
pub fn generate_message_keys_rust(
    account_id: String,
) -> Result<KeyPairBytes, MessageEncryptionError>  {
    let params = SecretKeyParamsBuilder::default()
        .key_type(KeyType::Ed25519)
        .can_encrypt(EncryptionCaps::None)
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
                .can_encrypt(EncryptionCaps::Communication)
                .can_sign(false)
                .build()
                .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeySubKeyParams)?
        )
        .build()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyParams)?;
    let private_key = params
        .generate(OsRng)
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyGenerate)?;
    let private_key_bytes = private_key
        .to_bytes()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyToBytes)?;

    let public_key_bytes = private_key
        .to_public_key()
        .to_bytes()
        .map_err(|_| MessageEncryptionError::GenerateKeysPublicKeyToBytes)?;

    Ok(
        KeyPairBytes {
            public: public_key_bytes,
            private: private_key_bytes,
        }
    )
}
