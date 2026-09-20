import 'dart:async';

import 'package:app/config_slim.dart';
import 'package:app/main.dart';
import 'package:app/ui_utils/image_slim.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double SPLASH_SCREEN_APP_ICON_SIZE = 100.0;

const Duration SPLASH_SCREEN_PROGRESS_DELAY = Duration(seconds: 2);

class SplashScreenLayout extends StatelessWidget {
  const SplashScreenLayout({
    super.key,
    required this.bottom,
    this.zeroSizedWidget,
    required this.showAppIcon,
  });

  final Widget bottom;
  final Widget? zeroSizedWidget;

  /// Whether the app icon should be shown. On Android and iOS the native
  /// splash screen already shows the app icon, so it's hidden here.
  final bool showAppIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            if (showAppIcon)
              Image.asset(
                APP_LOGO_PATH,
                width: SPLASH_SCREEN_APP_ICON_SIZE,
                height: SPLASH_SCREEN_APP_ICON_SIZE,
                cacheHeight: calculateCachedImageSize(context, SPLASH_SCREEN_APP_ICON_SIZE),
              )
            else
              const SizedBox(
                width: SPLASH_SCREEN_APP_ICON_SIZE,
                height: SPLASH_SCREEN_APP_ICON_SIZE,
              ),
            Expanded(child: bottom),
            ?zeroSizedWidget,
          ],
        ),
      ),
    );
  }
}

/// Dependency free splash screen so that web version of this
/// app shows splash screen quickly.
class LoadingSplashScreen extends StatefulWidget {
  const LoadingSplashScreen({super.key});

  @override
  State<LoadingSplashScreen> createState() => _LoadingSplashScreenState();
}

class _LoadingSplashScreenState extends State<LoadingSplashScreen> {
  bool _showProgress = false;
  bool _loadingFailed = false;
  Timer? _timer;
  StreamSubscription<bool>? _loadingFailedSub;

  @override
  void initState() {
    super.initState();
    _loadingFailedSub = appLoadingFailedStream().listen((failed) {
      if (failed && mounted) {
        setState(() => _loadingFailed = true);
      }
    });
    _timer = Timer(SPLASH_SCREEN_PROGRESS_DELAY, () {
      if (mounted) {
        setState(() => _showProgress = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _loadingFailedSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenLayout(
      showAppIcon: kIsWeb,
      bottom: _loadingFailed
          ? const Center(child: Text('App loading failed'))
          : _showProgress
          ? const Center(child: CircularProgressIndicator())
          : const SizedBox.shrink(),
    );
  }
}
