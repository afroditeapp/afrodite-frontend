import "package:flutter/material.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class AccountBannedScreen extends RootScreen {
  const AccountBannedScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Account banned"),
              ElevatedButton(
                child: const Text("Remove account"),
                onPressed: () {

                }
              )
            ],
          ),
        ),
      );
  }
}
