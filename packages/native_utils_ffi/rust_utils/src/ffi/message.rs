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
pub struct BinaryDataResult {
    pub result: isize,
    /// Null if failure
    pub data: *const u8,
    pub data_len: isize,
    pub data_capacity: isize,
}

impl BinaryDataResult {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            data: null(),
            data_len: 0,
            data_capacity: 0,
        }
    }

    pub fn success(data: Vec<u8>) -> Self {
        let data_len: isize = match data.len().try_into() {
            Ok(len) => len,
            Err(_) => return Self::error(MessageEncryptionError::BinaryDataResultLenTooLarge),
        };

        let data_capacity: isize = match data.capacity().try_into() {
            Ok(capacity) => capacity,
            Err(_) => return Self::error(MessageEncryptionError::BinaryDataResultCapacityTooLarge),
        };

        let result = Self {
            result: API_OK,
            data: data.as_ptr(),
            data_len,
            data_capacity,
        };

        std::mem::forget(data);

        result
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn free_binary_data_result(
    result: BinaryDataResult,
) {
    unsafe {
        if !result.data.is_null() {
            let _ = Vec::from_raw_parts(
                result.data as *mut u8,
                result.data_len as usize,
                result.data_capacity as usize,
            );
        }
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
) -> BinaryDataResult {
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
            BinaryDataResult::success(message)
        }
        Err(e) => BinaryDataResult::error(e)
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
) -> BinaryDataResult {
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
        Ok(data) => BinaryDataResult::success(data),
        Err(e) => BinaryDataResult::error(e),
    }
}
