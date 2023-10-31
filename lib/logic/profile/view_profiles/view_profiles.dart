import "dart:async";
import "dart:io";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
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
    @Default(false) bool isBlocked,
    @Default(false) bool showLoadingError,
    @Default(false) bool showLikeCompleted,
    @Default(false) bool showRemoveLikeCompleted,
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
class HandleProfileChange extends ViewProfileEvent {
  final ProfileChange change;
  HandleProfileChange(this.change);
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
class BlockCurrentProfile extends ViewProfileEvent {}
class ResetShowMessages extends ViewProfileEvent {}


class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfilesData?> with ActionRunner {
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;
  final ChatRepository chat;

  StreamSubscription<GetProfileResult>? _getProfileDataSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  ViewProfileBloc(this.account, this.profile, this.media, this.chat) : super(null) {
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
        final isBlocked = await chat.isInSentBlocks(newState.accountId) ||
          await chat.isInReceivedBlocks(newState.accountId);
        final ProfileActionState action = await resolveProfileAction(newState.accountId);

        emit(newState.copyWith(
          isFavorite: isInFavorites,
          isBlocked: isBlocked,
          profileActionState: action
        ));

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
          emit(currentState.copyWith(showLoadingError: true));
      }
    });
    on<HandleProfileChange>((data, emit) async {
      final currentState = state;
      if (currentState == null) {
        return;
      }
      final change = data.change;
      switch (change) {
        case ProfileBlocked(): {
          if (change.profile == currentState.accountId) {
            emit(currentState.copyWith(isBlocked: true));
          }
        }
        case LikesChanged(): {
          final ProfileActionState action = await resolveProfileAction(currentState.accountId);
          emit(currentState.copyWith(
            profileActionState: action,
          ));
        }
        case ProfileNowPrivate() ||
          ProfileUnblocked() ||
          ProfileFavoriteStatusChange(): {}
      }
    });
    on<ResetShowMessages>((data, emit) async {
      emit(state?.copyWith(
        showLoadingError: false,
        showLikeCompleted: false,
        showRemoveLikeCompleted: false,
      ));
    });
    on<BlockCurrentProfile>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        if (await chat.sendBlockTo(currentState.accountId)) {
          emit(currentState.copyWith(
            isBlocked: true,
          ));
        }
      });
    });
    on<DoProfileAction>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        switch (data.action) {
          case ProfileActionState.like: {
            if (await chat.sendLikeTo(data.accountId)) {
              emit(currentState.copyWith(
                profileActionState: await resolveProfileAction(data.accountId),
                showLikeCompleted: true,
              ));
            }
          }
          case ProfileActionState.removeLike: {
            if (await chat.removeLikeFrom(data.accountId)) {
              emit(currentState.copyWith(
                profileActionState: await resolveProfileAction(data.accountId),
                showRemoveLikeCompleted: true,
              ));
            }
          }
          case ProfileActionState.makeMatch: {}
          case ProfileActionState.chat: {}
        }
      });
    });

    _profileChangeSubscription = ProfileRepository.getInstance()
      .profileChanges
      .listen((event) {
        add(HandleProfileChange(event));
      });
  }

  Future<ProfileActionState> resolveProfileAction(AccountId accountId) async {
    if (await chat.isInMatches(accountId)) {
      return ProfileActionState.chat;
    } else if (await chat.isInLikedProfiles(accountId)) {
      return ProfileActionState.removeLike;
    } else if (await chat.isInReceivedLikes(accountId)) {
      return ProfileActionState.makeMatch;
    } else {
      return ProfileActionState.like;
    }
  }

  @override
  Future<void> close() async {
    await _getProfileDataSubscription?.cancel();
    await _profileChangeSubscription?.cancel();
    return super.close();
  }
}
