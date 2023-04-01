import 'package:flutter/material.dart';

import 'package:openapi/api.dart' as client_api;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const commonPadding = 5.0;

class _LoginPageState extends State<LoginPage> {

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
    setState(() {
      //_counter++;
    });
  }
  void _buttonTest() {
    Navigator.of(context).pop();
    // setState(() {
    //
    // });
  }

  Future<void> _register() async {
    print("register");
    final res = await client_api.AccountApi(_apiClient).postRegister();
    if (res != null) {
      setState(() {
        _accountId = res.accountId;
      });
    }

  }

  void _login() {
    print("login");
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    //final text = "t"

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
              onPressed: _login,
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


