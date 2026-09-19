import 'dart:io';

import 'package:app/assets.dart';
import 'package:app/config.dart';
import 'package:app/config_services.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/sign_in_with.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/sign_in_with_google_web_button/button.dart';
import 'package:app/ui/login/email_login.dart';
import 'package:app/ui/utils/web_pwa/web_pwa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

const SIGN_IN_BUTTON_HEIGHT = 50.0;

/// Sign in button area shown on the login screen.
///
/// When [demoServer] is true, the sign in actions are performed against the
/// demo server instead of the normal server.
Widget signInButtonArea(BuildContext context, {required bool demoServer}) {
  const COMMON_PADDING = 8.0;

  return Column(
    children: [
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
      // MYSTERY: Without this Row, there is overflow warning if screen is rotated
      // for some reason. Content height is larger than screen height in
      // this case.
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  termsOfServiceAndPrivacyPolicyInfo(context),
                  if (kIsWeb &&
                      !(defaultTargetPlatform == TargetPlatform.iOS ||
                          defaultTargetPlatform == TargetPlatform.android)) ...[
                    const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
                    Text(
                      context.strings.login_screen_shared_computer_warning,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
      SizedBox(
        width: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstSignInButton(context, demoServer: demoServer),
            const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING)),
            secondSignInButton(context, demoServer: demoServer),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.symmetric(vertical: COMMON_PADDING / 2)),
      TextButton(
        onPressed: () => openEmailLoginMethodScreen(context, demoServer: demoServer),
        child: Text(context.strings.login_screen_sign_in_with_email_action),
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

Widget firstSignInButton(BuildContext context, {required bool demoServer}) {
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
    return signInWithAppleButton(context, demoServer: demoServer);
  } else {
    return signInWithGoogleButton(context, demoServer: demoServer);
  }
}

Widget secondSignInButton(BuildContext context, {required bool demoServer}) {
  if (!kIsWeb && Platform.isIOS && signInWithAppleServiceIdForAndroidAndWebLogin().isNotEmpty) {
    return signInWithGoogleButton(context, demoServer: demoServer);
  } else if (signInWithAppleServiceIdForAndroidAndWebLogin().isNotEmpty) {
    return signInWithAppleButton(context, demoServer: demoServer);
  } else {
    return SizedBox.shrink();
  }
}

Widget signInWithAppleButton(
  BuildContext context, {
  VoidCallback? onPressed,
  required bool? demoServer,
}) {
  final SignInWithAppleButtonStyle style;
  if (Theme.of(context).brightness == Brightness.light) {
    style = SignInWithAppleButtonStyle.black;
  } else {
    style = SignInWithAppleButtonStyle.white;
  }

  return SignInWithAppleButton(
    onPressed:
        onPressed ??
        () => context.read<SignInWithBloc>().add(SignInWithAppleEvent(demoServer: demoServer)),
    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
    height: SIGN_IN_BUTTON_HEIGHT,
    style: style,
  );
}

Widget signInWithGoogleButton(
  BuildContext context, {
  VoidCallback? onPressed,
  required bool? demoServer,
}) {
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
    onPressed:
        onPressed ??
        () => context.read<SignInWithBloc>().add(SignInWithGoogle(demoServer: demoServer)),
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
      const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
    ],
  );
}

/// Video instruction URLs for the iOS PWA installation guide.
class IosPwaInstallVideoInstructionUrls {
  final String ios18LightTheme;
  final String ios18DarkTheme;
  final String ios26LightTheme;
  final String ios26DarkTheme;

  const IosPwaInstallVideoInstructionUrls({
    required this.ios18LightTheme,
    required this.ios18DarkTheme,
    required this.ios26LightTheme,
    required this.ios26DarkTheme,
  });
}

class IosPwaInstallationGuide extends StatefulWidget {
  const IosPwaInstallationGuide({super.key});

  @override
  State<IosPwaInstallationGuide> createState() => _IosPwaInstallationGuideState();
}

class _IosPwaInstallationGuideState extends State<IosPwaInstallationGuide> {
  final _videoInstructions = IOS_PWA_INSTALL_VIDEO_INSTRUCTION_URLS;
  bool _videoInstructionsVisible = true;

  @override
  Widget build(BuildContext context) {
    final ios26OrNewer = isIos26OrNewer();
    final videoInstructions = _videoInstructions;

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
              if (videoInstructions != null) ...[
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _videoInstructionsVisible = !_videoInstructionsVisible;
                    });
                  },
                  icon: Icon(
                    _videoInstructionsVisible ? Icons.text_fields : Icons.play_circle_outline,
                  ),
                  label: Text(
                    _videoInstructionsVisible
                        ? context.strings.login_screen_ios_pwa_install_text_instructions_button
                        : context.strings.login_screen_ios_pwa_install_video_instructions_button,
                  ),
                ),
                const SizedBox(height: 8),
                if (_videoInstructionsVisible)
                  _videoInstructionsWidget(context, videoInstructions)
                else
                  _textInstructions(context, ios26OrNewer),
              ] else ...[
                const SizedBox(height: 24),
                _textInstructions(context, ios26OrNewer),
              ],
            ],
          ),
        ),
        const Spacer(flex: 7),
      ],
    );
  }

  Widget _videoInstructionsWidget(
    BuildContext context,
    IosPwaInstallVideoInstructionUrls videoInstructions,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final url = isIos26OrNewer()
        ? (isDark ? videoInstructions.ios26DarkTheme : videoInstructions.ios26LightTheme)
        : (isDark ? videoInstructions.ios18DarkTheme : videoInstructions.ios18LightTheme);

    return _AutoplayVideo(url: url);
  }

  Widget _textInstructions(BuildContext context, bool ios26OrNewer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _installStepWithIcons(
          context,
          ios26OrNewer
              ? context.strings.login_screen_ios_pwa_install_step1_ios26
              : context.strings.login_screen_ios_pwa_install_step1,
          ios26OrNewer
              ? [const Icon(Icons.ios_share, size: 24), const Icon(Icons.more_horiz, size: 24)]
              : [const Icon(Icons.ios_share, size: 24)],
        ),
        const SizedBox(height: 12),
        _installStepWithIcons(
          context,
          ios26OrNewer
              ? context.strings.login_screen_ios_pwa_install_step2_ios26
              : context.strings.login_screen_ios_pwa_install_step2,
          ios26OrNewer
              ? [const Icon(Icons.keyboard_arrow_up, size: 24), const _AddToHomeScreenIcon()]
              : [const _AddToHomeScreenIcon()],
        ),
        const SizedBox(height: 12),
        _installStep(context, context.strings.login_screen_ios_pwa_install_step3),
        const SizedBox(height: 12),
        _installStep(context, context.strings.login_screen_ios_pwa_install_step4),
      ],
    );
  }
}

class _AutoplayVideo extends StatefulWidget {
  final String url;

  const _AutoplayVideo({required this.url});

  @override
  State<_AutoplayVideo> createState() => _AutoplayVideoState();
}

class _AutoplayVideoState extends State<_AutoplayVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _configureAndInitController();
  }

  Future<void> _configureAndInitController() async {
    await _controller.setLooping(true);
    if (!mounted) return;
    await _controller.initialize();
    if (!mounted) return;
    setState(() {});
    await _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400),
        child: AspectRatio(aspectRatio: 1, child: VideoPlayer(_controller)),
      ),
    );
  }
}

Widget _installStep(BuildContext context, String text) {
  return Text(text, style: Theme.of(context).textTheme.bodyMedium);
}

Widget _installStepWithIcons(BuildContext context, String text, List<Widget> icons) {
  return Row(
    children: [
      Flexible(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
      const SizedBox(width: 8),
      ...icons.map((icon) => Padding(padding: const EdgeInsets.only(left: 4), child: icon)),
    ],
  );
}

/// iOS style "Add to Home Screen" icon: a rounded square border with a plus.
class _AddToHomeScreenIcon extends StatelessWidget {
  const _AddToHomeScreenIcon();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      width: 28,
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 1.8),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Icon(Icons.add_rounded, size: 24, color: color),
        ],
      ),
    );
  }
}
