import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/database_manager.dart";
import "package:pihka_frontend/database/profile_entry.dart";
import "package:pihka_frontend/utils.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'profile.freezed.dart';

@freezed
class MyProfileData with _$MyProfileData {
  factory MyProfileData({
    ProfileEntry? profile,
  }) = _ProfileData;
}

sealed class MyProfileEvent {}
class SetProfile extends MyProfileEvent {
  final ProfileUpdate profile;
  SetProfile(this.profile);
}
class NewMyProfile extends MyProfileEvent {
  final ProfileEntry? profile;
  NewMyProfile(this.profile);
}

/// Do register/login operations
class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final db = DatabaseManager.getInstance();

  MyProfileBloc() : super(MyProfileData()) {
    on<SetProfile>((data, emit) async {
      // TODO

      // await runOnce(() async {
      //   final oldState = state;
      //   final oldProfile = state.profile;
      //   if (oldProfile != null) {
      //     // TODO: perhaps show a progress dialog?
      //     // emit(state.copyWith(profile: oldProfile.copyWith(profileText: data.profile.profileText)));
      //   }

      //   if (await profile.updateProfile(data.profile)) {
      //     final currentAccountId = await login.accountId.first;
      //     if (currentAccountId != null) {
      //       final currentProfile = await profile.getProfile(currentAccountId);
      //       if (currentProfile != null) {
      //         emit(state.copyWith(profile: currentProfile));
      //       }
      //     }
      //   } else {
      //     showSnackBar("Failed to update profile");
      //     emit(oldState);
      //   }
      // });
    });
    on<NewMyProfile>((data, emit) async {
      emit(state.copyWith(profile: data.profile));
    });

    db.accountStream((db) => db.getProfileEntryForMyProfile()).listen((event) {
      add(NewMyProfile(event));
    });
  }
}
