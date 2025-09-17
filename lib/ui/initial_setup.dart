import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:flutter/material.dart";
import "package:app/ui/initial_setup/email.dart";

// TODO(prod): save initial setup values, so that it will be possible to restore state
//       if system kills the app when selecting profile photo

class InitialSetupPage extends MyScreenPage<()> with SimpleUrlParser<InitialSetupPage> {
  InitialSetupPage() : super(builder: (_) => InitialSetupScreen());

  @override
  InitialSetupPage create() => InitialSetupPage();
}

class InitialSetupScreen extends StatelessWidget {
  const InitialSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AskEmailScreen();
  }
}
