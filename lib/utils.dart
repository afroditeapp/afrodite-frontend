import 'dart:async';

mixin ActionRunner {
  bool isRunning = false;

  /// Helper method for preventing spamming of actions for example with
  /// buttons.
  Future<void> runOnce(FutureOr<void> Function() action) async {
    if (!isRunning) {
      isRunning = true;
      await action();
      isRunning = false;
    }
  }
}
