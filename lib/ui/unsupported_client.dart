import "package:flutter/material.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class UnsupportedClientScreen extends RootScreen {
  const UnsupportedClientScreen({Key? key}) : super(key: key);

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
