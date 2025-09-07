import "package:app/localizations.dart";
import "package:app/ui_utils/image.dart";
import "package:flutter/material.dart";
import "package:app/assets.dart";
import "package:app/main.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Stream<GlobalInitState> stream;

  @override
  void initState() {
    super.initState();
    stream = GlobalInitManager.getInstance().globalInitState;
  }

  @override
  Widget build(BuildContext context) {
    const appIconSize = 100.0;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              ImageAsset.appLogo.path,
              width: appIconSize,
              height: appIconSize,
              cacheHeight: calculateCachedImageSize(context, appIconSize),
            ),
            Expanded(
              child: StreamBuilder(
                stream: stream,
                builder: (context, state) {
                  if (state.data == GlobalInitState.appIsAlreadyRunning) {
                    return Center(
                      child: Text(context.strings.splash_screen_app_is_already_running),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
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
