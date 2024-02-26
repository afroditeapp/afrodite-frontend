


import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

final log = Logger("localizations");

AppLocalizations getStringsImplementation(BuildContext context) {
  final localizations = AppLocalizations.of(context);
  if (localizations == null) {
    log.warning("AppLocalizations.of(context) returned null");
    return AppLocalizationsEn();
  } else {
    return localizations;
  }
}

extension LocalizationsExtension on BuildContext {
  AppLocalizations get strings => getStringsImplementation(this);
}
