import "package:flutter/material.dart";
import "package:app/assets.dart";
import "package:app/main.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
