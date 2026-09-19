import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/sign_in_with.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/model/freezed/logic/sign_in_with.dart";
import "package:app/ui/login/widgets.dart";
import "package:app/ui/normal/settings/chat/send_chat_backup.dart";
import "package:app/ui_utils/loading_dialog.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/logic/account/demo_account.dart";
import "package:app/model/freezed/logic/account/demo_account.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import 'package:app/localizations.dart';

class DemoAccountPage extends MyScreenPage<()> with SimpleUrlParser<DemoAccountPage> {
  DemoAccountPage() : super(builder: (_) => DemoAccountScreen());

  @override
  DemoAccountPage create() => DemoAccountPage();
}

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
            MenuItemButton(
              child: Text(context.strings.send_chat_backup_screen_title),
              onPressed: () => openSendChatBackupScreenForDemoAccount(context),
            ),
            MenuItemButton(
              child: Text(context.strings.generic_sign_in),
              onPressed: () {
                MyNavigator.push(context, DemoServerSignInPage());
              },
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
      final Widget listView;
      if (data.isLoading) {
        listView = ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return null;
          },
        );
      } else if (data.accounts.isEmpty) {
        listView = ListView.builder(
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
        );
      } else {
        listView = ListView.builder(
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
                detailsSelectable: true,
                onSuccess: () =>
                    context.read<DemoAccountBloc>().add(DoDemoAccountLoginToAccount(account.aid)),
              ),
            );
          },
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          context.read<DemoAccountBloc>().add(DoDemoAccountRefreshAccountList());
        },
        child: listView,
      );
    },
  );
}

class DemoServerSignInPage extends MyScreenPage<()> with SimpleUrlParser<DemoServerSignInPage> {
  DemoServerSignInPage() : super(builder: (_) => const DemoServerSignInScreen());

  @override
  DemoServerSignInPage create() => DemoServerSignInPage();
}

class DemoServerSignInScreen extends StatelessWidget {
  const DemoServerSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Spacer(flex: 2),
                          Text("Sign in to demo server using normal login methods"),
                          const Spacer(flex: 10),
                          signInButtonArea(context, demoServer: true),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ProgressDialogOpener<SignInWithBloc, SignInWithData>(
            dialogVisibilityGetter: (state) => state.showProgress,
            loadingText: context.strings.generic_login_progress_dialog_text,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(context.strings.generic_sign_in)),
    );
  }
}
