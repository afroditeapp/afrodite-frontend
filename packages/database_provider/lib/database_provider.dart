
export 'src/impl_empty.dart'
  if (dart.library.io) 'package:database_provider_native/database_provider_native.dart'
  if (dart.library.js_interop) 'package:database_provider_web/database_provider_web.dart';
