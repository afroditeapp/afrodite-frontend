//! Message encryption


pub mod key;
pub mod decrypt;
pub mod encrypt;

#[derive(Debug, Clone, Copy, PartialEq)]
#[repr(u8)]
pub enum MessageEncryptionError {
    GenerateKeysPrivateKeyParams = 1,
    GenerateKeysPrivateKeyGenerate = 2,
    GenerateKeysPrivateKeySign = 3,
    GenerateKeysPrivateKeyArmor = 4,
    GenerateKeysPrivateKeyNullDetected = 5,
    GenerateKeysPublicKeySign = 6,
    GenerateKeysPublicKeyArmor = 7,
    GenerateKeysPublicKeyNullDetected = 8,
    GenerateKeysPrivateKeySubKeyParams = 9,
    EncryptDataPrivateKeyParse = 10,
    EncryptDataPublicKeyParse = 11,
    EncryptDataEncrypt = 12,
    EncryptDataSign = 13,
    EncryptDataToBytes = 14,
    EncryptDataPublicSubkeyMissing = 15,
    EncryptDataEncryptedMessageLenTooLarge = 16,
    EncryptDataEncryptedMessageCapacityTooLarge = 17,
    DecryptDataPrivateKeyParse = 20,
    DecryptDataPublicKeyParse = 21,
    DecryptDataMessageParse = 22,
    DecryptDataVerify = 23,
    DecryptDataDecrypt = 24,
    DecryptDataDataNotFound = 25,
    DecryptDataDecryptedMessageLenTooLarge = 26,
    DecryptDataDecryptedMessageCapacityTooLarge = 27,
}

impl From<MessageEncryptionError> for isize {
    fn from(value: MessageEncryptionError) -> Self {
        value as isize
    }
}
