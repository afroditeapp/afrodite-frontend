import 'package:app/localizations_slim.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/database/common_database_manager.dart';

final _log = Logger("localizations");

AppLocalizations _loadLocalizationsAndSaveLocaleIfNeeded(BuildContext context) {
  var localizations = AppLocalizations.of(context);
  if (localizations == null) {
    _log.warning("AppLocalizations.of(context) returned null");
    localizations = loadedLocalizations();
  }
  if (localizations != loadedLocalizations()) {
    _log.info("Localizations changed, saving current locale value");
    CommonDatabaseManager.getInstance().commonAction(
      (db) => db.app.updateCurrentLocale(localizations?.localeName),
    );
    updateLocalizations(localizations);
  }
  return localizations;
}

extension LocalizationsExtension on BuildContext {
  AppLocalizations get strings => _loadLocalizationsAndSaveLocaleIfNeeded(this);
}

/// Access resource strings using previously used locale.
///
/// Useful when there is no BuildContext available or the BuildContext
/// can invalidate for example because navigating to another screen.
class R {
  static AppLocalizations get strings => loadedLocalizations();
}
