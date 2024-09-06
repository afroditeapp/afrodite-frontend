use std::{ffi::{c_char, CStr, CString}, ptr::null};

use crate::message::{decrypt::decrypt_data, encrypt::encrypt_data, key::generate_keys, MessageEncryptionError};

use super::API_OK;

#[repr(C)]
pub struct GenerateMessageKeysResult {
    pub result: isize,
    /// Null if failure
    pub public_key: *const c_char,
    /// Null if failure
    pub private_key: *const c_char,
}

impl GenerateMessageKeysResult {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            public_key: null(),
            private_key: null(),
        }
    }

    pub fn success(public: CString, private: CString) -> Self {
        Self {
            result: API_OK,
            public_key: public.into_raw(),
            private_key: private.into_raw(),
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn rust_generate_message_keys(
    account_id: *const c_char,
) -> GenerateMessageKeysResult {
    assert!(!account_id.is_null());

    let account_id = unsafe {
        CStr::from_ptr(account_id)
            .to_str()
            .expect("Account ID contains non UTF-8 data")
    };

    match generate_keys(account_id.to_string()) {
        Ok((public, private)) => {
            let public = match CString::new(public.value) {
                Ok(public) => public,
                Err(_) => return GenerateMessageKeysResult::error(MessageEncryptionError::GenerateKeysPublicKeyNullDetected),
            };

            let private = match CString::new(private.value) {
                Ok(private) => private,
                Err(_) => return GenerateMessageKeysResult::error(MessageEncryptionError::GenerateKeysPrivateKeyNullDetected),
            };

            GenerateMessageKeysResult::success(public, private)
        }
        Err(e) => GenerateMessageKeysResult::error(e)
    }
}

#[no_mangle]
pub unsafe extern "C" fn rust_generate_message_keys_free_result(
    result: GenerateMessageKeysResult,
) {
    unsafe {
        if !result.public_key.is_null() {
            let _ = CString::from_raw(result.public_key as *mut c_char);
        }

        if !result.private_key.is_null() {
            let _ = CString::from_raw(result.private_key as *mut c_char);
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

#[no_mangle]
pub unsafe extern "C" fn rust_encrypt_message(
    data_sender_armored_private_key: *const c_char,
    data_receiver_armored_public_key: *const c_char,
    data: *const u8,
    data_len: isize,
) -> EncryptMessageResult {
    assert!(!data_sender_armored_private_key.is_null());
    assert!(!data_receiver_armored_public_key.is_null());

    let data_sender_armored_private_key = unsafe {
        CStr::from_ptr(data_sender_armored_private_key)
            .to_str()
            .expect("Encrypt message: data sender private key contains non UTF-8 data")
    };

    let data_receiver_armored_public_key = unsafe {
        CStr::from_ptr(data_receiver_armored_public_key)
            .to_str()
            .expect("Encrypt message: data receiver public key contains non UTF-8 data")
    };

    let data = std::slice::from_raw_parts(data, data_len as usize);

    match encrypt_data(data_sender_armored_private_key, data_receiver_armored_public_key, data) {
        Ok(message) => {
            EncryptMessageResult::success(message)
        }
        Err(e) => EncryptMessageResult::error(e)
    }
}

#[no_mangle]
pub unsafe extern "C" fn rust_encrypt_message_free_result(
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


#[no_mangle]
pub unsafe extern "C" fn rust_decrypt_message(
    data_sender_armored_public_key: *const c_char,
    data_receiver_armored_private_key: *const c_char,
    pgp_message: *const u8,
    pgp_message_len: isize,
) -> DecryptMessageResult {
    assert!(!data_sender_armored_public_key.is_null());
    assert!(!data_receiver_armored_private_key.is_null());
    assert!(!pgp_message.is_null());

    let data_sender_armored_public_key = unsafe {
        CStr::from_ptr(data_sender_armored_public_key)
            .to_str()
            .expect("Decrypt message: data sender public key contains non UTF-8 data")
    };

    let data_receiver_armored_private_key = unsafe {
        CStr::from_ptr(data_receiver_armored_private_key)
            .to_str()
            .expect("Decrypt message: data receiver private key contains non UTF-8 data")
    };

    let pgp_message = unsafe {
        std::slice::from_raw_parts(pgp_message, pgp_message_len as usize)
    };

    match decrypt_data(data_sender_armored_public_key, data_receiver_armored_private_key, pgp_message) {
        Ok(data) => DecryptMessageResult::success(data),
        Err(e) => DecryptMessageResult::error(e),
    }
}

#[no_mangle]
pub unsafe extern "C" fn rust_decrypt_message_free_result(
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
