import "dart:async";
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

enum ProfileActionState {
  like,
  removeLike,
  makeMatch,
  chat,
}

@freezed
class ViewProfilesData with _$ViewProfilesData {
  factory ViewProfilesData({
    required AccountId accountId,
    required Profile profile,
    required File primaryProfileImage,
    required ProfileHeroTag imgTag,
    @Default(false) bool isFavorite,
    @Default(ProfileActionState.like) ProfileActionState profileActionState,
    @Default(false) bool isNotAvailable,
    @Default(false) bool loadingError,
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
class HandleProfileResult extends ViewProfileEvent {
  final GetProfileResult result;
  HandleProfileResult(this.result);
}
class ToggleFavoriteStatus extends ViewProfileEvent {
  final AccountId accountId;
  ToggleFavoriteStatus(this.accountId);
}
class DoProfileAction extends ViewProfileEvent {
  final AccountId accountId;
  final ProfileActionState action;
  DoProfileAction(this.accountId, this.action);
}
class BlockProfile extends ViewProfileEvent {
  final AccountId accountId;
  BlockProfile(this.accountId);
}
class ResetLoadingError extends ViewProfileEvent {}


class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfilesData?> with ActionRunner {
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;

  StreamSubscription<GetProfileResult>? _getProfileDataSubscription;

  ViewProfileBloc(this.account, this.profile, this.media) : super(null) {
    on<SetProfileView>((data, emit) async {
      await runOnce(() async {
        await _getProfileDataSubscription?.cancel();

        final newState = ViewProfilesData(
          accountId: data.accountId,
          profile: data.profile,
          primaryProfileImage:
          data.primaryProfileImage,
          imgTag: data.imgTag,
        );
        emit(newState);

        final isInFavorites = await profile.isInFavorites(newState.accountId);

        final ProfileActionState action;
        if (await profile.isInMatches(newState.accountId)) {
          action = ProfileActionState.chat;
        } else if (await profile.isInLikedProfiles(newState.accountId)) {
          action = ProfileActionState.removeLike;
        } else if (await profile.isInReceivedLikes(newState.accountId)) {
          action = ProfileActionState.makeMatch;
        } else {
          action = ProfileActionState.like;
        }

        emit(newState.copyWith(isFavorite: isInFavorites, profileActionState: action));

        _getProfileDataSubscription = ProfileRepository.getInstance()
          .getProfileStream(newState.accountId)
          .listen((event) {
            add(HandleProfileResult(event));
          });
      });
    });
    on<ToggleFavoriteStatus>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        if (currentState.isFavorite) {
          await for (final inFavorites in profile.removeFromFavorites(currentState.accountId)) {
            emit(currentState.copyWith(isFavorite: inFavorites));
          }
        } else {
          await for (final inFavorites in profile.addToFavorites(currentState.accountId)) {
            emit(currentState.copyWith(isFavorite: inFavorites));
          }
        }
      });
    });
    on<HandleProfileResult>((data, emit) async {
      final currentState = state;
      if (currentState == null) {
        return;
      }
      final result = data.result;
      switch (result) {
        case GetProfileSuccess():
          emit(currentState.copyWith(profile: result.profile));
        case GetProfileDoesNotExist():
          emit(currentState.copyWith(isNotAvailable: true));
        case GetProfileFailed():
          emit(currentState.copyWith(loadingError: true));
      }
    });
    on<ResetLoadingError>((data, emit) async {
      emit(state?.copyWith(loadingError: false));
    });
  }
}
