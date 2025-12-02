import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/utils/api.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/account_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/settings/profile_visibility.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";

sealed class ProfileVisibilityEvent {}

class NewVisibility extends ProfileVisibilityEvent {
  final ProfileVisibility value;
  NewVisibility(this.value);
}

class ResetEdited extends ProfileVisibilityEvent {}

class ToggleVisibilityAndSaveSettings extends ProfileVisibilityEvent {}

class ProfileVisibilityBloc extends Bloc<ProfileVisibilityEvent, ProfileVisibilityData>
    with ActionRunner {
  final AccountRepository account;

  StreamSubscription<ProfileVisibility>? _visibilitySubscription;

  ProfileVisibilityBloc(RepositoryInstances r)
    : account = r.account,
      super(ProfileVisibilityData()) {
    on<NewVisibility>((data, emit) {
      emit(state.copyWith(visiblity: data.value, editedVisibility: null));
    });
    on<ResetEdited>((data, emit) {
      emit(state.copyWith(editedVisibility: null));
    });
    on<ToggleVisibilityAndSaveSettings>((data, emit) async {
      final newValue = _toggleVisibility(state.valueVisibility());

      emit(
        state.copyWith(
          updateState: const UpdateStarted(),
          editedVisibility: state.visiblity == newValue ? null : newValue,
        ),
      );

      var failureDetected = false;

      emit(state.copyWith(updateState: const UpdateInProgress()));

      if (!await account.doProfileVisibilityChange(newValue.isPublic())) {
        failureDetected = true;
      }

      if (failureDetected) {
        showSnackBar(R.strings.generic_error_occurred);
      }

      emit(state.copyWith(updateState: const UpdateIdle()));
    });

    _visibilitySubscription = account.profileVisibility.listen((event) {
      add(NewVisibility(event));
    });
  }

  ProfileVisibility _toggleVisibility(ProfileVisibility currentProfileVisibility) {
    if (currentProfileVisibility == ProfileVisibility.pendingPrivate) {
      return ProfileVisibility.pendingPublic;
    } else if (currentProfileVisibility == ProfileVisibility.private) {
      return ProfileVisibility.public;
    } else if (currentProfileVisibility == ProfileVisibility.pendingPublic) {
      return ProfileVisibility.pendingPrivate;
    } else if (currentProfileVisibility == ProfileVisibility.public) {
      return ProfileVisibility.private;
    } else {
      // Should never happen
      return ProfileVisibility.pendingPrivate;
    }
  }

  @override
  Future<void> close() async {
    await _visibilitySubscription?.cancel();
    await super.close();
  }
}
