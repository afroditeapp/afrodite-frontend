import 'dart:async';

import 'package:app/config_slim.dart';
import 'package:app/loading_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app/main_app.dart' deferred as main_app;
import 'package:utils/utils.dart';

final BehaviorSubject<bool> _appLoadingFailed = BehaviorSubject<bool>.seeded(false);
Stream<bool> appLoadingFailedStream() => _appLoadingFailed;

final _log = Logger("main");

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

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const LoadingSplashScreen(),
    ),
  );

  try {
    await main_app.loadLibrary();
    await main_app.startApp();
  } catch (e) {
    _log.error(e);
    _appLoadingFailed.add(true);
  }
}
