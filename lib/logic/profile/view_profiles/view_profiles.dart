import "dart:io";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/favorite_profiles_database.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/ui/normal/profiles/view_profile.dart";
import "package:pihka_frontend/ui/utils.dart";
import "package:pihka_frontend/utils.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'view_profiles.freezed.dart';

@freezed
class ViewProfilesData with _$ViewProfilesData {
  factory ViewProfilesData({
    required AccountId accountId,
    required Profile profile,
    required File primaryProfileImage,
    required ProfileHeroTag imgTag,
    @Default(false) bool isFavorite,
  }) = _ViewProfilesData;
}

sealed class ViewProfileEvent {}
class SetProfileView extends ViewProfileEvent {
  final AccountId accountId;
  final Profile profile;
  final File primaryProfileImage;
  final ProfileHeroTag imgTag;
  SetProfileView(this.accountId, this.profile, this.primaryProfileImage, this.imgTag);
}
// class LoadProfileView extends ViewProfileEvent {
//   LoadProfileView();
// }
class ToggleFavoriteStatus extends ViewProfileEvent {
  final AccountId accountId;
  ToggleFavoriteStatus(this.accountId);
}


class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfilesData?> with ActionRunner {
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;

  ViewProfileBloc(this.account, this.profile, this.media) : super(null) {
    on<SetProfileView>((data, emit) async {
      await runOnce(() async {
        final newState = ViewProfilesData(
          accountId: data.accountId,
          profile: data.profile,
          primaryProfileImage:
          data.primaryProfileImage,
          imgTag: data.imgTag,
        );
        emit(newState);

        final isInFavorites = await profile
          .isInFavorites(newState.accountId);

        emit(newState.copyWith(isFavorite: isInFavorites));
      });
    });
    on<ToggleFavoriteStatus>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        if (currentState.isFavorite) {
          await profile
            .removeFromFavorites(currentState.accountId);
        } else {
          await profile
            .addToFavorites(currentState.accountId);
        }
        emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
      });
    });
  }
}
