import 'dart:developer' as developer;

import 'package:app/config.dart';
import 'package:app/data/app_version.dart';
import 'package:encryption/encryption.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:app/api/error_manager.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/data/push_notification_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/localizations.dart';

import 'package:app/logic/app/main_state.dart';
import 'package:app/storage/encryption.dart';

import 'package:app/l10n/app_localizations.dart';
import 'package:app/l10n/app_localizations_en.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:app/ui/utils/app_lifecycle_handler.dart';
import 'package:app/ui/utils/main_state_ui_logic.dart';
import 'package:app/utils/camera.dart';

import 'package:rxdart/rxdart.dart';

final log = Logger("main");

// TODO(prod): When there are two conversation notifications, opening those
//             one by one, results in the second opened to below the first.
// TODO(prod): When conversation is opened, remove only the related conversation
//             notification.

bool loggerInitDone = false;

void initLogging() {
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
      // TODO(prod): Remove print if logcat printing works somehow
      // without print.
      if (kDebugMode) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      }

      developer.log(
        record.message,
        name: record.loggerName,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        level: record.level.value,
      );
  });
}

Future<void> main() async {
  initLogging();
  setUrlStrategy(null);

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(DEFAULT_ORIENTATIONS);

  await GlobalInitManager.getInstance().init();

  // Locale saving needs database so init here
  await SecureStorageManager.getInstance().init();
  await BackgroundDatabaseManager.getInstance().init();

  runApp(
    MultiBlocProvider(
      providers: [
        // Navigation
        BlocProvider(create: (_) => MainStateBloc()),
      ],
      child: const MyApp(),
    )
  );
}

final globalScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Don't use context.strings here to avoid exception on web
      title: AppLocalizationsEn().app_name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light().copyWith(
        pageTransitionsTheme: createPageTransitionsTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        pageTransitionsTheme: createPageTransitionsTheme(),
      ),
      themeMode: ThemeMode.system,
      home: const GlobalLocalizationsInitializer(
        child: AppLifecycleHandler(
          child: MainStateUiLogic(),
        ),
      ),
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

PageTransitionsTheme createPageTransitionsTheme() {
  return const PageTransitionsTheme(
    builders: {
      // TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      /*
      When testing the predictive back gestures page transitions there were
      exception for some reason when navigating back to settings page.
      I do not remember from what page the back navigation started.

      ════════ Exception caught by animation library ═════════════════════════════════
      The following assertion was thrown while notifying status listeners for AnimationController:
      'package:flutter/src/widgets/navigator.dart': Failed assertion: line 5473 pos 12: '_userGesturesInProgress > 0': is not true.

      Either the assertion indicates an error in the framework itself, or we should provide substantially more information in this error message to help you determine and fix the underlying cause.
      In either case, please report this assertion by filing a bug on GitHub:
        https://github.com/flutter/flutter/issues/new?template=2_bug.yml

      When the exception was thrown, this was the stack:
      #2      NavigatorState.didStopUserGesture (package:flutter/src/widgets/navigator.dart:5473:12)
      navigator.dart:5473
      #3      TransitionRoute._handleDragEnd.<anonymous closure> (package:flutter/src/widgets/routes.dart:547:20)
      routes.dart:547
      #4      AnimationLocalStatusListenersMixin.notifyStatusListeners (package:flutter/src/animation/listener_helpers.dart:240:19)
      listener_helpers.dart:240
      #5      AnimationController._checkStatusChanged (package:flutter/src/animation/animation_controller.dart:841:7)
      animation_controller.dart:841
      #6      AnimationController._tick (package:flutter/src/animation/animation_controller.dart:857:5)
      animation_controller.dart:857
      #7      Ticker._tick (package:flutter/src/scheduler/ticker.dart:258:12)
      ticker.dart:258
      #8      SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1392:15)
      binding.dart:1392
      #9      SchedulerBinding.handleBeginFrame.<anonymous closure> (package:flutter/src/scheduler/binding.dart:1235:11)
      binding.dart:1235
      #10     _LinkedHashMapMixin.forEach (dart:collection-patch/compact_hash.dart:633:13)
      compact_hash.dart:633
      #11     SchedulerBinding.handleBeginFrame (package:flutter/src/scheduler/binding.dart:1233:17)
      binding.dart:1233
      #12     SchedulerBinding._handleBeginFrame (package:flutter/src/scheduler/binding.dart:1150:5)
      binding.dart:1150
      #13     _invoke1 (dart:ui/hooks.dart:328:13)
      hooks.dart:328
      #14     PlatformDispatcher._beginFrame (dart:ui/platform_dispatcher.dart:397:5)
      platform_dispatcher.dart:397
      #15     _beginFrame (dart:ui/hooks.dart:272:31)
      hooks.dart:272
      (elided 2 frames from class _AssertionError)

      The AnimationController notifying status listeners was: AnimationController#1266f(⏮ 0.000; paused; for _PageBasedMaterialPageRoute<void>(null))
      ════════════════════════════════════════════════════════════════════════════════
      */
      TargetPlatform.android: ZoomPageTransitionsBuilder(allowSnapshotting: false),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}

class GlobalLocalizationsInitializer extends StatelessWidget {
  final Widget child;
  const GlobalLocalizationsInitializer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    // Init correct localizations to R class.
    final _ = context.strings.app_name;
    return child;
  }
}

class GlobalInitManager {
  GlobalInitManager._private();
  static final _instance = GlobalInitManager._private();
  factory GlobalInitManager.getInstance() {
    return _instance;
  }

  final PublishSubject<void> _startInit = PublishSubject();
  bool _globalInitDone = false;

  final BehaviorSubject<bool> _globalInitCompleted = BehaviorSubject.seeded(false);
  Stream<bool> get globalInitCompletedStream => _globalInitCompleted.stream;

  /// Run this in app main function.
  Future<void> init() async {
    _startInit.stream
      .asyncMap((event) async => await _runInit())
      .listen((event) {});
  }

  Future<void> _runInit() async {
    if (_globalInitDone) {
      return;
    }
    _globalInitDone = true;

    await DatabaseManager.getInstance().init();
    await ImageEncryptionManager.getInstance().init();

    await ErrorManager.getInstance().init();
    await ImageCacheData.getInstance().init();
    await CameraManager.getInstance().init();
    await NotificationManager.getInstance().init();
    await PushNotificationManager.getInstance().init();
    await AppVersionManager.getInstance().init();

    await LoginRepository.getInstance().init();

    // Initializes formatting for other locales as well
    await initializeDateFormatting("en_US", null);

    log.fine("Global init completed");
    _globalInitCompleted.add(true);
  }

  /// Global init should be triggerred after when splash screen
  /// is visible.
  Future<void> triggerGlobalInit() async {
    _startInit.add(null);
  }
}

// This is based on
// https://api.flutter.dev/flutter/widgets/TransitionDelegate-class.html
class ReplaceSplashScreenTransitionDelegate extends TransitionDelegate<void> {
  const ReplaceSplashScreenTransitionDelegate();

  @override
  Iterable<RouteTransitionRecord> resolve({
    required List<RouteTransitionRecord> newPageRouteHistory,
    required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
    required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes,
  }) {
    final List<RouteTransitionRecord> results = <RouteTransitionRecord>[];

    var first = true;
    for (final RouteTransitionRecord pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
          if (first) {
            first = false;
            pageRoute.markForAdd();
          } else {
            // Push other than main screen, so that exit transitions will
            // work.
            pageRoute.markForPush();
          }
      }
      results.add(pageRoute);
    }

    for (final RouteTransitionRecord exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        // Pop the splash screen, so that main screen will not be visible
        // for short time to the user.
        exitingPageRoute.markForPop();
        final List<RouteTransitionRecord>? pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final RouteTransitionRecord pagelessRoute in pagelessRoutes) {
              pagelessRoute.markForComplete();
            }
        }
      }
      results.add(exitingPageRoute);

    }
    return results;
  }
}
