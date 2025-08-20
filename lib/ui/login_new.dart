import "dart:io";

import "package:app/logic/account/demo_account_login.dart";
import "package:app/model/freezed/logic/account/demo_account_login.dart";
import "package:app/ui_utils/image.dart";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/assets.dart";
import "package:app/data/login_repository.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/sign_in_with.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/model/freezed/logic/sign_in_with.dart";
import "package:app/ui/login.dart";
import "package:app/ui_utils/consts/colors.dart";
import "package:app/ui_utils/loading_dialog.dart";
import "package:app/ui_utils/app_bar/common_actions.dart";
import "package:app/ui_utils/app_bar/menu_actions.dart";
import "package:app/ui_utils/sign_in_with_google_web_button/button.dart";
import "package:app/ui_utils/text_field.dart";

import "package:sign_in_with_apple/sign_in_with_apple.dart";

import 'package:app/localizations.dart';
import "package:url_launcher/url_launcher_string.dart";

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
            // It is not possible to build web debug build using
            // "flutter build web" command, so profile mode is used as
            // a workaround. Also some devices are too slow for debug builds.
            if (kDebugMode || kProfileMode)
              MenuItemButton(
                child: const Text("Old login"),
                onPressed: () {
                  MyNavigator.push(context, const MaterialPage<void>(child: LoginScreenOld()));
                },
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
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  logoAndAppNameAndSlogan(context),
                  const Spacer(flex: 10),
                  signInButtonArea(context),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

const SIGN_IN_BUTTON_HEIGHT = 50.0;

Widget signInButtonArea(BuildContext context) {
  const COMMON_PADDING = 8.0;

  return Column(
    children: [
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
      // MYSTERY: Without this Row, there is overflow warning if screen is rotated
      // for some reason. Content height is larger than screen height in
      // this case.
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SizedBox(width: 300, child: termsOfServiceAndPrivacyPolicyInfo(context))],
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
      SizedBox(
        width: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstSignInButton(context),
            const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
            secondSignInButton(context),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
    ],
  );
}

Widget termsOfServiceAndPrivacyPolicyInfo(BuildContext context) {
  // NOTE: Adding spaces like this does not work for all languages.

  final textStyle = Theme.of(context).textTheme.bodyLarge;
  final linkStyle = textStyle?.copyWith(color: LINK_COLOR);

  return RichText(
    text: TextSpan(
      text: "${context.strings.login_screen_login_note_text_beginning} ",
      style: textStyle,
      children: [
        TextSpan(
          text: context.strings.login_screen_login_note_text_tos,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrlString(context.strings.url_app_tos_link),
        ),
        TextSpan(text: " ${context.strings.login_screen_login_note_text_and} "),
        TextSpan(
          text: context.strings.login_screen_login_note_text_privacy_policy,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrlString(context.strings.url_app_privacy_policy_link),
        ),
        const TextSpan(text: "."),
      ],
    ),
  );
}

Widget firstSignInButton(BuildContext context) {
  if (kIsWeb) {
    return SizedBox(
      height: SIGN_IN_BUTTON_HEIGHT,
      child: Center(
        child: signInWithGoogleButtonWeb(
          Theme.of(context).brightness == Brightness.dark,
          context.strings.localeName,
        ),
      ),
    );
  } else if (Platform.isIOS) {
    return signInWithAppleButton(context);
  } else {
    return signInWithGoogleButton(context);
  }
}

Widget secondSignInButton(BuildContext context) {
  if (!kIsWeb && Platform.isIOS) {
    return signInWithGoogleButton(context);
  } else {
    return signInWithAppleButton(context);
  }
}

Widget signInWithAppleButton(BuildContext context) {
  final SignInWithAppleButtonStyle style;
  if (Theme.of(context).brightness == Brightness.light) {
    style = SignInWithAppleButtonStyle.black;
  } else {
    style = SignInWithAppleButtonStyle.white;
  }

  return SignInWithAppleButton(
    onPressed: () => context.read<SignInWithBloc>().add(SignInWithAppleEvent()),
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    height: SIGN_IN_BUTTON_HEIGHT,
    style: style,
  );
}

Widget signInWithGoogleButton(BuildContext context) {
  final String iconPath;
  if (Theme.of(context).brightness == Brightness.light) {
    iconPath = ImageAsset.signInWithGoogleButtonImageDark().path;
  } else {
    iconPath = ImageAsset.signInWithGoogleButtonImageLight().path;
  }

  return IconButton(
    icon: Image.asset(
      iconPath,
      width: null,
      height: SIGN_IN_BUTTON_HEIGHT,
      cacheHeight: calculateCachedImageSize(context, SIGN_IN_BUTTON_HEIGHT),
    ),
    padding: EdgeInsets.zero,
    onPressed: () => context.read<SignInWithBloc>().add(SignInWithGoogle()),
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
        cacheHeight: calculateCachedImageSize(context, APP_ICON_SIZE),
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

Future<DemoAccountCredentials?> openFirstDemoAccountLoginDialog(BuildContext context) {
  final defaultUsername = kReleaseMode ? "" : "username";
  final defaultPassword = kReleaseMode ? "" : "password";

  final usernameField = SimpleTextField(
    hintText: context.strings.login_screen_demo_account_username,
    // TODO(prod): After password login is implemented add boolean constant which
    //             can hide demo account login.
    getInitialValue: () => context.read<DemoAccountLoginBloc>().state.username ?? defaultUsername,
  );
  final passwordField = SimpleTextField(
    hintText: context.strings.login_screen_demo_account_password,
    obscureText: true,
    getInitialValue: () => context.read<DemoAccountLoginBloc>().state.password ?? defaultPassword,
  );

  final pageKey = PageKey();
  return MyNavigator.showDialog<DemoAccountCredentials?>(
    context: context,
    pageKey: pageKey,
    builder: (context) => AlertDialog(
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
          onPressed: () {
            MyNavigator.removePage(context, pageKey);
          },
          child: Text(context.strings.generic_cancel),
        ),
        TextButton(
          onPressed: () {
            MyNavigator.removePage(
              context,
              pageKey,
              DemoAccountCredentials(usernameField.controller.text, passwordField.controller.text),
            );
          },
          child: Text(context.strings.generic_login),
        ),
      ],
      scrollable: true,
    ),
  );
}
