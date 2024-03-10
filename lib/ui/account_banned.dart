import "package:flutter/material.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class AccountBannedPage extends RootScreen {
  const AccountBannedPage({Key? key}) : super(MainState.accountBanned, key: key);

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
