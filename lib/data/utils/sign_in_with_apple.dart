
import 'package:app/data/utils/web_api_empty.dart'
  if (dart.library.js_interop) 'package:web/web.dart' show window;

Uri signInWithAppleRedirectUrlForWeb() {
  return Uri.parse("https://${window.location.host}");
}
