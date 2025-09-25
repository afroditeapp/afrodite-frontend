import "dart:io";

import "package:app/data/utils/demo_account_manager.dart";
import "package:app/logic/account/demo_account_login.dart";
import "package:app/model/freezed/logic/account/demo_account_login.dart";
import "package:app/ui_utils/image.dart";
import "package:app/utils/result.dart";
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/assets.dart";
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
      if (kIsWeb)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Text(context.strings.login_screen_registering_disabled_on_web),
            ),
          ],
        ),
      if (kIsWeb) const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
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

class DemoAccountLoginDialog extends MyDialogPage<Result<DemoAccountCredentials, ()>> {
  DemoAccountLoginDialog({required super.builder});
}

Future<DemoAccountCredentials?> openFirstDemoAccountLoginDialog(BuildContext context) async {
  final defaultUsername = kReleaseMode ? "" : "username";
  final defaultPassword = kReleaseMode ? "" : "password";

  String username = "";
  void usernameChangedCallback(String v) {
    username = v;
  }

  String password = "";
  void passwordChangedCallback(String v) {
    password = v;
  }

  Widget builder(BuildContext context, PageCloser<Result<DemoAccountCredentials, ()>> closer) {
    final usernameField = SimpleTextField(
      hintText: context.strings.login_screen_demo_account_username,
      // TODO(prod): After password login is implemented add boolean constant which
      //             can hide demo account login.
      getInitialValue: () => context.read<DemoAccountLoginBloc>().state.username ?? defaultUsername,
      onChanged: usernameChangedCallback,
    );
    final passwordField = SimpleTextField(
      hintText: context.strings.login_screen_demo_account_password,
      obscureText: true,
      getInitialValue: () => context.read<DemoAccountLoginBloc>().state.password ?? defaultPassword,
      onChanged: passwordChangedCallback,
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
          onPressed: () => closer.close(context, Err(())),
          child: Text(context.strings.generic_cancel),
        ),
        TextButton(
          onPressed: () => closer.close(context, Ok(DemoAccountCredentials(username, password))),
          child: Text(context.strings.generic_login),
        ),
      ],
      scrollable: true,
    );
  }

  final r = await MyNavigator.showDialog<Result<DemoAccountCredentials, ()>>(
    context: context,
    page: DemoAccountLoginDialog(builder: builder),
  );

  return r?.ok();
}
