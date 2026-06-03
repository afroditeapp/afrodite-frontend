import 'package:flutter/material.dart';

extension LocaleStringExtensions on Locale {
  /// Returns the locale as a string in the format "languageCode_countryCode",
  /// e.g. "en_US" or "fi_FI".
  String localeString() {
    return toString();
  }
}
