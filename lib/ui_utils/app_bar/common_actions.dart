



import 'package:flutter/material.dart';
import 'package:pihka_frontend/assets.dart';
import 'package:pihka_frontend/localizations.dart';


List<MenuItemButton> commonActionsWhenLoggedOut(BuildContext context) {
  return [
    commonActionOpenAboutDialog(context),
  ];
}

MenuItemButton commonActionOpenAboutDialog(BuildContext context) {
  return MenuItemButton(
    child: Text(context.strings.app_bar_action_about),
    onPressed: () => _showAppAboutDialog(context),
  );
}

void _showAppAboutDialog(BuildContext context) {
  // TODO(prod): Finish about dialog information
  const double ICON_SIZE = 80.0;
  showAboutDialog(
    context: context,
    applicationName: context.strings.app_name,
    applicationVersion: "0.1.0",
    applicationIcon: Image.asset(
      ImageAsset.appLogo.path,
      width: ICON_SIZE,
      height: ICON_SIZE,
    ),
    applicationLegalese: "© 2024 Pihka",
  );
}
