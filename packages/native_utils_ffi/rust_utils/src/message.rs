//! Message encryption

use wasm_bindgen::prelude::wasm_bindgen;

pub mod key;
pub mod decrypt;
pub mod encrypt;
pub mod content;

#[wasm_bindgen]
#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(u8)]
pub enum MessageEncryptionError {
    // Generate keys
    GenerateKeysPrivateKeyParams = 1,
    GenerateKeysPrivateKeySubKeyParams = 2,
    GenerateKeysPrivateKeyGenerate = 3,
    GenerateKeysPrivateKeySign = 4,
    GenerateKeysPrivateKeyToBytes = 5,
    GenerateKeysPublicKeyToBytes = 6,
    // Encrypt data
    EncryptDataPrivateKeyParse = 20,
    EncryptDataPublicKeyParse = 21,
    EncryptDataEncrypt = 22,
    EncryptDataToWriter = 23,
    EncryptDataPublicSubkeyMissing = 24,
    // Binary data
    BinaryDataLenTooLarge = 30,
    BinaryDataCapacityTooLarge = 31,
    // Decrypt data
    DecryptDataPrivateKeyParse = 40,
    DecryptDataPublicKeyParse = 41,
    DecryptDataMessageParse = 42,
    DecryptDataVerify = 43,
    DecryptDataDecrypt = 44,
    DecryptDataAsDataVec = 45,
    DecryptDataUnsupportedSessionKey = 46,
    DecryptDataSessionKeyDecryptionError1 = 47,
    DecryptDataSessionKeyDecryptionError2 = 48,
    DecryptDataMessageUnsupported = 49,
    DecryptDataUnsupportedSessionKeyVersion = 50,
    DecryptDataUnsupportedPrivateKey = 51,
    // Get message content
    GetMessageContentMessageParse = 60,
    GetMessageContentAsDataVec = 61,
}

impl From<MessageEncryptionError> for isize {
    fn from(value: MessageEncryptionError) -> Self {
        value as isize
    }
}
