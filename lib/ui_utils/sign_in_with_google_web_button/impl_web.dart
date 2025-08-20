import 'package:flutter/widgets.dart';

import 'package:google_sign_in_web/web_only.dart';

GSIButtonConfiguration? _currentConfiguration;

Widget signInWithGoogleButtonWebImpl(bool darkTheme, String locale) {
  final GSIButtonTheme theme;
  if (darkTheme) {
    theme = GSIButtonTheme.outline;
  } else {
    theme = GSIButtonTheme.filledBlack;
  }
  if (_currentConfiguration == null ||
      _currentConfiguration?.theme != theme ||
      _currentConfiguration?.locale != locale) {
    _currentConfiguration = GSIButtonConfiguration(
      type: GSIButtonType.standard,
      shape: GSIButtonShape.pill,
      logoAlignment: GSIButtonLogoAlignment.center,
      size: GSIButtonSize.large,
      theme: theme,
      locale: locale,
    );
  }
  return renderButton(configuration: _currentConfiguration);
}
