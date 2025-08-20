import 'dart:typed_data';

import 'package:app/data/utils/web_api_empty.dart'
    if (dart.library.js_interop) 'package:web/web.dart'
    show window;
import 'package:utils/utils.dart';

Uri signInWithAppleRedirectUrlForWeb() {
  return Uri.parse("https://${window.location.host}");
}

Uint8List generateNonceBytes() {
  return generate256BitRandomValue();
}
