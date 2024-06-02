import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/logic/app/bottom_navigation_state.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/logic/app/navigator_state.dart";
import "package:pihka_frontend/ui/account_banned.dart";
import "package:pihka_frontend/ui/demo_account.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/ui/login_new.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/pending_deletion.dart";
import "package:pihka_frontend/ui/unsupported_client.dart";
import "package:pihka_frontend/ui/utils/notification_payload_handler.dart";

final log = Logger("RootScreen");

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
          MainState.initialSetupComplete => const NormalStateScreen(),
          MainState.accountBanned => const AccountBannedScreen(),
          MainState.pendingRemoval => const PendingDeletionPage(),
          MainState.unsupportedClientVersion => const UnsupportedClientScreen(),
          MainState.splashScreen => null,
        };

        if (screen == null) {
          return;
        }

        var appLaunchPayloadNullable = NotificationManager.getInstance().getAndRemoveAppLaunchNotificationPayload();
        if (state != MainState.initialSetupComplete) {
          // Clear the app launch notification payload if it exists as
          // it should be handled only when state is
          // MainState.initialSetupComplete.
          appLaunchPayloadNullable = null;
          BottomNavigationStateBlocInstance.getInstance()
            .bloc
            .add(ChangeScreen(BottomNavigationScreenId.profiles, resetIsScrolledValues: true));
        }
        final appLaunchPayload = appLaunchPayloadNullable;

        screen.runOnceBeforeNavigatedTo(context);

        final rootPage = NewPageDetails(
          MaterialPage<void>(child: screen),
        );

        if (appLaunchPayload != null) {
          log.info("Handling app launch notification payload");
          createHandlePayloadCallback(
            context,
            showError: false,
            navigateToAction: (bloc, page) {
              final pages = [rootPage];
              if (page != null) {
                pages.add(page);
              }
              bloc.replaceAllWith(
                pages,
                disableAnimation: true,
              );
            },
          )(appLaunchPayload);
        } else {
          MyNavigator.replaceAllWith(
            context,
            [rootPage],
          );
        }
      },
      child: buildRootWidget(context)
    );
  }
}
