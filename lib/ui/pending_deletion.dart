import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/logic/app/main_state.dart";

// TODO(prod): Translate text

class PendingDeletionPage extends StatelessWidget {
  const PendingDeletionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
