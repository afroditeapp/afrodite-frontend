
use pgp::composed::{KeyType, key::SecretKeyParamsBuilder};
use pgp::crypto::ecc_curve::ECCCurve;
use pgp::ser::Serialize;
use pgp::types::SecretKeyTrait;
use pgp::crypto::{sym::SymmetricKeyAlgorithm, hash::HashAlgorithm};
use pgp::SubkeyParamsBuilder;
use smallvec::smallvec;

use super::MessageEncryptionError;

pub struct PublicKeyBytes {
    pub value: Vec<u8>,
}

pub struct PrivateKeyBytes {
    pub value: Vec<u8>,
}

pub fn generate_keys(
    // Not used at the moment
    _account_id: String,
) -> Result<(PublicKeyBytes, PrivateKeyBytes), MessageEncryptionError>  {
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
    //
    // 2024-08-07
    // Message byte size comparison
    //
    // Current implementaton has RSA with 3072 key size, SHA2-256, AES-256.
    // Message content is 4 bytes and it is encrypted, signed and armored.
    // Byte count for the armored message is 1292.
    //
    // Byte count with differences
    // - AES-128: 1292 bytes
    // - AES-128, no signing: 679 bytes
    // - AES-256, no signing: 679 bytes
    // - AES-256, no signing, RSA with key size 2048: 504 bytes
    // - AES-128, no signing, RSA with key size 2048: 504 bytes
    // - AES-128, no signing, ECDSA and ECHD with curve P256: 309 bytes
    // - AES-256, no signing, ECDSA and ECHD with curve P256: 309 bytes
    //
    // 2024-08-08
    //
    // As the primary purpose of the end-to-end encryption for messages
    // currently is to avoid storing plaintext messages on server, the
    // encrypted message size is prioritized.
    //
    // The asymmetric encryption algorithm will be changed to NIST P-256
    // which offers possibility for small encrypted messages and it is
    // currently secure. There has not been security review for the Rust
    // implementation for that algorithm but that is not important for the
    // current use case.
    //
    // https://www.rfc-editor.org/rfc/rfc6637#section-12.2.1
    // The NIST P-256 offers 128-bit security so let's select AES-128 and
    // SHA2-256 which are in 128-bit security category.
    //
    // Also the message signing is not needed as it is assumed that
    // server will not be compromised and it is not possible to send
    // messages which would be from other account than the current one.
    //
    // 2024-09-22
    //
    // Current message size for decryptMessage with 1 byte character: 183 bytes.
    //
    // Message size with changes to code:
    // Message signing added: 317 bytes
    // Message signing added, empty primary user ID: 317 bytes
    // Message signing added, empty primary user ID, no preferred algorithms: 317 bytes
    //
    // The key user ID is removed as OpenPGP does not require it and server
    // does not validate it. Also message signing is added to prevent receiving
    // messages without warning from someone who has access to the server.

    let params = SecretKeyParamsBuilder::default()
        .key_type(KeyType::ECDSA(ECCCurve::P256))
        .can_encrypt(false)
        .can_certify(false)
        .can_sign(true)
        .primary_user_id("".to_string())
        .preferred_symmetric_algorithms(smallvec![
            SymmetricKeyAlgorithm::AES128,
        ])
        .preferred_hash_algorithms(smallvec![
            HashAlgorithm::SHA2_256,
        ])
        .preferred_compression_algorithms(smallvec![])
        .subkey(
            SubkeyParamsBuilder::default()
                .key_type(KeyType::ECDH(ECCCurve::P256))
                .can_authenticate(false)
                .can_certify(false)
                .can_encrypt(true)
                .can_sign(false)
                .build()
                .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeySubKeyParams)?
        )
        .build()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyParams)?;
    let private_key = params
        .generate()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyGenerate)?;
    let signed_private_key = private_key
        .sign(String::new)
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeySign)?;
    let private_key = signed_private_key
        .to_bytes()
        .map_err(|_| MessageEncryptionError::GenerateKeysPrivateKeyToBytes)?;

    let signed_public_key = signed_private_key
        .public_key()
        .sign(&signed_private_key, String::new)
        .map_err(|_| MessageEncryptionError::GenerateKeysPublicKeySign)?;
    let public_key = signed_public_key
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
