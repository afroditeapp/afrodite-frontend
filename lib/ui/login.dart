import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";


import 'package:openapi/api.dart' as client_api;

const commonPadding = 5.0;

class LoginPage extends RootPage {
  const LoginPage({Key? key}) : super(MainState.loginRequired, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Text(
              "Pihka"
            ),
            const ElevatedButton(
              child: Text(
                  "Back"
              ),
              onPressed: null,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            ElevatedButton(
              child: const Text(
                  "Register"
              ),
              onPressed: () => context.read<AccountBloc>().add(DoRegister()),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            BlocBuilder<AccountBloc, AccountData>(
              buildWhen: (previous, current) => previous.accountId != current.accountId,
              builder: (_, state) {
                return Text(
                  "Account ID: ${state.accountId ?? "not set"}"
                );
              }
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            ElevatedButton(
              child: const Text(
                  "Login"
              ),
              onPressed: () => context.read<AccountBloc>().add(DoLogin()),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            BlocBuilder<AccountBloc, AccountData>(
              buildWhen: (previous, current) => previous.apiKey != current.apiKey,
              builder: (_, state) {
                return Text(
                  "API key: ${state.apiKey ?? "not set"}"
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
