

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';

sealed class UpdateState {
  const UpdateState();
}
class UpdateIdle extends UpdateState {
  const UpdateIdle();
}
class UpdateStarted extends UpdateState {
  const UpdateStarted();
}
class UpdateInProgress extends UpdateState {
  const UpdateInProgress();
}

abstract mixin class UpdateStateProvider {
  UpdateState get updateState;
}

Widget updateStateHandler<B extends StateStreamable<S>, S extends UpdateStateProvider>({
  required Widget child,
}) {
  return BlocListener<B, S>(
    listenWhen: (previous, current) => previous.updateState != current.updateState,
    listener: (context, state) {
      final updateState = state.updateState;
      if (updateState is UpdateStarted) {
        showLoadingDialogWithAutoDismiss<B, S>(
          context,
          dialogVisibilityGetter: (s) =>
            s.updateState is UpdateStarted ||
            s.updateState is UpdateInProgress,
          dismissAction: () {
            Navigator.pop(context); // Dialog
            Navigator.pop(context); // Current screen
          }
        );
      }
    },
    child: child,
  );
}
