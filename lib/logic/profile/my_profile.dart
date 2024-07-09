import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/profile/my_profile.dart";
import "package:pihka_frontend/ui_utils/common_update_logic.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";
import "package:pihka_frontend/utils/time.dart";


sealed class MyProfileEvent {}
class SetProfile extends MyProfileEvent {
  final ProfileUpdate profile;
  final SetProfileContent pictures;
  final bool unlimitedLikes;
  final bool initialModerationOngoing;
  SetProfile(
    this.profile,
    this.pictures,
    {
      required this.unlimitedLikes,
      required this.initialModerationOngoing,
    }
  );
}
class NewMyProfile extends MyProfileEvent {
  final ProfileEntry? profile;
  NewMyProfile(this.profile);
}
class ReloadMyProfile extends MyProfileEvent {}

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final db = DatabaseManager.getInstance();

  StreamSubscription<ProfileEntry?>? _profileSubscription;

  MyProfileBloc() : super(MyProfileData()) {
    on<SetProfile>((data, emit) async {
      await runOnce(() async {
        // TODO: check if the profile has actually changed
        // if (state.profile?.age == data.profile.age &&
        //   state.profile?.name == data.profile.name) {
        //   return;
        // }

        final current = state.profile;
        if (current == null) {
          return;
        }

        emit(state.copyWith(
          updateState: const UpdateStarted(),
        ));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(
          updateState: const UpdateInProgress(),
        ));

        // Do this first as updateProfile reloads the profile
        if (!await account.updateUnlimitedLikesWithoutReloadingProfile(data.unlimitedLikes)) {
          failureDetected = true;
        }

        if (!await profile.updateProfile(data.profile)) {
          failureDetected = true;
        }

        if (data.initialModerationOngoing) {
          if (await media.setPendingProfileContent(data.pictures).isErr()) {
            failureDetected = true;
          }
        } else {
          if (await media.setProfileContent(data.pictures).isErr()) {
            failureDetected = true;
          }
        }

        if (failureDetected) {
          showSnackBar(R.strings.view_profile_screen_profile_edit_failed);
        }

        await waitTime.waitIfNeeded();

        emit(state.copyWith(
          updateState: const UpdateIdle(),
        ));
      });
    });
    on<NewMyProfile>((data, emit) async {
      emit(state.copyWith(profile: data.profile));
    });
    on<ReloadMyProfile>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(loadingMyProfile: true));

        final waitTime = WantedWaitingTimeManager();

        bool failureDetected = false;
        if (await profile.reloadMyProfile().isErr()) {
          failureDetected = true;
        }

        if (await media.reloadMyProfileContent().isErr()) {
          failureDetected = true;
        }

        await waitTime.waitIfNeeded();

        if (failureDetected) {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(loadingMyProfile: false));
      });
    });

    _profileSubscription = db.accountStream((db) => db.getProfileEntryForMyProfile()).listen((event) {
      add(NewMyProfile(event));
    });
  }

  @override
  Future<void> close() async {
    await _profileSubscription?.cancel();
    await super.close();
  }
}
