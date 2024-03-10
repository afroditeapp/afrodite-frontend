import "package:flutter/material.dart";
import "package:pihka_frontend/assets.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/main.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class SplashScreen extends RootScreen {
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
                ImageAsset.appLogo.path,
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
