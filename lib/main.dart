import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/common_repository.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/account_details.dart';
import 'package:pihka_frontend/logic/account/demo_account.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_permission.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
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
import 'package:pihka_frontend/logic/profile/view_profiles.dart';
import 'package:pihka_frontend/logic/server/address.dart';
import 'package:pihka_frontend/logic/settings/blocked_profiles.dart';
import 'package:pihka_frontend/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/logic/sign_in_with.dart';

import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/storage/encryption.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:pihka_frontend/utils/camera.dart';

import 'package:rxdart/rxdart.dart';

final log = Logger("main");

// TODO: what blocs store state that needs to be cleared on logout?
// Initial setup?

Future<void> main() async {
  // TODO(prod): change log level before release?
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

  runApp(
    MultiBlocProvider(
      providers: [
        // General
        BlocProvider(create: (_) => MainStateBloc()),
        BlocProvider(create: (_) => DemoAccountBloc()),
        BlocProvider(create: (_) => InitialSetupBloc()),
        BlocProvider(create: (_) => ServerAddressBloc()),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
        BlocProvider(create: (_) => NotificationPermissionBloc()),
        BlocProvider(create: (_) => NavigatorStateBloc()),

        // Main UI
        BlocProvider(create: (_) => ViewProfileBloc()),
        BlocProvider(create: (_) => ConversationBloc()),

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(allowSnapshotting: false),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const AppNavigator(),
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigatorStateBloc, NavigatorStateData>(
        builder: (context, state) {
          return PopScope(
            canPop: state.pages.length <= 1,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
              context.read<NavigatorStateBloc>().add(PopPage(null));
            },
            child: createNavigator(context, state),
          );
        }
      );
  }

  Widget createNavigator(BuildContext context, NavigatorStateData state) {
    return Navigator(
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
    await CameraManager.getInstance().init();
    await NotificationManager.getInstance().init();

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
