
import 'dart:math';
import 'dart:typed_data';

import 'package:app/data/utils/web_api_empty.dart'
  if (dart.library.js_interop) 'package:web/web.dart' show window;

Uri signInWithAppleRedirectUrlForWeb() {
  return Uri.parse("https://${window.location.host}");
}

Uint8List generateNonceBytes() {
  final random = Random.secure();
  const size = 32; // 256-bit nonce
  final data = Uint8List(size);
  for (var i = 0; i < size; i++) {
    data[i] = random.nextInt(256);
  }
  return data;
}
