



import 'package:flutter/material.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';


List<MenuItemButton> commonActionsWhenLoggedOut(BuildContext context) {
  return [
    commonActionOpenAboutDialog(context),
  ];
}

MenuItemButton commonActionOpenAboutDialog(BuildContext context) {
  return MenuItemButton(
    child: Text(context.strings.app_bar_action_about),
    onPressed: () => showAppAboutDialog(context),
  );
}
