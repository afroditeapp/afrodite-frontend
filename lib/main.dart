import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/assets.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/logic/server/address.dart';
import 'package:pihka_frontend/logic/sign_in_with.dart';

import 'package:pihka_frontend/ui/normal.dart';
import 'package:pihka_frontend/ui/login.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/ui/splash_screen.dart';
import 'package:pihka_frontend/ui/utils/camera_page.dart';
import 'package:pihka_frontend/utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:rxdart/rxdart.dart';

final log = Logger("main");

Future<void> main() async {
  // TODO: change log level before release?
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
      developer.log(
        record.message,
        name: record.loggerName,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        level: record.level.value,
      );
  });

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = DebugObserver();

  await GlobalInitManager.getInstance().init();

  var accountRepository = AccountRepository.getInstance();
  var mediaRepository = MediaRepository.getInstance();
  var profileRepository = ProfileRepository.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainStateBloc(accountRepository)),
        BlocProvider(create: (_) => AccountBloc(accountRepository)),
        BlocProvider(create: (_) => InitialSetupBloc(accountRepository)),
        BlocProvider(create: (_) => ServerAddressBloc(accountRepository)),
        BlocProvider(create: (_) => ProfileBloc(accountRepository, profileRepository, mediaRepository)),

        // Login
        BlocProvider(create: (_) => SignInWithBloc(accountRepository)),

        // Admin features related blocs
        BlocProvider(create: (_) => ImageModerationBloc(mediaRepository)),
      ],
      child: const MyApp(),
    )
  );
}

final globalScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pihka',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      // routes: <String, WidgetBuilder> {
      //   "/login": (context) => const LoginPage(title: "Test")
      // },
      debugShowCheckedModeBanner: false,
    );
  }
}


class DebugObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log.finest("${bloc.runtimeType} $change");
  }
}

class GlobalInitManager extends AppSingleton {
  GlobalInitManager._private();
  static final _instance = GlobalInitManager._private();
  factory GlobalInitManager.getInstance() {
    return _instance;
  }

  final PublishSubject<void> startInit = PublishSubject();
  bool _globalInitDone = false;

  /// Run this in app main function.
  @override
  Future<void> init() async {
    startInit.stream
      .asyncMap((event) async => await _runInit())
      .listen((event) {});
  }

  Future<void> _runInit() async {
    if (_globalInitDone) {
      return;
    }
    _globalInitDone = true;

    await initAvailableCameras();
    await ErrorManager.getInstance().init();
    await ApiManager.getInstance().init();
    await ImageCacheData.getInstance().init();

    await AccountRepository.getInstance().init();
    await MediaRepository.getInstance().init();
    await ProfileRepository.getInstance().init();
  }

  /// Global init should be triggerred after when splash screen
  /// is visible.
  Future<void> triggerGlobalInit() async {
    startInit.add(null);
  }
}
