import "package:app/ui_utils/snack_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/logic/account/demo_account.dart";
import "package:app/model/freezed/logic/account/demo_account.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import 'package:app/localizations.dart';

class DemoAccountScreen extends StatelessWidget {
  const DemoAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoAccountScreenContent(bloc: context.read<DemoAccountBloc>());
  }
}

class DemoAccountScreenContent extends StatefulWidget {
  final DemoAccountBloc bloc;
  const DemoAccountScreenContent({required this.bloc, super.key});

  @override
  State<DemoAccountScreenContent> createState() => _DemoAccountScreenContentState();
}

class _DemoAccountScreenContentState extends State<DemoAccountScreenContent> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(DoDemoAccountRefreshAccountList());
  }

  @override
  Widget build(BuildContext context) {
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
                final inProgress = context.read<DemoAccountBloc>().state.logoutInProgress;
                if (inProgress) {
                  showSnackBar(context.strings.generic_previous_action_in_progress);
                } else {
                  showConfirmDialogAdvanced(
                    context: context,
                    title: context.strings.demo_account_screen_confirm_logout_dialog_title,
                    onSuccess: () => context.read<DemoAccountBloc>().add(DoDemoAccountLogout()),
                  );
                }
              },
            ),
            MenuItemButton(
              child: Text(context.strings.demo_account_screen_new_account_action),
              onPressed: () => createDemoAccountAction(context),
            ),
            ...commonActionsWhenLoggedOut(context),
          ]),
        ],
      ),
    );
  }
}

void createDemoAccountAction(BuildContext context) {
  showConfirmDialogAdvanced(
    context: context,
    title: context.strings.demo_account_screen_new_account_action,
    details: context.strings.demo_account_screen_new_account_dialog_description,
    onSuccess: () => context.read<DemoAccountBloc>().add(DoDemoAccountCreateNewAccount()),
  );
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
                  child: Column(
                    children: [
                      Text(context.strings.demo_account_screen_no_accounts_available),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      ElevatedButton(
                        onPressed: () => createDemoAccountAction(context),
                        child: Text(context.strings.demo_account_screen_new_account_action),
                      ),
                    ],
                  ),
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
              subtitle: Text(account.aid.aid),
              onTap: () => showConfirmDialogAdvanced(
                context: context,
                title: context.strings.demo_account_screen_login_to_account_dialog_title,
                details: account.aid.aid,
                onSuccess: () =>
                    context.read<DemoAccountBloc>().add(DoDemoAccountLoginToAccount(account.aid)),
              ),
            );
          },
        ),
      );
    },
  );
}
