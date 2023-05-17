import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/api_provider.dart';
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


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = DebugObserver();

  var api = ApiProvider();
  var accountRepository = AccountRepository(api);
  var mediaRepository = MediaRepository(api);
  var profileRepository = ProfileRepository(api);


  await initAvailableCameras();

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pihka frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // routes: <String, WidgetBuilder> {
      //   "/login": (context) => const LoginPage(title: "Test")
      // },
      debugShowCheckedModeBanner: false,
    );
  }
}


class DebugObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} $change");
  }
}
