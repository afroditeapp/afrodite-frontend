//! Message encryption


pub mod key;
pub mod decrypt;
pub mod encrypt;
pub mod content;

#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(u8)]
pub enum MessageEncryptionError {
    // Generate keys
    GenerateKeysPrivateKeyParams = 1,
    GenerateKeysPrivateKeySubKeyParams = 2,
    GenerateKeysPrivateKeyGenerate = 3,
    GenerateKeysPrivateKeySign = 4,
    GenerateKeysPrivateKeyToBytes = 5,
    GenerateKeysPublicKeySign = 6,
    GenerateKeysPublicKeyToBytes = 7,
    // Encrypt data
    EncryptDataPrivateKeyParse = 20,
    EncryptDataPublicKeyParse = 21,
    EncryptDataEncrypt = 22,
    EncryptDataSign = 23,
    EncryptDataToBytes = 24,
    EncryptDataPublicSubkeyMissing = 25,
    // Binary data
    BinaryDataLenTooLarge = 30,
    BinaryDataCapacityTooLarge = 31,
    // Decrypt data
    DecryptDataPrivateKeyParse = 40,
    DecryptDataPublicKeyParse = 41,
    DecryptDataMessageParse = 42,
    DecryptDataVerify = 43,
    DecryptDataDecrypt = 44,
    DecryptDataDataNotFound = 45,
    DecryptDataUnsupportedSessionKeyVersion = 46,
    // Get message content
    GetMessageContentMessageParse = 50,
    GetMessageContentGetContent = 51,
    GetMessageContentNoContent = 52,
}

impl From<MessageEncryptionError> for isize {
    fn from(value: MessageEncryptionError) -> Self {
        value as isize
    }
}
