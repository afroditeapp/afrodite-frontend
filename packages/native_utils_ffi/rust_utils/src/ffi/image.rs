use crate::image_processing;

use super::message::BinaryDataResult;

/// Process an image.
///
/// The result must be freed using free_binary_data_result.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn process_image(
    input: *const u8,
    input_len: isize,
    flags: u32,
) -> BinaryDataResult {
    assert!(!input.is_null());

    let input = unsafe { std::slice::from_raw_parts(input, input_len as usize) };

    match image_processing::process_image_internal(input, flags) {
        Ok(output) => BinaryDataResult::success(output),
        Err(e) => BinaryDataResult::error(e),
    }
}
