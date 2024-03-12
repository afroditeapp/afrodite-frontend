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
  const RootScreen(this.rootScreenIdentifier, {Key? key}) : super(key: key);

  // TODO: remove this
  final MainState rootScreenIdentifier;

  Widget buildRootWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainStateBloc, MainState>(
      listener: (context, state) {
        if (state == rootScreenIdentifier) {
          return;
        }

        final page = switch (state) {
          MainState.loginRequired => LoginScreen(),
          MainState.demoAccount => const DemoAccountScreen(),
          MainState.initialSetup => const InitialSetupPage(),
          MainState.initialSetupComplete => const NormalStatePage(),
          MainState.accountBanned => const AccountBannedPage(),
          MainState.pendingRemoval => const PendingDeletionPage(),
          MainState.unsupportedClientVersion => const UnsupportedClientPage(),
          MainState.splashScreen => null,
        };

        if (page != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(builder: (_) => page),
            (_) => false,
          );
        }
      },
      child: buildRootWidget(context)
    );
  }
}
