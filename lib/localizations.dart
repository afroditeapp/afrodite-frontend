import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/l10n/app_localizations_en.dart';
import 'package:app/database/background_database_manager.dart';

final _log = Logger("localizations");

AppLocalizations currentLocalizations = AppLocalizationsEn();

AppLocalizations getStringsImplementation(BuildContext context) {
  var localizations = AppLocalizations.of(context);
  if (localizations == null) {
    _log.warning("AppLocalizations.of(context) returned null");
    localizations = AppLocalizationsEn();
  }
  if (localizations != currentLocalizations) {
    _log.info("Localizations changed, saving current locale value");
    BackgroundDatabaseManager.getInstance().commonAction(
      (db) => db.app.updateCurrentLocale(localizations?.localeName),
    );
  }
  currentLocalizations = localizations;
  return localizations;
}

extension LocalizationsExtension on BuildContext {
  AppLocalizations get strings => getStringsImplementation(this);
}

/// Access resource strings using previously used locale.
///
/// Useful when there is no BuildContext available or the BuildContext
/// can invalidate for example because navigating to another screen.
class R {
  static AppLocalizations get strings => currentLocalizations;
}
