

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

abstract class AppSingleton {
  /// Initialize the singleton. Runs when app splash screen is visible.
  Future<void> init();
}

abstract class AppSingletonNoInit {}

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


class TaskStatus {
  final BehaviorSubject<bool> taskRunning = BehaviorSubject.seeded(false);

  void cancel() {
    taskRunning.add(false);
  }

  void start() {
    taskRunning.add(true);
  }

  Future<void> taskCancelled() {
    final value = taskRunning.stream.where((event) => !event).first;
    return value;
  }
}


extension LogUtils on Logger {
  void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    severe(message, error, stackTrace);
  }
}
