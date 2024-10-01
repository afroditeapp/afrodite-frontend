import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:database/database.dart';
import "package:pihka_frontend/model/freezed/logic/profile/view_profiles.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";

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
  final AccountRepository account = LoginRepository.getInstance().repositories.account;
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;

  StreamSubscription<GetProfileResultClient>? _getProfileDataSubscription;
  StreamSubscription<ProfileChange>? _profileChangeSubscription;

  final ProfileRefreshPriority priority;

  ViewProfileBloc(ProfileEntry currentProfile, this.priority) : super(ViewProfilesData(profile: currentProfile)) {
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
        if (newValue != currentIsFavorite) {
          // Successful favorite status change
          if (newValue) {
            emit(state.copyWith(
              isFavorite: FavoriteStateIdle(newValue),
              showAddToFavoritesCompleted: true,
            ));
          } else {
            emit(state.copyWith(
              isFavorite: FavoriteStateIdle(newValue),
              showRemoveFromFavoritesCompleted: true,
            ));
          }
        } else {
          emit(state.copyWith(
            isFavorite: FavoriteStateIdle(newValue),
          ));
        }
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
        showAddToFavoritesCompleted: false,
        showRemoveFromFavoritesCompleted: false,
        showLikeCompleted: false,
        showLikeFailedBecauseOfLimit: false,
        showLikeFailedBecauseAlreadyLiked: false,
        showRemoveLikeCompleted: false,
        showRemoveLikeFailedBecauseOfDoneBefore: false,
        showGenericError: false
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
            switch (await chat.sendLikeTo(data.accountId)) {
              case Ok(:final v):
                if (v == LimitedActionStatus.failureLimitAlreadyReached) {
                  emit(state.copyWith(
                    showLikeFailedBecauseOfLimit: true,
                  ));
                } else if (v == LimitedActionStatus.success || v == LimitedActionStatus.successAndLimitReached) {
                  final newAction = await resolveProfileAction(data.accountId);
                  emit(state.copyWith(
                    profileActionState: newAction,
                    showLikeCompleted: true,
                  ));
                }
              case Err(e: SendLikeError.alreadyLiked):
                final newAction = await resolveProfileAction(data.accountId);
                emit(state.copyWith(
                  profileActionState: newAction,
                  showLikeFailedBecauseAlreadyLiked: true,
                ));
              case Err(e: SendLikeError.unspecifiedError):
                emit(state.copyWith(
                  showGenericError: true,
                ));
            }
          }
          case ProfileActionState.removeLike: {
            switch (await chat.removeLikeFrom(data.accountId)) {
              case Ok():
                final newAction = await resolveProfileAction(data.accountId);
                emit(state.copyWith(
                  profileActionState: newAction,
                  showRemoveLikeCompleted: true,
                ));
              case Err(e: RemoveLikeError.actionDoneBefore):
                emit(state.copyWith(
                  showRemoveLikeFailedBecauseOfDoneBefore: true,
                ));
              case Err(e: RemoveLikeError.unspecifiedError):
                emit(state.copyWith(
                  showGenericError: true,
                ));
            }
          }
          case ProfileActionState.makeMatch: {}
          case ProfileActionState.chat: {}
        }
      });
    });

    _profileChangeSubscription = profile
      .profileChanges
      .listen((event) {
        add(HandleProfileChange(event));
      });

    _getProfileDataSubscription = profile
      .getProfileStream(state.profile.uuid, priority)
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
