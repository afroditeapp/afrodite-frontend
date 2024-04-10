import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/profile_entry.dart";
import "package:pihka_frontend/model/freezed/logic/profile/view_profiles.dart";
import "package:pihka_frontend/utils.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';


final log = Logger("ViewProfilesBloc");

sealed class ViewProfileEvent {}
class SetProfileView extends ViewProfileEvent {
  final ProfileEntry profile;
  SetProfileView(this.profile);
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
class BlockProfile extends ViewProfileEvent {
  final AccountId accountId;
  BlockProfile(this.accountId);
}
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
      );
      emit(newState);

      final isInFavorites = await profile.isInFavorites(newState.profile.uuid);
      final isBlocked = await chat.isInSentBlocks(newState.profile.uuid) ||
        await chat.isInReceivedBlocks(newState.profile.uuid);
      final ProfileActionState action = await resolveProfileAction(newState.profile.uuid);

      emit(newState.copyWith(
        isFavorite: FavoriteStateIdle(isInFavorites),
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
        final currentIsFavorite = state?.isFavorite.isFavorite;
        final accountId = state?.profile.uuid;
        if (currentIsFavorite == null || accountId == null) {
          return;
        }

        emit(state?.copyWith(
          isFavorite: FavoriteStateChangeInProgress(!currentIsFavorite),
        ));

        final newValue = await profile.toggleFavoriteStatus(accountId);
        if (accountIdNotChanged(accountId)) {
          emit(state?.copyWith(
            isFavorite: FavoriteStateIdle(newValue),
          ));
        }
      });
    });
    on<HandleProfileResult>((data, emit) async {
      final currentState = state;
      if (currentState == null) {
        return;
      }
      switch (data.result) {
        case GetProfileSuccess(:final profile):
          emit(state?.copyWith(profile: profile));
        case GetProfileDoesNotExist(): {
          // TODO: Remove once backend supports getting private profiles
          //       of matches.
          emit(state?.copyWith(
            isNotAvailable: currentState.profileActionState != ProfileActionState.chat
          ));
        }
        case GetProfileFailed():
          // No extra logic needed for errors as global error messages are enough.
          log.warning("Received GetProfileFailed");
      }
    });
    on<HandleProfileChange>((data, emit) async {
      final accountId = state?.profile.uuid;
      if (accountId == null) {
        return;
      }
      final change = data.change;
      switch (change) {
        case ProfileBlocked(): {
          if (change.profile == accountId) {
            emit(state?.copyWith(isBlocked: true));
          }
        }
        case LikesChanged() || MatchesChanged(): {
          final ProfileActionState action = await resolveProfileAction(accountId);
          if (accountIdNotChanged(accountId)) {
            emit(state?.copyWith(
              profileActionState: action,
            ));
          }
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
    on<BlockProfile>((data, emit) async {
      await runOnce(() async {
        final currentAccountId = state?.profile.uuid;
        if (await chat.sendBlockTo(data.accountId) && accountIdNotChanged(currentAccountId)) {
          emit(state?.copyWith(
            isBlocked: true,
          ));
        }
      });
    });
    on<DoProfileAction>((data, emit) async {
      await runOnce(() async {
        final currentAccountId = state?.profile.uuid;
        switch (data.action) {
          case ProfileActionState.like: {
            if (await chat.sendLikeTo(data.accountId)) {
              final newAction = await resolveProfileAction(data.accountId);
              if (accountIdNotChanged(currentAccountId)) {
                emit(state?.copyWith(
                  profileActionState: newAction,
                  showLikeCompleted: true,
                ));
              }
            }
          }
          case ProfileActionState.removeLike: {
            if (await chat.removeLikeFrom(data.accountId)) {
              final newAction = await resolveProfileAction(data.accountId);
              if (accountIdNotChanged(currentAccountId)) {
                  emit(state?.copyWith(
                  profileActionState: newAction,
                  showRemoveLikeCompleted: true,
                ));
              }
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

  bool accountIdNotChanged(AccountId? accountId) {
    return accountId == state?.profile.uuid;
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
