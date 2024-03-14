import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/account_banned.dart";
import "package:pihka_frontend/ui/demo_account.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/ui/login_new.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/pending_deletion.dart";
import "package:pihka_frontend/ui/unsupported_client.dart";

abstract class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  void runOnceBeforeNavigatedTo(BuildContext context) {}
  Widget buildRootWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainStateBloc, MainState>(
      listener: (context, state) {
        final screen = switch (state) {
          MainState.loginRequired => const LoginScreen(),
          MainState.demoAccount => const DemoAccountScreen(),
          MainState.initialSetup => const InitialSetupScreen(),
          MainState.initialSetupComplete => const InitialSetupScreen(),
          MainState.accountBanned => const AccountBannedScreen(),
          MainState.pendingRemoval => const PendingDeletionPage(),
          MainState.unsupportedClientVersion => const UnsupportedClientScreen(),
          MainState.splashScreen => null,
        };

        if (screen != null) {
          screen.runOnceBeforeNavigatedTo(context);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: (_) => screen),
            (_) => false,
          );
        }
      },
      child: buildRootWidget(context)
    );
  }
}
