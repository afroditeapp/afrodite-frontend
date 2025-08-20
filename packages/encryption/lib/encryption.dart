export 'src/encryption_empty.dart'
    if (dart.library.io) 'package:encryption_native/encryption_native.dart'
    if (dart.library.js_interop) 'package:encryption_web/encryption_web.dart';

export 'package:encryption_common/encryption_common.dart';
