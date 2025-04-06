//! Message encryption


pub mod key;
pub mod decrypt;
pub mod encrypt;

#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(u8)]
pub enum MessageEncryptionError {
    // Generate keys
    GenerateKeysPrivateKeyParams = 1,
    GenerateKeysPrivateKeySubKeyParams = 2,
    GenerateKeysPrivateKeyGenerate = 3,
    GenerateKeysPrivateKeySign = 4,
    GenerateKeysPrivateKeyToBytes = 5,
    GenerateKeysPrivateKeyLenTooLarge = 6,
    GenerateKeysPrivateKeyCapacityTooLarge = 7,
    GenerateKeysPublicKeySign = 8,
    GenerateKeysPublicKeyToBytes = 9,
    GenerateKeysPublicKeyLenTooLarge = 10,
    GenerateKeysPublicKeyCapacityTooLarge = 11,
    // Encrypt data
    EncryptDataPrivateKeyParse = 20,
    EncryptDataPublicKeyParse = 21,
    EncryptDataEncrypt = 22,
    EncryptDataSign = 23,
    EncryptDataToBytes = 24,
    EncryptDataPublicSubkeyMissing = 25,
    EncryptDataEncryptedMessageLenTooLarge = 26,
    EncryptDataEncryptedMessageCapacityTooLarge = 27,
    // Decrypt data
    DecryptDataPrivateKeyParse = 40,
    DecryptDataPublicKeyParse = 41,
    DecryptDataMessageParse = 42,
    DecryptDataVerify = 43,
    DecryptDataDecrypt = 44,
    DecryptDataDataNotFound = 45,
    DecryptDataDecryptedMessageLenTooLarge = 46,
    DecryptDataDecryptedMessageCapacityTooLarge = 47,
}

impl From<MessageEncryptionError> for isize {
    fn from(value: MessageEncryptionError) -> Self {
        value as isize
    }
}
