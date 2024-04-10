import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/profile/my_profile.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

sealed class MyProfileEvent {}
class SetProfile extends MyProfileEvent {
  final ProfileUpdate profile;
  SetProfile(this.profile);
}
class NewMyProfile extends MyProfileEvent {
  final ProfileEntry? profile;
  NewMyProfile(this.profile);
}

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final db = DatabaseManager.getInstance();

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
          profileUpdateState: const ProfileUpdateStarted(),
        ));

        final startTime = DateTime.now();

        var failureDetected = false;

        emit(state.copyWith(
          profileUpdateState: const ProfileUpdateInProgress(),
        ));


        if (!await profile.updateProfile(data.profile)) {
          failureDetected = true;
        }

        if (failureDetected) {
          showSnackBar(R.strings.view_profile_screen_profile_edit_failed);
        }

        const wantedDurationMillis = 500;
        final remainingTime = wantedDurationMillis - DateTime.now().difference(startTime).inMilliseconds;
        if (remainingTime > 0) {
          await Future.delayed(Duration(milliseconds: remainingTime), () => null);
        }

        emit(state.copyWith(
          profileUpdateState: const ProfileUpdateIdle(),
        ));
      });
    });
    on<NewMyProfile>((data, emit) async {
      emit(state.copyWith(profile: data.profile));
    });

    db.accountStream((db) => db.getProfileEntryForMyProfile()).listen((event) {
      add(NewMyProfile(event));
    });
  }
}
