



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';


/// Common action that should be shown when the user is logged out from
/// normal account.
List<MenuItemButton> commonActionsWhenLoggedOut(BuildContext context) {
  return [
    commonActionOpenAboutDialog(context),
  ];
}

/// Common action that should be shown when the user is logged in to normal
/// account but account state is not "initialSetupComplete".
List<MenuItemButton> commonActionsWhenLoggedInAndAccountIsNotNormallyUsable(BuildContext context) {
  return [
    commonActionLogout(context),
    commonActionOpenAboutDialog(context),
  ];
}

MenuItemButton commonActionOpenAboutDialog(BuildContext context) {
  return MenuItemButton(
    child: Text(context.strings.app_bar_action_about),
    onPressed: () => showAppAboutDialog(context),
  );
}

MenuItemButton commonActionLogout(BuildContext context) {
  return MenuItemButton(
    child: Text(context.strings.generic_logout),
    onPressed: () => showConfirmDialogAdvanced(
      context: context,
      title: context.strings.generic_logout_confirmation_title,
      onSuccess: () => context.read<AccountBloc>().add(DoLogout()),
    ),
  );
}
