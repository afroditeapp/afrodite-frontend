use crate::content::ContentEncryptionError;

pub mod content;
pub mod message;

const API_OK: isize = 0;
const API_ERROR: isize = -1;

pub trait CApiResult {
    /// 0 is success, other value is failure
    fn to_c_api_result(&self) -> isize;
}

impl CApiResult for Result<(), ContentEncryptionError> {
    fn to_c_api_result(&self) -> isize {
        match self {
            Ok(_) => API_OK,
            Err(e) => if (*e as u8) == 0 {
                API_ERROR
            } else {
                *e as isize
            }
        }
    }
}
