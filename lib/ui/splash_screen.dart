import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/main.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/utils/root_page.dart";

class SplashScreen extends RootPage {
  const SplashScreen({Key? key}) : super(MainState.splashScreen, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    const appIconSize = 100.0;
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/app-icon.png",
                width: appIconSize,
                height: appIconSize,
              ),
              FutureBuilder(
                future: GlobalInitManager.getInstance().triggerGlobalInit(),
                builder: (context, snapshot) {
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      );
  }
}
