import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/matches_database.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/database/chat/received_blocks_database.dart';
import 'package:pihka_frontend/database/chat/received_likes_database.dart';
import 'package:pihka_frontend/database/chat/sent_blocks_database.dart';
import 'package:pihka_frontend/database/chat/sent_likes_database.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/account/demo_account.dart';
import 'package:pihka_frontend/logic/account/initial_setup.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/logic/media/image_processing.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/attributes/attributes.dart';
import 'package:pihka_frontend/logic/profile/location.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/logic/server/address.dart';
import 'package:pihka_frontend/logic/sign_in_with.dart';

import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/ui/splash_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:pihka_frontend/utils/camera.dart';

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

  // TODO: remove and get instances in Bloc
  var accountRepository = AccountRepository.getInstance();
  var mediaRepository = MediaRepository.getInstance();
  var profileRepository = ProfileRepository.getInstance();
  var chatRepository = ChatRepository.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainStateBloc()),
        BlocProvider(create: (_) => AccountBloc()),
        BlocProvider(create: (_) => DemoAccountBloc()),
        BlocProvider(create: (_) => InitialSetupBloc()),
        BlocProvider(create: (_) => ServerAddressBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => SecuritySelfieImageProcessingBloc()),
        BlocProvider(create: (_) => ProfilePicturesImageProcessingBloc()),
        BlocProvider(create: (_) => ProfilePicturesBloc()),
        BlocProvider(create: (_) => ViewProfileBloc(accountRepository, profileRepository, mediaRepository, chatRepository)),
        BlocProvider(create: (_) => ConversationBloc(accountRepository, profileRepository, mediaRepository, chatRepository)),
        BlocProvider(create: (_) => ProfileFilteringSettingsBloc(profileRepository)),
        BlocProvider(create: (_) => LocationBloc(profileRepository), lazy: false),
        BlocProvider(create: (_) => ProfileAttributesBloc(), lazy: false),

        // Login
        BlocProvider(create: (_) => SignInWithBloc()),

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
      title: context.strings.app_name,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
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

    await ErrorManager.getInstance().init();
    await ApiManager.getInstance().init();
    await ImageCacheData.getInstance().init();
    await CameraManager.getInstance().init();

    await ProfileListDatabase.getInstance().init();
    await FavoriteProfilesDatabase.getInstance().init();
    await ProfileDatabase.getInstance().init();
    await MatchesDatabase.getInstance().init();
    await ReceivedBlocksDatabase.getInstance().init();
    await ReceivedLikesDatabase.getInstance().init();
    await SentLikesDatabase.getInstance().init();
    await SentBlocksDatabase.getInstance().init();
    await MessageDatabase.getInstance().init();

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
