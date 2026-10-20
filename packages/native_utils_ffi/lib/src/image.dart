import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:native_utils_common/native_utils_common.dart';
import 'package:native_utils_ffi/src/message.dart';
import 'package:native_utils_ffi/src/native_utils_ffi_bindings_generated.dart' as bindings;

/// If processing fails, null is returned
Future<(ProcessedImage?, ProcessImageError)> processImage(Uint8List input, int flags) async {
  final Pointer<Uint8> cInput = malloc.allocate(input.length);
  cInput.asTypedList(input.length).setAll(0, input);

  final processImageResult = bindings.process_image(cInput, input.length, flags);

  malloc.free(cInput);

  final (data, result) = handleBinaryDataResult(processImageResult);
  if (data != null) {
    return (ProcessedImage(bytes: data), ProcessImageError.ok);
  } else {
    return (null, ProcessImageError.fromValue(result));
  }
}
