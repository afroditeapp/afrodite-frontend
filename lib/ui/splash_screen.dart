import "package:app/localizations.dart";
import "package:app/logic/app/global_init.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/loading_splash_screen.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class SplashPage extends MyScreenPage<()> with SimpleUrlParser<SplashPage> {
  SplashPage() : super(builder: (_) => SplashScreen());

  @override
  SplashPage create() => SplashPage();
}

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
    return SplashScreenLayout(
      bottom: _errorText(context),
      showAppIcon: kIsWeb,
      zeroSizedWidget: FutureBuilder(
        future: GlobalInitManager.getInstance().triggerGlobalInit(),
        builder: (context, snapshot) {
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _errorText(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, state) {
        if (state.data == GlobalInitState.appIsAlreadyRunning) {
          return Center(child: Text(context.strings.splash_screen_app_is_already_running));
        } else if (state.data == GlobalInitState.appVersionDowngradeDetected) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.strings.splash_screen_app_version_downgrade_detected,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () async {
                      await GlobalInitManager.getInstance().ignoreVersionDowngradeAndContinueInit();
                    },
                    child: Text(context.strings.generic_skip),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
