import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";

class InitialSetupPage extends RootPage {
  const InitialSetupPage({Key? key}) : super(MainState.initialSetup, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Initial setup"),
              ElevatedButton(
                child: const Text("Complete"),
                onPressed: () => context.read<MainStateBloc>().add(ToMainScreen()),
              )
            ],
          ),
        ),
      );
  }
}
