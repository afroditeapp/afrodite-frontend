import 'dart:io';

import 'package:app/assets.dart';
import 'package:app/config_services.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/sign_in_with_google_web_button/button.dart';
import 'package:app/ui/login/email_login.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
      if (kIsWeb || !Platform.isAndroid)
        TextButton(
          onPressed: () async {
            await showInfoDialog(
              context,
              context.strings.login_screen_email_login_info_dialog_text,
            );
            if (context.mounted) {
              openEmailLoginMethodScreen(context);
            }
          },
          child: Text(context.strings.login_screen_sign_in_with_email_action),
        ),
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
  } else if (Platform.isIOS && signInWithAppleServiceIdForAndroidAndWebLogin().isNotEmpty) {
    return signInWithAppleButton(context);
  } else {
    return signInWithGoogleButton(context);
  }
}

Widget secondSignInButton(BuildContext context) {
  if (!kIsWeb && Platform.isIOS && signInWithAppleServiceIdForAndroidAndWebLogin().isNotEmpty) {
    return signInWithGoogleButton(context);
  } else if (signInWithAppleServiceIdForAndroidAndWebLogin().isNotEmpty) {
    return signInWithAppleButton(context);
  } else {
    return SizedBox.shrink();
  }
}

Widget signInWithAppleButton(BuildContext context, {VoidCallback? onPressed}) {
  final SignInWithAppleButtonStyle style;
  if (Theme.of(context).brightness == Brightness.light) {
    style = SignInWithAppleButtonStyle.black;
  } else {
    style = SignInWithAppleButtonStyle.white;
  }

  return SignInWithAppleButton(
    onPressed: onPressed ?? () => context.read<SignInWithBloc>().add(SignInWithAppleEvent()),
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    height: SIGN_IN_BUTTON_HEIGHT,
    style: style,
  );
}

Widget signInWithGoogleButton(BuildContext context, {VoidCallback? onPressed}) {
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
    onPressed: onPressed ?? () => context.read<SignInWithBloc>().add(SignInWithGoogle()),
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

Widget iosPwaInstallationGuide(BuildContext context) {
  return Column(
    children: [
      const Spacer(flex: 2),
      logoAndAppNameAndSlogan(context),
      const Spacer(flex: 3),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.strings.login_screen_ios_pwa_install_description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            _installStepWithIcon(
              context,
              context.strings.login_screen_ios_pwa_install_step1,
              Icons.ios_share,
            ),
            const SizedBox(height: 12),
            _installStep(context, context.strings.login_screen_ios_pwa_install_step2),
            const SizedBox(height: 12),
            _installStep(context, context.strings.login_screen_ios_pwa_install_step3),
            const SizedBox(height: 12),
            _installStep(context, context.strings.login_screen_ios_pwa_install_step4),
          ],
        ),
      ),
      const Spacer(flex: 7),
    ],
  );
}

Widget _installStep(BuildContext context, String text) {
  return Text(text, style: Theme.of(context).textTheme.bodyMedium);
}

Widget _installStepWithIcon(BuildContext context, String text, IconData icon) {
  return Row(
    children: [
      Flexible(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
      const SizedBox(width: 8),
      Icon(icon, size: 24),
    ],
  );
}
