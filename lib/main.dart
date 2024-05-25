import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/common_repository.dart';
import 'package:pihka_frontend/data/general/image_cache_settings.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/data/push_notification_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/account_details.dart';
import 'package:pihka_frontend/logic/account/demo_account.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';
import 'package:pihka_frontend/logic/app/like_grid_instance_manager.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_payload_handler.dart';
import 'package:pihka_frontend/logic/app/notification_permission.dart';
import 'package:pihka_frontend/logic/app/notification_settings.dart';
import 'package:pihka_frontend/logic/media/content.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/media/image_processing.dart';
import 'package:pihka_frontend/logic/media/new_moderation_request.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/media/select_content.dart';
import 'package:pihka_frontend/logic/profile/attributes.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/edit_profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/location.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/server/address.dart';
import 'package:pihka_frontend/logic/settings/blocked_profiles.dart';
import 'package:pihka_frontend/logic/settings/edit_search_settings.dart';
import 'package:pihka_frontend/logic/settings/search_settings.dart';
import 'package:pihka_frontend/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/logic/sign_in_with.dart';

import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/storage/encryption.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:pihka_frontend/ui/utils/app_lifecycle_handler.dart';
import 'package:pihka_frontend/utils/camera.dart';

import 'package:rxdart/rxdart.dart';

final log = Logger("main");

// TODO: what blocs store state that needs to be cleared on logout?
// Initial setup?
// Change BlocProviders containing account specific data to root of normal
// state screen. This way those will be cleared on logout and other
// state changes.

// TODO(prod): Admin moderate images does not make 1 pixel images
//             to fill the UI area.
// TODO(prod): The chat has some issue that latest message can be visible
//             multiple times.
// TODO(prod): Client does not detect when remote server websocket connection
//             breaks. Perhaps reset websocket connection if API returns
//             HTTP unauthorized error? The server side must send some message
//             to client reqularly, so that broken connections are detected.
// TODO(prod): When there are two conversation notifications, opening those
//             one by one, results in the second opened to below the first.

bool loggerInitDone = false;

void initLogging() {
  if (loggerInitDone) {
    return;
  }
  loggerInitDone = true;

  // TODO(prod): change log level before release?
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
      // TODO(prod): Remove print if logcat printing works somehow
      // without print.
      if (!kReleaseMode) {
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

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = DebugObserver();

  await GlobalInitManager.getInstance().init();

  runApp(
    MultiBlocProvider(
      providers: [
        // Navigation
        BlocProvider.value(value: NavigationStateBlocInstance.getInstance().bloc),
        BlocProvider.value(value: BottomNavigationStateBlocInstance.getInstance().bloc),

        // General
        BlocProvider(create: (_) => MainStateBloc()),
        BlocProvider(create: (_) => DemoAccountBloc()),
        BlocProvider(create: (_) => InitialSetupBloc()),
        BlocProvider(create: (_) => ServerAddressBloc()),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
        BlocProvider(create: (_) => NotificationPermissionBloc()),
        BlocProvider(create: (_) => NotificationPayloadHandlerBloc()),

        // Main UI
        BlocProvider(create: (_) => LikeGridInstanceManagerBloc()),

        // Account data
        BlocProvider(create: (_) => AccountBloc()),
        BlocProvider(create: (_) => ContentBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MyProfileBloc()),
        BlocProvider(create: (_) => AccountDetailsBloc()),
        BlocProvider(create: (_) => ProfileFilteringSettingsBloc()),

        // Settings
        BlocProvider(create: (_) => EditMyProfileBloc()),
        BlocProvider(create: (_) => EditProfileFilteringSettingsBloc()),
        BlocProvider(create: (_) => CurrentModerationRequestBloc()),
        BlocProvider(create: (_) => SelectContentBloc()),
        BlocProvider(create: (_) => NewModerationRequestBloc()),
        BlocProvider(create: (_) => ProfilePicturesBloc()),
        BlocProvider(create: (_) => PrivacySettingsBloc()),
        BlocProvider(create: (_) => BlockedProfilesBloc()),
        BlocProvider(create: (_) => SearchSettingsBloc()),
        BlocProvider(create: (_) => EditSearchSettingsBloc()),
        BlocProvider(create: (_) => NotificationSettingsBloc()),

        // Login
        BlocProvider(create: (_) => SignInWithBloc()),

        // Admin features related blocs
        // empty

        // Non-lazy
        // TOOD(prod): Change lazy to true as db is accessed to early?
        BlocProvider(create: (_) => ProfileAttributesBloc(), lazy: false),
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
      title: context.strings.app_name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light().copyWith(
        pageTransitionsTheme: createPageTransitionsTheme(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        pageTransitionsTheme: createPageTransitionsTheme(),
      ),
      themeMode: ThemeMode.system,
      home: GlobalLocalizationsInitializer(
        child: AppLifecycleHandler(
          child: AppNavigator(),
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
      TargetPlatform.android: ZoomPageTransitionsBuilder(allowSnapshotting: false),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}

class GlobalLocalizationsInitializer extends StatelessWidget {
  final Widget child;
  const GlobalLocalizationsInitializer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Init correct localizations to R class.
    final _ = context.strings.app_name;
    return child;
  }
}

class AppNavigator extends StatelessWidget {
  AppNavigator({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorStateBloc, NavigatorStateData>(
      builder: (context, state) {
        return NavigatorPopHandler(
          onPop: () {
            navigatorKey.currentState?.maybePop();
          },
          child: createNavigator(context, state),
        );
      }
    );
  }

  Widget createNavigator(BuildContext context, NavigatorStateData state) {
    return Navigator(
      key: navigatorKey,
      pages: state.getPages(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        context.read<NavigatorStateBloc>().add(PopPage(null));

        return true;
      }
    );
  }
}

// TODO(prod); Remove bloc state change printing
class DebugObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log.finest("${bloc.runtimeType} $change");
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

    await SecureStorageManager.getInstance().init();
    await DatabaseManager.getInstance().init();
    await ImageEncryptionManager.getInstance().init();

    await ErrorManager.getInstance().init();
    await ApiManager.getInstance().init();
    await ImageCacheData.getInstance().init();
    await ImageCacheSettings.getInstance().init();
    await CameraManager.getInstance().init();
    await NotificationManager.getInstance().init();
    await PushNotificationManager.getInstance().init();

    await CommonRepository.getInstance().init();
    await LoginRepository.getInstance().init();
    await AccountRepository.getInstance().init();
    await MediaRepository.getInstance().init();
    await ProfileRepository.getInstance().init();
    await ChatRepository.getInstance().init();

    // Initializes formatting for other locales as well
    await initializeDateFormatting("en_US", null);

    // Connect to server last to make sure that all events from
    // server are handled.
    await ApiManager.getInstance().restart();
  }

  /// Global init should be triggerred after when splash screen
  /// is visible.
  Future<void> triggerGlobalInit() async {
    _startInit.add(null);
  }
}
