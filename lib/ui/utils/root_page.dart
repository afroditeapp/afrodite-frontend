import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/account_banned.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/pending_deletion.dart";
import "package:pihka_frontend/ui/unsupported_client.dart";

abstract class RootPage extends StatelessWidget {
  const RootPage(this.rootPageIdentifier, {Key? key}) : super(key: key);

  final MainState rootPageIdentifier;

  Widget buildRootWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainStateBloc, MainState>(
      listener: (context, state) {
        if (state == rootPageIdentifier) {
          return;
        }

        final page = switch (state) {
          MainState.loginRequired => LoginPage(),
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
