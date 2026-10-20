import 'dart:js_interop';
import 'dart:typed_data';

import 'package:native_utils_common/native_utils_common.dart';

@JS('rust_utils')
external JSPromise get _rustUtils;

extension type RustUtils._(JSObject _) implements JSObject {
  @JS('process_image_rust')
  external JSFunction get processImageRust;
}

@JS('ProcessImageOutput')
extension type ProcessImageOutput._(JSObject _) implements JSObject {
  external JSUint8Array get data;
}

Future<(ProcessedImage?, ProcessImageError)> processImage(Uint8List input, int flags) async {
  try {
    final module = await _rustUtils.toDart as RustUtils;
    final result =
        module.processImageRust.callAsFunction(null, input.toJS, flags.toJS) as ProcessImageOutput;
    return (ProcessedImage(bytes: result.data.toDart), ProcessImageError.ok);
  } catch (e) {
    // wasm-bindgen throws the error enum value as a number.
    final code = e.isA<JSNumber>() ? (e as JSNumber).toDartInt : -1;
    return (null, ProcessImageError.fromValue(code));
  }
}
