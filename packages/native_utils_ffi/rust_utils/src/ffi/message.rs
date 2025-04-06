use std::{ffi::{c_char, CStr}, ptr::null};

use crate::message::{decrypt, encrypt, key::{self, PrivateKeyBytes, PublicKeyBytes}, MessageEncryptionError};

use super::API_OK;

#[repr(C)]
pub struct GenerateMessageKeysResult {
    pub result: isize,
    /// Null if failure
    pub public_key: *const u8,
    pub public_key_len: isize,
    pub public_key_capacity: isize,
    /// Null if failure
    pub private_key: *const u8,
    pub private_key_len: isize,
    pub private_key_capacity: isize,
}

impl GenerateMessageKeysResult {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            public_key: null(),
            public_key_len: 0,
            public_key_capacity: 0,
            private_key: null(),
            private_key_len: 0,
            private_key_capacity: 0,
        }
    }

    pub fn success(public: PublicKeyBytes, private: PrivateKeyBytes) -> Self {
        let public = public.value;

        let public_key_len: isize = match public.len().try_into() {
            Ok(len) => len,
            Err(_) => return Self::error(MessageEncryptionError::GenerateKeysPublicKeyLenTooLarge),
        };

        let public_key_capacity: isize = match public.capacity().try_into() {
            Ok(capacity) => capacity,
            Err(_) => return Self::error(MessageEncryptionError::GenerateKeysPublicKeyCapacityTooLarge),
        };

        let private = private.value;

        let private_key_len: isize = match private.len().try_into() {
            Ok(len) => len,
            Err(_) => return Self::error(MessageEncryptionError::GenerateKeysPrivateKeyLenTooLarge),
        };

        let private_key_capacity: isize = match private.capacity().try_into() {
            Ok(capacity) => capacity,
            Err(_) => return Self::error(MessageEncryptionError::GenerateKeysPrivateKeyCapacityTooLarge),
        };

        let result = Self {
            result: API_OK,
            public_key: public.as_ptr(),
            public_key_len,
            public_key_capacity,
            private_key: private.as_ptr(),
            private_key_len,
            private_key_capacity,
        };

        std::mem::forget(public);
        std::mem::forget(private);

        result
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn generate_message_keys(
    account_id: *const c_char,
) -> GenerateMessageKeysResult {
    assert!(!account_id.is_null());

    let account_id = unsafe {
        CStr::from_ptr(account_id)
            .to_str()
            .expect("Account ID contains non UTF-8 data")
    };

    match key::generate_keys(account_id.to_string()) {
        Ok((public, private)) =>
            GenerateMessageKeysResult::success(public, private),
        Err(e) => GenerateMessageKeysResult::error(e)
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn generate_message_keys_free_result(
    result: GenerateMessageKeysResult,
) {
    unsafe {
        if !result.public_key.is_null() {
            let _ = Vec::from_raw_parts(
                result.public_key as *mut u8,
                result.public_key_len as usize,
                result.public_key_capacity as usize,
            );
        }
        if !result.private_key.is_null() {
            let _ = Vec::from_raw_parts(
                result.private_key as *mut u8,
                result.private_key_len as usize,
                result.private_key_capacity as usize,
            );
        }
    }
}

#[repr(C)]
pub struct EncryptMessageResult {
    pub result: isize,
    /// Null if failure
    pub encrypted_message: *const u8,
    pub encrypted_message_len: isize,
    pub encrypted_message_capacity: isize,
}

impl EncryptMessageResult {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            encrypted_message: null(),
            encrypted_message_len: 0,
            encrypted_message_capacity: 0,
        }
    }

    pub fn success(encrypted_message: Vec<u8>) -> Self {
        let encrypted_message_len: isize = match encrypted_message.len().try_into() {
            Ok(len) => len,
            Err(_) => return Self::error(MessageEncryptionError::EncryptDataEncryptedMessageLenTooLarge),
        };

        let encrypted_message_capacity: isize = match encrypted_message.capacity().try_into() {
            Ok(capacity) => capacity,
            Err(_) => return Self::error(MessageEncryptionError::EncryptDataEncryptedMessageCapacityTooLarge),
        };

        let result = Self {
            result: API_OK,
            encrypted_message: encrypted_message.as_ptr(),
            encrypted_message_len,
            encrypted_message_capacity,
        };

        std::mem::forget(encrypted_message);

        result
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn encrypt_message(
    sender_private_key: *const u8,
    sender_private_key_len: isize,
    receiver_public_key: *const u8,
    receiver_public_key_len: isize,
    data: *const u8,
    data_len: isize,
) -> EncryptMessageResult {
    assert!(!sender_private_key.is_null());
    assert!(!receiver_public_key.is_null());

    let sender_private_key = unsafe {
        std::slice::from_raw_parts(sender_private_key, sender_private_key_len as usize)
    };

    let receiver_public_key = unsafe {
        std::slice::from_raw_parts(receiver_public_key, receiver_public_key_len as usize)
    };

    let data = unsafe {
        std::slice::from_raw_parts(data, data_len as usize)
    };

    match encrypt::encrypt_data(sender_private_key, receiver_public_key, data) {
        Ok(message) => {
            EncryptMessageResult::success(message)
        }
        Err(e) => EncryptMessageResult::error(e)
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn encrypt_message_free_result(
    result: EncryptMessageResult,
) {
    unsafe {
        if !result.encrypted_message.is_null() {
            let _ = Vec::from_raw_parts(
                result.encrypted_message as *mut u8,
                result.encrypted_message_len as usize,
                result.encrypted_message_capacity as usize,
            );
        }
    }
}

#[repr(C)]
pub struct DecryptMessageResult {
    pub result: isize,
    /// Null if failure
    pub decrypted_message: *const u8,
    pub decrypted_message_len: isize,
    pub decrypted_message_capacity: isize,
}

impl DecryptMessageResult {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            decrypted_message: null(),
            decrypted_message_len: 0,
            decrypted_message_capacity: 0,
        }
    }

    pub fn success(decrypted_message: Vec<u8>) -> Self {
        let decrypted_message_len: isize = match decrypted_message.len().try_into() {
            Ok(len) => len,
            Err(_) => return Self::error(MessageEncryptionError::DecryptDataDecryptedMessageLenTooLarge),
        };

        let decrypted_message_capacity: isize = match decrypted_message.capacity().try_into() {
            Ok(capacity) => capacity,
            Err(_) => return Self::error(MessageEncryptionError::DecryptDataDecryptedMessageCapacityTooLarge),
        };

        let result = Self {
            result: API_OK,
            decrypted_message: decrypted_message.as_ptr(),
            decrypted_message_len,
            decrypted_message_capacity,
        };

        std::mem::forget(decrypted_message);

        result
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn decrypt_message(
    sender_public_key: *const u8,
    sender_public_key_len: isize,
    receiver_private_key: *const u8,
    receiver_private_key_len: isize,
    pgp_message: *const u8,
    pgp_message_len: isize,
) -> DecryptMessageResult {
    assert!(!sender_public_key.is_null());
    assert!(!receiver_private_key.is_null());
    assert!(!pgp_message.is_null());

    let sender_public_key = unsafe {
        std::slice::from_raw_parts(sender_public_key, sender_public_key_len as usize)
    };

    let receiver_private_key = unsafe {
        std::slice::from_raw_parts(receiver_private_key, receiver_private_key_len as usize)
    };

    let pgp_message = unsafe {
        std::slice::from_raw_parts(pgp_message, pgp_message_len as usize)
    };

    match decrypt::decrypt_data(sender_public_key, receiver_private_key, pgp_message) {
        Ok(data) => DecryptMessageResult::success(data),
        Err(e) => DecryptMessageResult::error(e),
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn decrypt_message_free_result(
    result: DecryptMessageResult,
) {
    unsafe {
        if !result.decrypted_message.is_null() {
            let _ = Vec::from_raw_parts(
                result.decrypted_message as *mut u8,
                result.decrypted_message_len as usize,
                result.decrypted_message_capacity as usize,
            );
        }
    }
}
