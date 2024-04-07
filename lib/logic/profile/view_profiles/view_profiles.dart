import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/profile_entry.dart";
import "package:pihka_frontend/ui/normal/profiles/view_profile.dart";
import "package:pihka_frontend/utils.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'view_profiles.freezed.dart';

final log = Logger("ViewProfilesBloc");

enum ProfileActionState {
  like,
  removeLike,
  makeMatch,
  chat,
}

@freezed
class ViewProfilesData with _$ViewProfilesData {
  factory ViewProfilesData({
    required ProfileEntry profile,
    required ProfileHeroTag? imgTag,
    @Default(false) bool isFavorite,
    @Default(ProfileActionState.like) ProfileActionState profileActionState,
    @Default(false) bool isNotAvailable,
    @Default(false) bool isBlocked,
    @Default(false) bool showLikeCompleted,
    @Default(false) bool showRemoveLikeCompleted,
  }) = _ViewProfilesData;
}

sealed class ViewProfileEvent {}
class SetProfileView extends ViewProfileEvent {
  final ProfileEntry profile;
  final ProfileHeroTag? imgTag;
  SetProfileView(this.profile, this.imgTag);
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
  final AccountRepository account = AccountRepository.getInstance();
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final ChatRepository chat = ChatRepository.getInstance();

  StreamSubscription<GetProfileResult>? _getProfileDataSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  ViewProfileBloc() : super(null) {
    on<SetProfileView>((data, emit) async {
      await _getProfileDataSubscription?.cancel();

      final newState = ViewProfilesData(
        profile: data.profile,
        imgTag: data.imgTag,
      );
      emit(newState);

      final isInFavorites = await profile.isInFavorites(newState.profile.uuid);
      final isBlocked = await chat.isInSentBlocks(newState.profile.uuid) ||
        await chat.isInReceivedBlocks(newState.profile.uuid);
      final ProfileActionState action = await resolveProfileAction(newState.profile.uuid);

      emit(newState.copyWith(
        isFavorite: isInFavorites,
        isBlocked: isBlocked,
        profileActionState: action
      ));

      _getProfileDataSubscription = ProfileRepository.getInstance()
        .getProfileStream(newState.profile.uuid)
        .listen((event) {
          add(HandleProfileResult(event));
        });
    });
    on<ToggleFavoriteStatus>((data, emit) async {
      await runOnce(() async {
        final currentState = state;
        if (currentState == null) {
          return;
        }
        if (currentState.isFavorite) {
          await for (final inFavorites in profile.removeFromFavorites(currentState.profile.uuid)) {
            emit(currentState.copyWith(isFavorite: inFavorites));
          }
        } else {
          await for (final inFavorites in profile.addToFavorites(currentState.profile.uuid)) {
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
        case GetProfileDoesNotExist(): {
          // TODO: Remove once backend supports getting private profiles
          //       of matches.
          emit(currentState.copyWith(
            isNotAvailable: currentState.profileActionState != ProfileActionState.chat
          ));
        }
        case GetProfileFailed():
          // No extra logic needed for errors as global error messages are enough.
          log.warning("Received GetProfileFailed");
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
          if (change.profile == currentState.profile.uuid) {
            emit(currentState.copyWith(isBlocked: true));
          }
        }
        case LikesChanged() || MatchesChanged(): {
          final ProfileActionState action = await resolveProfileAction(currentState.profile.uuid);
          emit(currentState.copyWith(
            profileActionState: action,
          ));
        }
        case ProfileNowPrivate() ||
          ProfileUnblocked() ||
          ConversationChanged() ||
          ProfileFavoriteStatusChange(): {}
      }
    });
    on<ResetShowMessages>((data, emit) async {
      emit(state?.copyWith(
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
        if (await chat.sendBlockTo(currentState.profile.uuid)) {
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
