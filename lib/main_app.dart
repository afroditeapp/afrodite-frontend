import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/data/app_version.dart';
import 'package:app/database/common_database_manager.dart';
import 'package:app/localizations.dart';

import 'package:app/l10n/app_localizations.dart';
import 'package:app/l10n/app_localizations_en.dart';
import 'package:app/logic/app/main_state.dart';
import 'package:app/ui/utils/app_lifecycle_handler.dart';
import 'package:app/ui/utils/main_state_ui_logic.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

final globalScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> startApp() async {
  // CommonDatabaseManager requires initialized AppVersionManager
  await AppVersionManager.getInstance().init();
  // Locale saving needs database so init here
  await CommonDatabaseManager.getInstance().init();

  runApp(
    MultiBlocProvider(
      providers: [
        // Navigation
        BlocProvider(create: (_) => MainStateBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Don't use context.strings here to avoid exception on web
      title: AppLocalizationsEn().app_name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light().copyWith(pageTransitionsTheme: createPageTransitionsTheme()),
      darkTheme: ThemeData.dark().copyWith(pageTransitionsTheme: createPageTransitionsTheme()),
      themeMode: ThemeMode.system,
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return const GlobalLocalizationsInitializer(
          child: AppLifecycleHandler(child: MainStateUiLogic()),
        );
      },
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
