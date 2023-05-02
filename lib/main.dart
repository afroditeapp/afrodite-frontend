import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/account/account.dart';

import 'package:pihka_frontend/ui/main/home.dart';
import 'package:pihka_frontend/ui/login.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/ui/splash_screen.dart';


void main() {
  Bloc.observer = DebugObserver();

  var api = ApiProvider();
  var accountRepository = AccountRepository(api);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainStateBloc(accountRepository)),
        BlocProvider(create: (_) => AccountBloc(accountRepository)),
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
