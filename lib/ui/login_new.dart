import "dart:io";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/assets.dart";
import "package:pihka_frontend/config.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/logic/server/address.dart";
import "package:pihka_frontend/logic/sign_in_with.dart";
import "package:pihka_frontend/ui/colors.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";
import "package:pihka_frontend/ui_utils/app_bar/common_actions.dart";
import "package:pihka_frontend/ui_utils/app_bar/menu_actions.dart";

import "package:sign_in_with_apple/sign_in_with_apple.dart";


import 'package:pihka_frontend/localizations.dart';
import "package:url_launcher/url_launcher_string.dart";

// TODO(prod): Use SVG for sign in with google button

class LoginNewPage extends RootPage {
  const LoginNewPage({Key? key}) : super(MainState.loginRequired, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    final loginPageWidgets = <Widget>[
      const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
      logoAndAppNameAndSlogan(context),
      Expanded(child: Container()),
      signInButtonArea(context),
      const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
    ];

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: loginPageWidgets,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: null,
        actions: [
          menuActions([
            MenuItemButton(
              child: Text(context.strings.login_screen_action_demo_account_login),
              onPressed: null,
            ),
            ...commonActionsWhenLoggedOut(context),
          ]),
        ]
      ),
    );
  }
}

const BUTTON_HEIGHT = 50.0;

Widget signInButtonArea(BuildContext context) {
  const COMMON_PADDING = 8.0;

  return Column(
    children: [
      SizedBox(
        width: 300,
        child: termsOfServiceAndPrivacyPolicyInfo(context),
      ),
      // TODO(prod): Add more padding?
      SizedBox(
        width: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
            firstSignInButton(context),
            const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
            secondSignInButton(context),
          ],
        ),
      ),
    ],
  );
}

Widget termsOfServiceAndPrivacyPolicyInfo(BuildContext context) {
  // NOTE: Adding spaces like this does not work for all languages.

  final textStyle = Theme.of(context).textTheme.bodyLarge;
  final linkStyle = textStyle?.copyWith(
    color: LINK_COLOR,
  );

  return RichText(text: TextSpan(
    text: "${context.strings.login_screen_login_note_text_beginning} ",
    style: textStyle,
    children: [
      TextSpan(
        text: context.strings.login_screen_login_note_text_tos,
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () => launchUrlString(context.strings.url_app_tos_link)
      ),
      TextSpan(text: " ${context.strings.login_screen_login_note_text_and} "),
      TextSpan(
        text: context.strings.login_screen_login_note_text_privacy_policy,
        style: linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () => launchUrlString(context.strings.url_app_privacy_policy_link)
      ),
      const TextSpan(text: "."),
    ],
  ));
}

Widget firstSignInButton(BuildContext context) {
  if (Platform.isIOS) {
    return signInWithAppleButton(context);
  } else {
    return signInWithGoogleButton(context);
  }
}

Widget secondSignInButton(BuildContext context) {
  if (Platform.isIOS) {
    return signInWithGoogleButton(context);
  } else {
    return signInWithAppleButton(context);
  }
}

Widget signInWithAppleButton(BuildContext context) {
  return SignInWithAppleButton(
    onPressed: () =>
      context.read<SignInWithBloc>().add(SignInWithAppleEvent()),
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    iconAlignment: IconAlignment.center,
    height: BUTTON_HEIGHT,
  );
}

Widget signInWithGoogleButton(BuildContext context) {
  return IconButton(
    icon: Image.asset(
      ImageAsset.signInWithGoogleButtonImage().path,
      width: null,
      height: BUTTON_HEIGHT,
    ),
    padding: EdgeInsets.zero,
    onPressed: () =>
      context.read<SignInWithBloc>().add(SignInWithGoogle()),
  );
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
