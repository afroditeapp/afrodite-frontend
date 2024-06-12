import "package:flutter/material.dart";

// TODO(prod): Translate text

class AccountBannedScreen extends StatelessWidget {
  const AccountBannedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
