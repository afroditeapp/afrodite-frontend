import "package:app/data/utils/demo_account_manager.dart";
import "package:app/logic/account/demo_account_login.dart";
import "package:app/model/freezed/logic/account/demo_account_login.dart";
import "package:app/ui/login/widgets.dart";
import "package:app/ui/login/email_login.dart";
import "package:app/ui/normal/settings/send_chat_backup.dart";
import "package:app/ui/utils/web_pwa/web_pwa.dart";
import "package:app/utils/result.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/sign_in_with.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/model/freezed/logic/sign_in_with.dart";
import "package:app/ui/login.dart";
import "package:app/ui_utils/loading_dialog.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import "package:app/ui_utils/text_field.dart";

import 'package:app/localizations.dart';

class LoginPage extends MyScreenPage<()> with SimpleUrlParser<LoginPage> {
  LoginPage() : super(builder: (_) => LoginScreen());

  @override
  LoginPage create() => LoginPage();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: screenContent()),
          ProgressDialogOpener<DemoAccountLoginBloc, DemoAccountLoginData>(
            dialogVisibilityGetter: (state) => state.loginProgressVisible,
            loadingText: context.strings.generic_login_progress_dialog_text,
          ),
          ProgressDialogOpener<SignInWithBloc, SignInWithData>(
            dialogVisibilityGetter: (state) => state.showProgress,
            loadingText: context.strings.generic_login_progress_dialog_text,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: null,
        actions: [
          menuActions([
            MenuItemButton(
              child: Text(context.strings.email_login_screen_title),
              onPressed: () {
                openEmailLoginScreen(context);
              },
            ),
            MenuItemButton(
              child: Text(context.strings.login_screen_demo_account_dialog_title),
              onPressed: () {
                final demoAccountBloc = context.read<DemoAccountLoginBloc>();
                openFirstDemoAccountLoginDialog(context).then((value) {
                  if (value != null) {
                    demoAccountBloc.add(DoDemoAccountLogin(value));
                  }
                });
              },
            ),
            MenuItemButton(
              child: Text(context.strings.send_chat_backup_screen_title),
              onPressed: () {
                openSendChatBackupScreen(context);
              },
            ),
            if (kDebugMode || kProfileMode)
              MenuItemButton(
                child: const Text("Old login"),
                onPressed: () => MyNavigator.pushLimited(context, LoginPageOld()),
              ),
            ...commonActionsWhenLoggedOut(context),
          ]),
        ],
      ),
    );
  }

  Widget screenContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(child: loginScreen(context)),
          ),
        );
      },
    );
  }

  Widget loginScreen(BuildContext context) {
    if (isIosWeb() && !isRunningInPwaMode()) {
      return iosPwaInstallationGuide(context);
    }

    return Column(
      children: [
        const Spacer(flex: 2),
        logoAndAppNameAndSlogan(context),
        const Spacer(flex: 10),
        signInButtonArea(context),
        const Spacer(flex: 1),
      ],
    );
  }
}

class DemoAccountLoginDialog extends MyDialogPage<Result<DemoAccountCredentials, ()>> {
  DemoAccountLoginDialog({required super.builder});
}

Future<DemoAccountCredentials?> openFirstDemoAccountLoginDialog(BuildContext context) async {
  final demoAccountBloc = context.read<DemoAccountLoginBloc>();
  final r = await MyNavigator.showDialog<Result<DemoAccountCredentials, ()>>(
    context: context,
    page: DemoAccountLoginDialog(
      builder: (context, closer) =>
          _DemoAccountLoginDialogContent(closer: closer, demoAccountBloc: demoAccountBloc),
    ),
  );

  return r?.ok();
}

class _DemoAccountLoginDialogContent extends StatefulWidget {
  final PageCloser<Result<DemoAccountCredentials, ()>> closer;
  final DemoAccountLoginBloc demoAccountBloc;

  const _DemoAccountLoginDialogContent({required this.closer, required this.demoAccountBloc});

  @override
  State<_DemoAccountLoginDialogContent> createState() => _DemoAccountLoginDialogContentState();
}

class _DemoAccountLoginDialogContentState extends State<_DemoAccountLoginDialogContent> {
  final defaultUsername = kReleaseMode ? "" : "username";
  final defaultPassword = kReleaseMode ? "" : "password";

  String username = "";
  String password = "";
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    username = widget.demoAccountBloc.state.username ?? defaultUsername;
    password = widget.demoAccountBloc.state.password ?? defaultPassword;
  }

  void usernameChangedCallback(String v) {
    username = v;
  }

  void passwordChangedCallback(String v) {
    password = v;
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = SimpleTextField(
      hintText: context.strings.login_screen_demo_account_username,
      // TODO(prod): After password login is implemented add boolean constant which
      //             can hide demo account login.
      getInitialValue: () => username,
      onChanged: usernameChangedCallback,
    );

    final passwordField = Form(
      child: TextFormField(
        initialValue: password,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          icon: null,
          hintText: context.strings.login_screen_demo_account_password,
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        onChanged: passwordChangedCallback,
      ),
    );

    return AlertDialog(
      title: Text(context.strings.login_screen_demo_account_dialog_title),
      content: Column(
        children: [
          Text(context.strings.login_screen_demo_account_dialog_description),
          usernameField,
          passwordField,
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => widget.closer.close(context, Err(())),
          child: Text(context.strings.generic_cancel),
        ),
        TextButton(
          onPressed: () =>
              widget.closer.close(context, Ok(DemoAccountCredentials(username, password))),
          child: Text(context.strings.generic_login),
        ),
      ],
      scrollable: true,
    );
  }
}
