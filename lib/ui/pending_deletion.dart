import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class PendingDeletionPage extends RootScreen {
  const PendingDeletionPage({Key? key}) : super(MainState.pendingRemoval, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Pending deletion"),
              ElevatedButton(
                child: const Text("Undo"),
                onPressed: () => context.read<MainStateBloc>().add(ToMainScreen()),
              )
            ],
          ),
        ),
      );
  }
}
