import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:app/logic/app/app_visibility_provider.dart';

class AppLifecycleHandler extends StatefulWidget {
  final Widget child;
  const AppLifecycleHandler({required this.child, super.key});

  @override
  State<AppLifecycleHandler> createState() => _AppLifecycleHandlerState();
}

class _AppLifecycleHandlerState extends State<AppLifecycleHandler> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    AppVisibilityProvider.getInstance().setForeground(true);

    _listener = AppLifecycleListener(
      onShow: () {
        AppVisibilityProvider.getInstance().setForeground(true);
      },
      onHide: () {
        AppVisibilityProvider.getInstance().setForeground(false);
      },
      onDetach: () {
        // There seems to not be any reliable way to close resources
        // properly so close the process. Without this on Android, system
        // back button navigation away from the app and closes second main
        // isolate but database isolates are not closed.
        // (FirebaseMessaging.onBackgroundMessage creates the another main
        // isolate.)
        exit(0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    super.dispose();
    _listener.dispose();
  }
}
