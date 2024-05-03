
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:pihka_frontend/logic/app/app_visibility_provider.dart';

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

    _listener = AppLifecycleListener(
      onShow: () {
        AppVisibilityProvider.getInstance().setForeground(true);
      },
      onHide: () {
        AppVisibilityProvider.getInstance().setForeground(false);
      },
      onDetach: () {
        // There seems to not be any reliable way to close resources
        // properly so close the process.
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
