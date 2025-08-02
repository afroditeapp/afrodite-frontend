import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/data/profile_repository.dart";
import 'package:database/database.dart';
import "package:app/model/freezed/logic/profile/view_profiles.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

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

  ViewProfileBloc(
    ProfileEntry currentProfile,
    ProfileActionState? initialProfileAction,
    this.priority
  ) : super(ViewProfilesData(profile: currentProfile, profileActionState: initialProfileAction)) {
    on<InitEvent>((data, emit) async {
      final isInFavorites = await profile.isInFavorites(state.profile.accountId);
      final isBlocked = await chat.isInSentBlocks(state.profile.accountId);
      final action = await resolveProfileAction(chat, state.profile.accountId);

      emit(state.copyWith(
        isFavorite: FavoriteStateIdle(isInFavorites),
        isBlocked: isBlocked,
        profileActionState: action
      ));
    });
    on<ToggleFavoriteStatus>((data, emit) async {
      await runOnce(() async {
        final currentIsFavorite = state.isFavorite.isFavorite;
        final accountId = state.profile.accountId;

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
        case GetProfileDoesNotExist():
          // Profile viewing is allowed using existing data
          ();
        case GetProfileFailed():
          // No extra logic needed for errors as global error messages are enough.
          log.warning("Received GetProfileFailed");
      }
    });
    on<HandleProfileChange>((data, emit) async {
      final change = data.change;
      switch (change) {
        case ProfileBlocked(): {
          if (change.profile == state.profile.accountId) {
            emit(state.copyWith(isBlocked: true));
          }
        }
        case ConversationChanged(): {
          // Show the chat action when the first message is received
          final action = await resolveProfileAction(chat, state.profile.accountId);
          emit(state.copyWith(
            profileActionState: action,
          ));
        }
        case ProfileNowPrivate() ||
          ProfileUnblocked() ||
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
        showLikeFailedBecauseAlreadyMatch: false,
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
            final r = await chat.sendLikeTo(data.accountId);
            final newAction = await resolveProfileAction(chat, data.accountId);
            switch (r) {
              case Ok(:final v):
                if (v == LimitedActionStatus.failureLimitAlreadyReached) {
                  emit(state.copyWith(
                    profileActionState: newAction,
                    showLikeFailedBecauseOfLimit: true,
                  ));
                } else if (v == LimitedActionStatus.success || v == LimitedActionStatus.successAndLimitReached) {
                  emit(state.copyWith(
                    profileActionState: newAction,
                    showLikeCompleted: true,
                  ));
                }
              case Err(e: SendLikeError.alreadyLiked):
                emit(state.copyWith(
                  profileActionState: newAction,
                  showLikeFailedBecauseAlreadyLiked: true,
                ));
              case Err(e: SendLikeError.alreadyMatch):
                emit(state.copyWith(
                  profileActionState: newAction,
                  showLikeFailedBecauseAlreadyMatch: true,
                ));
              case Err(e: SendLikeError.unspecifiedError):
                emit(state.copyWith(
                  profileActionState: newAction,
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
      .getProfileStream(chat, state.profile.accountId, priority)
      .listen((event) {
        add(HandleProfileResult(event));
      });

    add(InitEvent());
  }

  @override
  Future<void> close() async {
    await _getProfileDataSubscription?.cancel();
    await _profileChangeSubscription?.cancel();
    return super.close();
  }
}

Future<ProfileActionState?> resolveProfileAction(ChatRepository chat, AccountId accountId) async {
  if (await chat.isInMatches(accountId)) {
    return ProfileActionState.chat;
  } else if (await chat.isInLikedProfiles(accountId)) {
    return null;
  } else if (await chat.isInReceivedLikes(accountId)) {
    return ProfileActionState.makeMatch;
  } else {
    return ProfileActionState.like;
  }
}
