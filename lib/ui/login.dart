import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  "Login"
              ),
              onPressed: _buttonTest,
            ),
          ],
        ),
      ),
    );
  }
}


