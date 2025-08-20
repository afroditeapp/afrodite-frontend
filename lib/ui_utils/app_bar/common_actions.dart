import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/login.dart';
import 'package:app/ui_utils/dialog.dart';

/// Common action that should be shown when the user is logged out from
/// normal account.
List<MenuItemButton> commonActionsWhenLoggedOut(BuildContext context) {
  return [commonActionOpenAboutDialog(context, null)];
}

/// Common action that should be shown when the user is logged in to normal
/// account but account state is not "initialSetupComplete".
List<MenuItemButton> commonActionsWhenLoggedInAndAccountIsNotNormallyUsable(BuildContext context) {
  return [commonActionLogout(context), commonActionOpenAboutDialog(context, null)];
}

MenuItemButton commonActionOpenAboutDialog(BuildContext context, ClientFeaturesConfigData? config) {
  return MenuItemButton(
    child: Text(context.strings.app_bar_action_about),
    onPressed: () => showAppAboutDialog(context, config),
  );
}

MenuItemButton commonActionLogout(BuildContext context) {
  return MenuItemButton(
    child: Text(context.strings.generic_logout),
    onPressed: () {
      final inProgress = context.read<LoginBloc>().state.logoutInProgress;
      if (inProgress) {
        showSnackBar(context.strings.generic_previous_action_in_progress);
      } else {
        showConfirmDialogAdvanced(
          context: context,
          title: context.strings.generic_logout_confirmation_title,
          onSuccess: () => context.read<LoginBloc>().add(DoLogout()),
        );
      }
    },
  );
}

MenuItemButton commonActionBlockProfile(BuildContext context, void Function() blockAction) {
  return MenuItemButton(
    onPressed: () async {
      final accepted = await showConfirmDialog(
        context,
        context.strings.view_profile_screen_block_action_dialog_title,
      );
      if (context.mounted && accepted == true) {
        blockAction();
      }
    },
    child: Text(context.strings.view_profile_screen_block_action),
  );
}
