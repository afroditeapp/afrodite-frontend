import "dart:async";

import "package:app/utils/api.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/data/profile_repository.dart";
import 'package:database/database.dart';
import "package:app/database/account_database_manager.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/my_profile.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";
import "package:app/utils/time.dart";


sealed class MyProfileEvent {}
class SetProfile extends MyProfileEvent {
  final ProfileUpdate profile;
  final SetProfileContent pictures;
  final bool unlimitedLikes;

  SetProfile(
    this.profile,
    this.pictures,
    {
      required this.unlimitedLikes,
    }
  );
}
class NewMyProfile extends MyProfileEvent {
  final MyProfileEntry? profile;
  NewMyProfile(this.profile);
}
class NewInitialAgeInfo extends MyProfileEvent {
  final InitialAgeInfo? value;
  NewInitialAgeInfo(this.value);
}
class ReloadMyProfile extends MyProfileEvent {}

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileData> with ActionRunner {
  final AccountRepository account = LoginRepository.getInstance().repositories.account;
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<ProfileEntry?>? _profileSubscription;
  StreamSubscription<InitialAgeInfo?>? _initialAgeInfoSubscription;

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

        // When unlimited likes is disabled, the unlimited likes
        // filter must be also disabled.
        final filters = await db.accountStreamSingle((db) => db.daoProfileSettings.watchProfileFilteringSettings()).ok();
        if (filters != null) {
          if (
            state.profile?.unlimitedLikes == true &&
            data.unlimitedLikes == false &&
            filters.unlimitedLikesFilter != null
          ) {
            if (
              await profile.updateProfileFilteringSettings(
                filters.currentFiltersCopy(),
                filters.lastSeenTimeFilter,
                null,
                filters.maxDistanceKmFilter,
                filters.profileCreatedFilter,
                filters.profileEditedFilter,
                filters.profileTextMinCharactersFilter,
                filters.profileTextMaxCharactersFilter,
                filters.randomProfileOrder,
              ).isErr()
            ) {
              failureDetected = true;
            }
            await profile.resetMainProfileIterator();
          }
        } else {
          failureDetected = true;
        }

        // Do this first as updateProfile reloads the profile
        if (!await account.updateUnlimitedLikesWithoutReloadingProfile(data.unlimitedLikes)) {
          failureDetected = true;
        }

        if (!await profile.updateProfile(data.profile)) {
          failureDetected = true;
        }

        if (await media.setProfileContent(data.pictures).isErr()) {
          failureDetected = true;
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
    on<NewInitialAgeInfo>((data, emit) async {
      emit(state.copyWith(initialAgeInfo: data.value));
    });
    on<ReloadMyProfile>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(loadingMyProfile: true));

        final waitTime = WantedWaitingTimeManager();

        bool failureDetected = false;
        if (await profile.reloadMyProfile().isErr()) {
          failureDetected = true;
        }

        if (await media.reloadMyMediaContent().isErr()) {
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
    _initialAgeInfoSubscription = db.accountStream((db) => db.daoProfileInitialAgeInfo.watchInitialAgeInfo()).listen((event) {
      add(NewInitialAgeInfo(event));
    });
  }

  @override
  Future<void> close() async {
    await _profileSubscription?.cancel();
    await _initialAgeInfoSubscription?.cancel();
    await super.close();
  }
}
