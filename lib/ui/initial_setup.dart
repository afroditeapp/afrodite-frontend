import "package:flutter/material.dart";
import "package:pihka_frontend/ui/initial_setup/email.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

// TODO: save initial setup values, so that it will be possible to restore state
//       if system kills the app when selecting profile photo

class InitialSetupScreen extends RootScreen {
  const InitialSetupScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return const AskEmailScreen();
  }
}
