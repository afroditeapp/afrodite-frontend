
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/account/demo_account.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";
import "package:pihka_frontend/ui_utils/app_bar/common_actions.dart";
import "package:pihka_frontend/ui_utils/app_bar/menu_actions.dart";
import 'package:pihka_frontend/localizations.dart';

class DemoAccountScreen extends RootScreen {
  const DemoAccountScreen({Key? key}) : super(key: key);

  @override
  void runOnceBeforeNavigatedTo(BuildContext context) {
    context.read<DemoAccountBloc>().add(DoDemoAccountRefreshAccountList());
  }

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
      body: content(context),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: null,
        actions: [
          menuActions([
            MenuItemButton(
              child: Text(context.strings.generic_logout),
              onPressed: () {
                showConfirmDialogAdvanced(
                  context: context,
                  title: context.strings.demo_account_screen_confirm_logout_dialog_title,
                  onSuccess: () => context
                    .read<DemoAccountBloc>()
                    .add(DoDemoAccountLogout()),
                );
              }
            ),
            MenuItemButton(
              child: Text(context.strings.demo_account_screen_new_account_action),
              onPressed: () {
                showConfirmDialogAdvanced(
                  context: context,
                  title: context.strings.demo_account_screen_new_account_dialog_title,
                  details: context.strings.demo_account_screen_new_account_dialog_description,
                  onSuccess: () => context
                    .read<DemoAccountBloc>()
                    .add(DoDemoAccountCreateNewAccount()),
                );
              }
            ),
            ...commonActionsWhenLoggedOut(context),
          ]),
        ],
      ),
    );
  }
}

Widget content(BuildContext context) {
  return BlocBuilder<DemoAccountBloc, DemoAccountBlocData>(
    builder: (context, data) {
      if (data.accounts.isEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<DemoAccountBloc>().add(DoDemoAccountRefreshAccountList());
          },
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(
                    child: Text(context.strings.demo_account_screen_no_accounts_available)
                  ),
              );
            },
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          context.read<DemoAccountBloc>().add(DoDemoAccountRefreshAccountList());
        },
        child: ListView.builder(
          itemCount: data.accounts.length,
          itemBuilder: (context, index) {
            final account = data.accounts[index];
            return ListTile(
              title: Text("${account.name}, ${account.age}"),
              subtitle: Text(account.id.accountId),
              onTap: () =>
                showConfirmDialogAdvanced(
                  context: context,
                  title: context.strings.demo_account_screen_login_to_account_dialog_title,
                  details: account.id.accountId,
                  onSuccess: () => context
                    .read<DemoAccountBloc>()
                    .add(DoDemoAccountLoginToAccount(account.id)),
                ),
            );
          },
        ),
      );
    }
  );
}
