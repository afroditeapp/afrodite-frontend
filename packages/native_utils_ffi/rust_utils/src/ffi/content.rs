use crate::{content, ffi::CApiResult};


#[unsafe(no_mangle)]
pub unsafe extern "C" fn encrypt_content(
    data: *mut u8,
    data_len: isize,
    key: *const u8,
    key_len: isize,
) -> isize {
    assert!(!data.is_null());
    assert!(data_len >= 0);
    assert!(!key.is_null());
    assert!(key_len >= 0);

    unsafe {
        content::encrypt_content(
            std::slice::from_raw_parts_mut(data, data_len as usize),
            std::slice::from_raw_parts(key, key_len as usize),
        ).to_c_api_result()
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn decrypt_content(
    data: *mut u8,
    data_len: isize,
    key: *const u8,
    key_len: isize,
) -> isize {
    assert!(!data.is_null());
    assert!(data_len >= 0);
    assert!(!key.is_null());
    assert!(key_len >= 0);

    unsafe {
        content::decrypt_content(
            std::slice::from_raw_parts_mut(data, data_len as usize),
            std::slice::from_raw_parts(key, key_len as usize),
        ).to_c_api_result()
    }
}
