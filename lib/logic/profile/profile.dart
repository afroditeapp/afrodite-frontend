import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/profile_entry.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'profile.freezed.dart';

@freezed
class ProfileData with _$ProfileData {
  factory ProfileData({
    ProfileEntry? profile,
    ContentId? primaryImage,
  }) = _ProfileData;
}

sealed class ProfileEvent {}
class SetProfile extends ProfileEvent {
  final ProfileUpdate profile;
  SetProfile(this.profile);
}
class LoadProfile extends ProfileEvent {}

/// Do register/login operations
class ProfileBloc extends Bloc<ProfileEvent, ProfileData> with ActionRunner {
  final LoginRepository login = LoginRepository.getInstance();
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();

  ProfileBloc() : super(ProfileData()) {
    on<SetProfile>((data, emit) async {
      await runOnce(() async {
        final oldState = state;
        final oldProfile = state.profile;
        if (oldProfile != null) {
          // TODO: perhaps show a progress dialog?
          // emit(state.copyWith(profile: oldProfile.copyWith(profileText: data.profile.profileText)));
        }

        if (await profile.updateProfile(data.profile)) {
          final currentAccountId = await login.accountId.first;
          if (currentAccountId != null) {
            final currentProfile = await profile.getProfile(currentAccountId);
            if (currentProfile != null) {
              emit(state.copyWith(profile: currentProfile));
            }
          }
        } else {
          showSnackBar("Failed to update profile");
          emit(oldState);
        }
      });
    });
    on<LoadProfile>((data, emit) async {
      await runOnce(() async {
        final currentAccountId = await login.accountId.first;
        if (currentAccountId != null) {
          final currentProfile = await profile.getProfile(currentAccountId);
          final img = await media.getPrimaryImage(currentAccountId, false);
          if (currentProfile != null || img != null) {
            emit(state.copyWith(profile: currentProfile, primaryImage: img));
          }
        }
      });
    });
  }
}
