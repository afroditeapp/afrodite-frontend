import "dart:io";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/assets.dart";
import "package:pihka_frontend/logic/account/demo_account.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/logic/sign_in_with.dart";
import "package:pihka_frontend/ui_utils/colors.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";
import "package:pihka_frontend/ui_utils/app_bar/common_actions.dart";
import "package:pihka_frontend/ui_utils/app_bar/menu_actions.dart";
import "package:pihka_frontend/ui_utils/text_field.dart";

import "package:sign_in_with_apple/sign_in_with_apple.dart";


import 'package:pihka_frontend/localizations.dart';
import "package:url_launcher/url_launcher_string.dart";

class DemoAccountScreen extends RootScreen {
  const DemoAccountScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Text("Demo account screen"),
                    const Spacer(flex: 2),
                    logoAndAppNameAndSlogan(context),
                    const Spacer(flex: 10),
                  ],
                ),
              ),
            ),
          );
        }
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: null,
        actions: [
          menuActions([
            MenuItemButton(
              child: Text(context.strings.generic_logout),
              onPressed: () =>
                context.read<DemoAccountBloc>().add(DoDemoAccountLogout()),
            ),
            ...commonActionsWhenLoggedOut(context),
          ]),
        ],
      ),
    );
  }
}


Widget logoAndAppNameAndSlogan(BuildContext context) {
  const APP_ICON_SIZE = 100.0;
  final logoRow = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        ImageAsset.appLogo.path,
        width: APP_ICON_SIZE,
        height: APP_ICON_SIZE,
      ),
      Text(context.strings.app_name, style: Theme.of(context).textTheme.headlineMedium),
    ],
  );

  return Column(
    children: [
      logoRow,
      const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
      Text(context.strings.app_slogan, style: Theme.of(context).textTheme.titleLarge),
    ],
  );
}

class DemoAccountCredentials {
  final String id;
  final String password;
  DemoAccountCredentials(this.id, this.password);
}

Future<DemoAccountCredentials?> openFirstDemoAccountLoginDialog(BuildContext context) {
  final idField = SimpleTextField(
    hintText: context.strings.login_screen_demo_account_identifier,
  );
  final passwordField = SimpleTextField(
    hintText: context.strings.login_screen_demo_account_password,
    obscureText: true,
  );
  return showDialog<DemoAccountCredentials?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.strings.login_screen_demo_account_dialog_title),
      content: Column(
        children: [
          Text(context.strings.login_screen_demo_account_dialog_description),
          idField,
          passwordField,
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(context.strings.generic_cancel)
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              DemoAccountCredentials(
                idField.controller.text,
                passwordField.controller.text
              )
            );
          },
          child: Text(context.strings.generic_login)
        )
      ],
      scrollable: true,
    )
  );
}
