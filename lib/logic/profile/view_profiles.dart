import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:database/database.dart';
import "package:pihka_frontend/model/freezed/logic/profile/view_profiles.dart";
import "package:pihka_frontend/utils.dart";



final log = Logger("ViewProfilesBloc");

sealed class ViewProfileEvent {}
class InitEvent extends ViewProfileEvent {}
class HandleProfileResult extends ViewProfileEvent {
  final GetProfileResultClient result;
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


class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfilesData> with ActionRunner {
  final AccountRepository account = AccountRepository.getInstance();
  final ProfileRepository profile = ProfileRepository.getInstance();
  final MediaRepository media = MediaRepository.getInstance();
  final ChatRepository chat = ChatRepository.getInstance();

  StreamSubscription<GetProfileResultClient>? _getProfileDataSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  ViewProfileBloc(ProfileEntry currentProfile) : super(ViewProfilesData(profile: currentProfile)) {
    on<InitEvent>((data, emit) async {
      final isInFavorites = await profile.isInFavorites(state.profile.uuid);
      final isBlocked = await chat.isInSentBlocks(state.profile.uuid) ||
        await chat.isInReceivedBlocks(state.profile.uuid);
      final ProfileActionState action = await resolveProfileAction(state.profile.uuid);

      emit(state.copyWith(
        isFavorite: FavoriteStateIdle(isInFavorites),
        isBlocked: isBlocked,
        profileActionState: action
      ));
    });
    on<ToggleFavoriteStatus>((data, emit) async {
      await runOnce(() async {
        final currentIsFavorite = state.isFavorite.isFavorite;
        final accountId = state.profile.uuid;

        emit(state.copyWith(
          isFavorite: FavoriteStateChangeInProgress(!currentIsFavorite),
        ));

        final newValue = await profile.toggleFavoriteStatus(accountId);
        emit(state.copyWith(
          isFavorite: FavoriteStateIdle(newValue),
        ));
      });
    });
    on<HandleProfileResult>((data, emit) async {
      switch (data.result) {
        case GetProfileSuccess(:final profile):
          emit(state.copyWith(profile: profile));
        case GetProfileDoesNotExist(): {
          // TODO: Remove once backend supports getting private profiles
          //       of matches.
          emit(state.copyWith(
            isNotAvailable: state.profileActionState != ProfileActionState.chat
          ));
        }
        case GetProfileFailed():
          // No extra logic needed for errors as global error messages are enough.
          log.warning("Received GetProfileFailed");
      }
    });
    on<HandleProfileChange>((data, emit) async {
      final change = data.change;
      switch (change) {
        case ProfileBlocked(): {
          if (change.profile == state.profile.uuid) {
            emit(state.copyWith(isBlocked: true));
          }
        }
        case LikesChanged() || MatchesChanged(): {
          final ProfileActionState action = await resolveProfileAction(state.profile.uuid);
          emit(state.copyWith(
            profileActionState: action,
          ));
        }
        case ProfileNowPrivate() ||
          ProfileUnblocked() ||
          ConversationChanged() ||
          ReloadMainProfileView() ||
          ProfileFavoriteStatusChange(): {}
      }
    });
    on<ResetShowMessages>((data, emit) async {
      emit(state.copyWith(
        showLikeCompleted: false,
        showRemoveLikeCompleted: false,
      ));
    });
    on<BlockProfile>((data, emit) async {
      await runOnce(() async {
        if (await chat.sendBlockTo(data.accountId)) {
          emit(state.copyWith(
            isBlocked: true,
          ));
        }
      });
    });
    on<DoProfileAction>((data, emit) async {
      await runOnce(() async {
        switch (data.action) {
          case ProfileActionState.like: {
            if (await chat.sendLikeTo(data.accountId)) {
              final newAction = await resolveProfileAction(data.accountId);
              emit(state.copyWith(
                profileActionState: newAction,
                showLikeCompleted: true,
              ));
            }
          }
          case ProfileActionState.removeLike: {
            if (await chat.removeLikeFrom(data.accountId)) {
              final newAction = await resolveProfileAction(data.accountId);
              emit(state.copyWith(
                profileActionState: newAction,
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

    _getProfileDataSubscription = ProfileRepository.getInstance()
      .getProfileStream(state.profile.uuid)
      .listen((event) {
        add(HandleProfileResult(event));
      });

    add(InitEvent());
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
