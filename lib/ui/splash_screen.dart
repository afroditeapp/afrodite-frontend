import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/utils/root_page.dart";

class SplashScreen extends RootPage {
  const SplashScreen({Key? key}) : super(MainState.splashScreen, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const Text("Pihka"),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: () =>
                  context.read<MainStateBloc>().add(ToLoginRequiredScreen())
              )
            ],
          ),
        ),
      );
  }
}
