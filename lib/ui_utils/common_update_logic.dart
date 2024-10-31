

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';

sealed class UpdateState {
  const UpdateState();
}
class UpdateIdle extends UpdateState {
  /// There is no update ongoing.
  ///
  /// Next event is [UpdateStarted].
  const UpdateIdle();
}
class UpdateStarted extends UpdateState {
  /// Update started.
  ///
  /// This event should open a dialog with loading indicator.
  ///
  /// Next event is [UpdateInProgress].
  const UpdateStarted();
}

class UpdateInProgress extends UpdateState {
  /// Update is in progress.
  ///
  /// Next event is [UpdateIdle].
  const UpdateInProgress();
}

abstract mixin class UpdateStateProvider {
  UpdateState get updateState;
}

Widget updateStateHandler<B extends StateStreamable<S>, S extends UpdateStateProvider>({
  required BuildContext context,
  required PageKey pageKey,
  required Widget child,
}) {
  return BlocListener<B, S>(
    listenWhen: (previous, current) => previous.updateState != current.updateState,
    listener: (context, state) async {
      final updateState = state.updateState;
      if (updateState is UpdateStarted) {
        await showLoadingDialogWithAutoDismiss<B, S>(
          context,
          dialogVisibilityGetter: (s) =>
            s.updateState is UpdateStarted ||
            s.updateState is UpdateInProgress,
          removeAlsoThisPage: pageKey,
        );
      }
    },
    child: child,
  );
}
