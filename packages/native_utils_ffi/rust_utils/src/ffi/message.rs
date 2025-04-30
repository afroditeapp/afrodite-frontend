use std::{ffi::{c_char, CStr}, ptr::null};

use crate::message::{content, decrypt, encrypt, key, MessageEncryptionError};

use super::API_OK;

#[repr(C)]
pub struct BinaryDataResult2 {
    pub result: isize,
    pub first_data: BinaryData,
    pub second_data: BinaryData,
}

impl BinaryDataResult2 {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            first_data: BinaryData::error(),
            second_data: BinaryData::error(),
        }
    }

    pub fn success(first: Vec<u8>, second: Vec<u8>) -> Self {
        let first = match BinaryDataBuilder::new(first) {
            Ok(v) => v,
            Err(e) => return Self::error(e),
        };

        let second = match BinaryDataBuilder::new(second) {
            Ok(v) => v,
            Err(e) => return Self::error(e),
        };

        Self {
            result: API_OK,
            first_data: first.build(),
            second_data: second.build(),
        }
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn free_binary_data_result_2(
    result: BinaryDataResult2,
) {
    result.first_data.free();
    result.second_data.free();
}

/// First result value is public key and second is private key.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn generate_message_keys(
    account_id: *const c_char,
) -> BinaryDataResult2 {
    assert!(!account_id.is_null());

    let account_id = unsafe {
        CStr::from_ptr(account_id)
            .to_str()
            .expect("Account ID contains non UTF-8 data")
    };

    match key::generate_keys(account_id.to_string()) {
        Ok((public, private)) =>
            BinaryDataResult2::success(public.value, private.value),
        Err(e) => BinaryDataResult2::error(e)
    }
}

#[repr(C)]
pub struct BinaryData {
    /// Null if failure
    pub data: *const u8,
    pub len: isize,
    pub capacity: isize,
}

impl BinaryData {
    pub fn error() -> Self {
        Self {
            data: null(),
            len: 0,
            capacity: 0,
        }
    }

    pub fn free(self) {
        unsafe {
            if !self.data.is_null() {
                let _ = Vec::from_raw_parts(
                    self.data as *mut u8,
                    self.len as usize,
                    self.capacity as usize,
                );
            }
        }
    }
}

struct BinaryDataBuilder {
    data: Vec<u8>,
    len: isize,
    capacity: isize,
}

impl BinaryDataBuilder {
    fn new(data: Vec<u8>) -> Result<Self, MessageEncryptionError> {
        let len: isize = data.len().try_into()
            .map_err(|_| MessageEncryptionError::BinaryDataLenTooLarge)?;

        let capacity: isize = data.capacity().try_into()
            .map_err(|_| MessageEncryptionError::BinaryDataCapacityTooLarge)?;

        Ok(Self {
            data,
            len,
            capacity,
        })
    }

    fn build(self) -> BinaryData {
        let data = BinaryData {
            data: self.data.as_ptr(),
            len: self.len,
            capacity: self.capacity,
        };

        std::mem::forget(self.data);

        data
    }
}

#[repr(C)]
pub struct BinaryDataResult {
    pub result: isize,
    pub data: BinaryData,
}

impl BinaryDataResult {
    pub fn error(e: MessageEncryptionError) -> Self {
        Self {
            result: e.into(),
            data: BinaryData::error(),
        }
    }

    pub fn success(data: Vec<u8>) -> Self {
        let builder = match BinaryDataBuilder::new(data) {
            Ok(v) => v,
            Err(e) => return Self::error(e),
        };

        Self {
            result: API_OK,
            data: builder.build(),
        }
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn free_binary_data_result(
    result: BinaryDataResult,
) {
    result.data.free();
}

/// First result value is PGP message and second is session key.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn encrypt_message(
    sender_private_key: *const u8,
    sender_private_key_len: isize,
    receiver_public_key: *const u8,
    receiver_public_key_len: isize,
    data: *const u8,
    data_len: isize,
) -> BinaryDataResult2 {
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
        Ok((message, session_key)) => {
            BinaryDataResult2::success(message, session_key)
        }
        Err(e) => BinaryDataResult2::error(e)
    }
}

/// First result value is message data and second is session key.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn decrypt_message(
    sender_public_key: *const u8,
    sender_public_key_len: isize,
    receiver_private_key: *const u8,
    receiver_private_key_len: isize,
    pgp_message: *const u8,
    pgp_message_len: isize,
) -> BinaryDataResult2 {
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
        Ok((data, session_key)) => BinaryDataResult2::success(data, session_key),
        Err(e) => BinaryDataResult2::error(e),
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn get_message_content(
    pgp_message: *const u8,
    pgp_message_len: isize,
) -> BinaryDataResult {
    assert!(!pgp_message.is_null());

    let pgp_message = unsafe {
        std::slice::from_raw_parts(pgp_message, pgp_message_len as usize)
    };

    match content::get_message_content(pgp_message) {
        Ok(data) => BinaryDataResult::success(data),
        Err(e) => BinaryDataResult::error(e),
    }
}
