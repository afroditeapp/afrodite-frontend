use crate::{content::{decrypt_content, encrypt_content, generate_content_encryption_key}, ffi::CApiResult};

#[no_mangle]
pub unsafe extern "C" fn rust_generate_content_encryption_key(
    key: *mut u8,
    key_len: isize,
) -> isize {
    assert!(!key.is_null());
    assert!(key_len >= 0);
    generate_content_encryption_key(
        std::slice::from_raw_parts_mut(key, key_len as usize)
    ).to_c_api_result()
}

#[no_mangle]
pub unsafe extern "C" fn rust_encrypt_content(
    data: *mut u8,
    data_len: isize,
    key: *const u8,
    key_len: isize,
) -> isize {
    assert!(!data.is_null());
    assert!(data_len >= 0);
    assert!(!key.is_null());
    assert!(key_len >= 0);

    encrypt_content(
        std::slice::from_raw_parts_mut(data, data_len as usize),
        std::slice::from_raw_parts(key, key_len as usize),
    ).to_c_api_result()
}

#[no_mangle]
pub unsafe extern "C" fn rust_decrypt_content(
    data: *mut u8,
    data_len: isize,
    key: *const u8,
    key_len: isize,
) -> isize {
    assert!(!data.is_null());
    assert!(data_len >= 0);
    assert!(!key.is_null());
    assert!(key_len >= 0);

    decrypt_content(
        std::slice::from_raw_parts_mut(data, data_len as usize),
        std::slice::from_raw_parts(key, key_len as usize),
    ).to_c_api_result()
}
