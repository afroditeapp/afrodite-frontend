import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";


import 'package:openapi/api.dart' as client_api;

class LoginPageOld extends StatefulWidget {
  const LoginPageOld({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPageOld> createState() => _LoginPageState();
}

const commonPadding = 5.0;

class _LoginPageState extends State<LoginPageOld> {



  @override
  Widget build(BuildContext context) {
    //final text = "t"

    return Text("");
  }
}


class LoginPage extends RootPage {
  LoginPage({Key? key}) : super(MainState.loginRequired, key: key);

  var _apiClient = client_api.ApiClient(basePath: "http://10.0.2.2:3000");
  String _accountId = "";

  String accountIdUiText() {
    if (_accountId.isEmpty) {
      return "Not registerd";
    } else {
      return _accountId;
    }
  }

  void _incrementCounter() {

  }
  void _buttonTest() {
    //
    // });
  }

  Future<void> _register() async {
    print("register");
    final res = await client_api.AccountApi(_apiClient).postRegister();
    if (res != null) {
        print(res);
    }

  }

  void _login(BuildContext context) {
    print("login");
    // setState(() {
    //
    // });
  }

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
            ElevatedButton(
              child: const Text(
                  "Back"
              ),
              onPressed: _buttonTest,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            ElevatedButton(
              child: const Text(
                  "Register"
              ),
              onPressed: _register,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            Text(
                accountIdUiText()
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            ElevatedButton(
              child: const Text(
                  "Login"
              ),
              onPressed: () => context.read<MainStateBloc>().add(ToPendingRemovalScreen()),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: commonPadding)),
            const Text(
                "API key: "
            ),
          ],
        ),
      ),
    );
  }
}
