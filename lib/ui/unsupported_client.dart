import "package:flutter/material.dart";

// TODO(prod): Translate text

class UnsupportedClientScreen extends StatelessWidget {
  const UnsupportedClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Current client version is not supported. Please update the app."),
            ],
          ),
        ),
      );
  }
}
