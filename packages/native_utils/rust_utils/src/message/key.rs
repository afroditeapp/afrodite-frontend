
use pgp::composed::{KeyType, key::SecretKeyParamsBuilder};
use pgp::types::{SecretKeyTrait, CompressionAlgorithm};
use pgp::crypto::{sym::SymmetricKeyAlgorithm, hash::HashAlgorithm};
use pgp::ArmorOptions;
use smallvec::smallvec;

use super::MessageEncryptionError;

pub struct PublicKeyString {
    pub value: String,
}

pub struct PrivateKeyString {
    pub value: String,
}

pub fn generate_keys(account_id: String) -> Result<(PublicKeyString, PrivateKeyString), MessageEncryptionError>  {
    // 2024-08-02
    // Some reasons for current algorithms
    //
    // RSA
    // - Rust implementation has been security reviewed.
    // - Marvin attack is not possible to exploit as there
    //   is no message read status support in the app.
    // - Delta Chat seems to use RSA.
    //   https://github.com/deltachat/deltachat-core-rust/pull/5054
    // - rfc9580 has minimum key lenght 3072 for RSA keys.
    // - Easy to implement because RSA key can be used for both encrypting
    //   and signing.
    // - rfc9580 non deprecated elliptic crypto Rust implementations seems
    //   not ready for production use (no security reviews and not
    //   that popular).
    // SHA2-256
    // - Widely used version.
    // - Recommended hash size when using RSA key 3072.
    //   https://datatracker.ietf.org/doc/html/rfc4880#section-14
    // AES-256
    // - Default in GnuPG.
    // - SQLCipher uses it.
    //   https://github.com/sqlcipher/sqlcipher/blob/master/README.md

    let params = SecretKeyParamsBuilder::default()
        .key_type(KeyType::Rsa(3072))
        .can_encrypt(true)
        .can_certify(true)
        .can_sign(true)
        .primary_user_id(account_id)
        .preferred_symmetric_algorithms(smallvec![
            SymmetricKeyAlgorithm::AES256,
        ])
        .preferred_hash_algorithms(smallvec![
            HashAlgorithm::SHA2_256,
        ])
        .preferred_compression_algorithms(smallvec![
            CompressionAlgorithm::ZLIB,
        ])
        .build()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyParams)?;
    let private_key = params
        .generate()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyGenerate)?;
    let signed_private_key = private_key
        .sign(String::new)
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeySign)?;
    let armored_private_key = signed_private_key
            .to_armored_string(ArmorOptions::default())
            .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyArmor)?;

    let signed_public_key = signed_private_key
        .public_key()
        .sign(&signed_private_key, String::new)
        .map_err(|_| MessageEncryptionError::GenerateKeysPublicKeySign)?;
    let armored_public_key = signed_public_key
        .to_armored_string(ArmorOptions::default())
        .map_err(|_| MessageEncryptionError::GenerateKeysPublicKeyArmor)?;

    Ok((
        PublicKeyString {
            value: armored_public_key,
        },
        PrivateKeyString {
            value: armored_private_key,
        }
    ))
}
