import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';
import 'package:app/localizations.dart';
import 'package:app/ui_utils/snack_bar.dart';

final _log = Logger("LocalAuth");

/// Returns true if authentication succeeded or no credentials are set.
/// Returns false if user canceled or error occurred.
///
/// On web, local_auth is not supported so this always returns true.
Future<bool> authenticateWithLocalAuth(String localizedReason) async {
  if (kIsWeb) return true;

  final auth = LocalAuthentication();

  try {
    final didAuthenticate = await auth.authenticate(localizedReason: localizedReason);
    return didAuthenticate;
  } on LocalAuthException catch (e) {
    if (e.code == LocalAuthExceptionCode.userCanceled ||
        e.code == LocalAuthExceptionCode.systemCanceled) {
      return false;
    } else if (e.code == LocalAuthExceptionCode.noCredentialsSet) {
      return true;
    } else {
      showSnackBar(R.strings.generic_error);
      _log.severe("Local auth failed: ${e.code}");
      return false;
    }
  }
}
