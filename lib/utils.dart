

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

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
