import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/utils/root_page.dart";

class AccountBannedPage extends RootPage {
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
