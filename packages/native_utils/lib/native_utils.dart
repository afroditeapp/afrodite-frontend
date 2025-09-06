export 'src/impl_empty.dart'
    if (dart.library.ffi) 'package:native_utils_ffi/native_utils_ffi.dart'
    if (dart.library.js_interop) 'package:native_utils_web/native_utils_web.dart';

export 'package:native_utils_common/native_utils_common.dart';
