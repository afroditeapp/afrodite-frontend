//! Image processing

use std::io::Cursor;

use image::{DynamicImage, ImageDecoder, ImageReader};
use wasm_bindgen::prelude::wasm_bindgen;

use crate::error::NativeUtilsError;

/// Center crop the image to 4:3 aspect ratio.
pub const PROCESS_CROP_43: u32 = 1;
/// Flip the image horizontally.
pub const PROCESS_FLIP_HORIZONTAL: u32 = 2;

const MIN_WIDTH: u32 = 480;
const MIN_HEIGHT: u32 = 480;
const MAX_INPUT_BYTES: usize = 10 * 1024 * 1024;
const JPEG_QUALITY: u8 = 100;

#[wasm_bindgen(getter_with_clone)]
pub struct ProcessImageOutput {
    pub data: Vec<u8>,
}

#[wasm_bindgen]
pub fn process_image_rust(
    input: &[u8],
    flags: u32,
) -> Result<ProcessImageOutput, NativeUtilsError> {
    Ok(ProcessImageOutput { data: process_image_internal(input, flags)? })
}

/// Process JPEG/PNG image and return JPEG image.
pub fn process_image_internal(
    input: &[u8],
    flags: u32,
) -> Result<Vec<u8>, NativeUtilsError> {
    if input.len() > MAX_INPUT_BYTES {
        return Err(NativeUtilsError::ImageInputTooLarge);
    }

    let mut decoder = ImageReader::new(Cursor::new(input))
        .with_guessed_format()
        .map_err(|_| NativeUtilsError::ImageInputReadingFailed)?
        .into_decoder()
        .map_err(|_| NativeUtilsError::ImageInputReadingFailed)?;
    let orientation = decoder
        .orientation()
        .map_err(|_| NativeUtilsError::ImageExifReadingFailed)?;
    let mut img = DynamicImage::from_decoder(decoder)
        .map_err(|_| NativeUtilsError::ImageDecodeFailed)?;

    if img.width() < MIN_WIDTH || img.height() < MIN_HEIGHT {
        return Err(NativeUtilsError::ImageTooSmall);
    }

    img.apply_orientation(orientation);

    let img = if flags & PROCESS_CROP_43 != 0 {
        crop_to_aspect_ratio_43(img)
    } else {
        img
    };

    let img = if flags & PROCESS_FLIP_HORIZONTAL != 0 {
        img.fliph()
    } else {
        img
    };

    let mut jpeg_data = Cursor::new(Vec::new());
    let encoder = image::codecs::jpeg::JpegEncoder::new_with_quality(&mut jpeg_data, JPEG_QUALITY);
    img.write_with_encoder(encoder)
        .map_err(|_| NativeUtilsError::ImageEncodeFailed)?;

    Ok(jpeg_data.into_inner())
}

fn crop_to_aspect_ratio_43(img: DynamicImage) -> DynamicImage {
    let (width, height) = (img.width(), img.height());
    let new_height = 4.0 / 3.0 * f64::from(width);
    if new_height > f64::from(height) {
        // Height not large enough - use available height as max value
        let new_width = 3.0 / 4.0 * f64::from(height);
        let x_offset = ((f64::from(width) - new_width) / 2.0) as u32;
        img.crop_imm(x_offset, 0, new_width as u32, height)
    } else {
        let y_offset = ((f64::from(height) - new_height) / 2.0) as u32;
        img.crop_imm(0, y_offset, width, new_height as u32)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn create_test_jpeg(width: u32, height: u32) -> Vec<u8> {
        let img = DynamicImage::new_rgb8(width, height);
        let mut data = Cursor::new(Vec::new());
        img.write_with_encoder(image::codecs::jpeg::JpegEncoder::new_with_quality(
            &mut data, 90,
        ))
        .expect("JPEG encoding should succeed");
        data.into_inner()
    }

    #[test]
    fn process_image_no_flags() {
        let input = create_test_jpeg(1000, 1000);
        let output = process_image_internal(&input, 0).expect("processing should succeed");
        assert!(!output.is_empty());
    }

    #[test]
    fn process_image_crop_43_landscape() {
        let input = create_test_jpeg(1200, 1000);
        let output =
            process_image_internal(&input, PROCESS_CROP_43).expect("processing should succeed");
        assert!(!output.is_empty());
    }

    #[test]
    fn process_image_crop_43_portrait() {
        let input = create_test_jpeg(1000, 1200);
        let output =
            process_image_internal(&input, PROCESS_CROP_43).expect("processing should succeed");
        assert!(!output.is_empty());
    }

    #[test]
    fn process_image_too_small() {
        let input = create_test_jpeg(100, 100);
        let result = process_image_internal(&input, 0);
        assert_eq!(result.unwrap_err(), NativeUtilsError::ImageTooSmall);
    }

    #[test]
    fn process_image_invalid_input() {
        let result = process_image_internal(&[0, 1, 2, 3], 0);
        assert_eq!(result.unwrap_err(), NativeUtilsError::ImageInputReadingFailed);
    }

    #[test]
    fn process_image_input_too_large() {
        let input = vec![0u8; MAX_INPUT_BYTES + 1];
        let result = process_image_internal(&input, 0);
        assert_eq!(result.unwrap_err(), NativeUtilsError::ImageInputTooLarge);
    }

    #[test]
    fn process_image_flip_and_crop() {
        let input = create_test_jpeg(1200, 1000);
        let output =
            process_image_internal(&input, PROCESS_CROP_43 | PROCESS_FLIP_HORIZONTAL)
                .expect("processing should succeed");
        assert!(!output.is_empty());
    }
}
