import 'package:app/data/utils/repository_instances.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/sign_in_with_management.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/account/sign_in_with_management.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/login/widgets.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/sign_in_with_google_web_button/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void openSignInWithManagement(BuildContext context) {
  final r = context.read<RepositoryInstances>();
  MyNavigator.push(context, SignInWithManagementPage(r));
}

class SignInWithManagementPage extends MyScreenPage<()>
    with SimpleUrlParser<SignInWithManagementPage> {
  final RepositoryInstances r;
  SignInWithManagementPage(this.r) : super(builder: (_) => _SignInWithManagementScreenLoader(r: r));

  @override
  SignInWithManagementPage create() => SignInWithManagementPage(r);
}

class _SignInWithManagementScreenLoader extends StatefulWidget {
  final RepositoryInstances r;
  const _SignInWithManagementScreenLoader({required this.r});

  @override
  State<_SignInWithManagementScreenLoader> createState() =>
      _SignInWithManagementScreenLoaderState();
}

class _SignInWithManagementScreenLoaderState extends State<_SignInWithManagementScreenLoader> {
  @override
  void initState() {
    super.initState();
    context.read<SignInWithManagementBloc>().add(ReloadSignInWithManagement());
  }

  @override
  Widget build(BuildContext context) {
    return SignInWithManagementScreen();
  }
}

class SignInWithManagementScreen extends StatelessWidget {
  const SignInWithManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<SignInWithManagementBloc, SignInWithManagementBlocData>(
      context: context,
      pageKey: null,
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.sign_in_with_management_screen_title)),
        body: BlocBuilder<SignInWithManagementBloc, SignInWithManagementBlocData>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.isError) {
              return Center(child: Text(context.strings.generic_error));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(4)),
                  _AppleSection(apple: state.apple),
                  const Divider(),
                  _GoogleSection(google: state.google),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AppleSection extends StatelessWidget {
  final bool apple;
  const _AppleSection({required this.apple});

  @override
  Widget build(BuildContext context) {
    if (apple) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          settingsCategoryTitle(
            context,
            context.strings.sign_in_with_management_screen_apple_title,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          hPad(
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    context.strings.sign_in_with_management_screen_apple_unlink_confirm_title,
                  );
                  if (context.mounted && confirmed == true) {
                    context.read<SignInWithManagementBloc>().add(UnlinkAppleSignInWith());
                  }
                },
                child: Text(context.strings.generic_unlink),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        settingsCategoryTitle(context, context.strings.sign_in_with_management_screen_apple_title),
        const Padding(padding: EdgeInsets.only(top: 8)),
        hPad(Text(context.strings.sign_in_with_management_screen_apple_not_linked)),
        const Padding(padding: EdgeInsets.only(top: 8)),
        hPad(
          SizedBox(
            height: SIGN_IN_BUTTON_HEIGHT,
            child: Center(
              child: SizedBox(
                width: 240,
                child: signInWithAppleButton(
                  context,
                  onPressed: () =>
                      context.read<SignInWithManagementBloc>().add(LinkAppleSignInWith()),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GoogleSection extends StatelessWidget {
  final bool google;
  const _GoogleSection({required this.google});

  @override
  Widget build(BuildContext context) {
    if (google) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          settingsCategoryTitle(
            context,
            context.strings.sign_in_with_management_screen_google_title,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          hPad(
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final confirmed = await showConfirmDialog(
                    context,
                    context.strings.sign_in_with_management_screen_google_unlink_confirm_title,
                  );
                  if (context.mounted && confirmed == true) {
                    context.read<SignInWithManagementBloc>().add(UnlinkGoogleSignInWith());
                  }
                },
                child: Text(context.strings.generic_unlink),
              ),
            ),
          ),
        ],
      );
    }

    final Widget button;
    if (kIsWeb) {
      button = SizedBox(
        height: SIGN_IN_BUTTON_HEIGHT,
        child: Center(
          child: signInWithGoogleButtonWeb(
            Theme.of(context).brightness == Brightness.dark,
            context.strings.localeName,
          ),
        ),
      );
    } else {
      button = SizedBox(
        height: SIGN_IN_BUTTON_HEIGHT,
        child: Center(
          child: SizedBox(
            width: 240,
            child: signInWithGoogleButton(
              context,
              onPressed: () => context.read<SignInWithManagementBloc>().add(LinkGoogleSignInWith()),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        settingsCategoryTitle(context, context.strings.sign_in_with_management_screen_google_title),
        const Padding(padding: EdgeInsets.only(top: 8)),
        hPad(Text(context.strings.sign_in_with_management_screen_google_not_linked)),
        const Padding(padding: EdgeInsets.only(top: 8)),
        hPad(button),
      ],
    );
  }
}
