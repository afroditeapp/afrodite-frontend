

import 'dart:ffi';
import 'dart:io';

import 'native_utils_bindings_generated.dart';

const String _libName = 'native_utils';

/// The dynamic library in which the symbols for [NativeUtilsBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final NativeUtilsBindings _bindings = NativeUtilsBindings(_dylib);

NativeUtilsBindings getBindings() {
  return _bindings;
}
