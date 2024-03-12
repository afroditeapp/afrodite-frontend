



import 'package:flutter/material.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';


/// Common action that should be shown when the user is logged out from
/// normal account.
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
