

import 'package:flutter/widgets.dart';

import 'impl_empty.dart'
  if (dart.library.js_interop) 'impl_web.dart';

/// Throws exception if not running on web
Widget signInWithGoogleButtonWeb(bool darkTheme, String locale) {
  return signInWithGoogleButtonWebImpl(darkTheme, locale);
}
