import 'dart:typed_data';

/// Center crop the image to 4:3 aspect ratio.
const PROCESS_CROP_43 = 1;

/// Flip the image horizontally.
const PROCESS_FLIP_HORIZONTAL = 2;

class ProcessedImage {
  final Uint8List bytes;
  ProcessedImage({required this.bytes});
}

/// Error codes must match NativeUtilsError enum in the Rust code.
enum ProcessImageError {
  ok(0),

  /// Unknown or unrecognized error
  unknown(-1),
  inputReadingFailed(70),
  exifReadingFailed(71),
  decodeFailed(72),
  inputTooLarge(73),
  imageTooSmall(74),
  encodeFailed(75);

  final int value;
  const ProcessImageError(this.value);

  static ProcessImageError fromValue(int value) => switch (value) {
    0 => ok,
    70 => inputReadingFailed,
    71 => exifReadingFailed,
    72 => decodeFailed,
    73 => inputTooLarge,
    74 => imageTooSmall,
    75 => encodeFailed,
    _ => unknown,
  };
}
