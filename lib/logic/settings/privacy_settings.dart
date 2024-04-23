import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/settings/privacy_settings.dart";
import "package:pihka_frontend/ui_utils/common_update_logic.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/api.dart";
import "package:pihka_frontend/utils/time.dart";

sealed class PrivacySettingsEvent {}
class ResetEditablePrivacySettings extends PrivacySettingsEvent {
  final ProfileVisibility initialVisibility;
  ResetEditablePrivacySettings(this.initialVisibility);
}
class ToggleVisibility extends PrivacySettingsEvent {}
class SaveSettings extends PrivacySettingsEvent {
  final ProfileVisibility profileVisiblity;
  SaveSettings(this.profileVisiblity);
}

class PrivacySettingsBloc extends Bloc<PrivacySettingsEvent, PrivacySettingsData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();

  PrivacySettingsBloc() : super(PrivacySettingsData()) {
    on<ResetEditablePrivacySettings>((data, emit) async {
      emit(state.copyWith(
        updateState: const UpdateIdle(),
        initialVisibility: data.initialVisibility,
        currentVisibility: data.initialVisibility,
      ));
    });
    on<ToggleVisibility>((data, emit) async {
      emit(state.copyWith(
        currentVisibility: _toggleVisibility(state.currentVisibility),
      ));
    });
    on<SaveSettings>((data, emit) async {
      await runOnce(() async {

        emit(state.copyWith(
          updateState: const UpdateStarted(),
        ));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(
          updateState: const UpdateInProgress(),
        ));

        if (!await account.doProfileVisibilityChange(data.profileVisiblity.isPublic())) {
          failureDetected = true;
        }

        await waitTime.waitIfNeeded();

        if (failureDetected) {
          showSnackBar(R.strings.privacy_settings_screen_settings_updating_failed);
        }

        emit(state.copyWith(
          updateState: const UpdateIdle(),
        ));
      });
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
}
