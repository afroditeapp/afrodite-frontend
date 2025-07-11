import "package:flutter/material.dart";
import "package:app/ui/initial_setup/email.dart";

// TODO: save initial setup values, so that it will be possible to restore state
//       if system kills the app when selecting profile photo

class InitialSetupScreen extends StatelessWidget {
  const InitialSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AskEmailScreen();
  }
}
