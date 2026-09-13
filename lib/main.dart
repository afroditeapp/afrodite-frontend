import 'dart:async';

import 'package:app/config.dart';
import 'package:app/main_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logging/logging.dart';

bool loggerInitDone = false;

void _initLogging() {
  if (loggerInitDone) {
    return;
  }
  loggerInitDone = true;

  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.INFO;
  }

  Logger.root.onRecord.listen((record) {
    final stackTrace = record.stackTrace;
    final stackTraceString = stackTrace != null ? "\n$stackTrace" : "";
    // ignore: avoid_print
    print('[${record.level.name}][${record.loggerName}] ${record.message}$stackTraceString');
  });
}

Future<void> main() async {
  _initLogging();

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(DEFAULT_ORIENTATIONS);

  await startApp();
}
