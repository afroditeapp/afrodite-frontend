

import 'dart:async';

abstract class AppSingleton {
   Future<void> init();
}

mixin ActionRunner {
  bool isRunning = false;
  Future<void> runOnce(FutureOr<void> Function() action) async {
    if (!isRunning) {
      isRunning = true;
      await action();
      isRunning = false;
    }
  }
}
