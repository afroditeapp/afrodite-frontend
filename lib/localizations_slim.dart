import 'dart:ui';

import 'package:app/l10n/app_localizations.dart';

late AppLocalizations _currentLocalizations;

Future<void> initLocalizations(Locale locale) async {
  try {
    _currentLocalizations = await lookupAppLocalizations(locale);
    return;
  } catch (_) {
    // Locale not supported
  }

  _currentLocalizations = await lookupAppLocalizations(Locale("en"));
}

AppLocalizations loadedLocalizations() => _currentLocalizations;
void updateLocalizations(AppLocalizations localizations) => _currentLocalizations = localizations;
