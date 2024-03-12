


import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

final log = Logger("localizations");

AppLocalizations currentLocalizations = AppLocalizationsEn();

AppLocalizations getStringsImplementation(BuildContext context) {
  var localizations = AppLocalizations.of(context);
  if (localizations == null) {
    log.warning("AppLocalizations.of(context) returned null");
    localizations = AppLocalizationsEn();
  }
  currentLocalizations = localizations;
  return localizations;
}

extension LocalizationsExtension on BuildContext {
  AppLocalizations get strings => getStringsImplementation(this);
}

AppLocalizations getStrings() {
  return currentLocalizations;
}

class R {
  static AppLocalizations get strings => currentLocalizations;
}
