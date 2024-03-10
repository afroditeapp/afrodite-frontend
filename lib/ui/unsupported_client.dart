import "package:flutter/material.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class UnsupportedClientPage extends RootScreen {
  const UnsupportedClientPage({Key? key}) : super(MainState.unsupportedClientVersion, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Current client version is not supported. Please update the app."),
            ],
          ),
        ),
      );
  }
}
