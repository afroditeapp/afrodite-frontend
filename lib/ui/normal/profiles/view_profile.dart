


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/view_profiles.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/view_profiles.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';

import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';

typedef ProfileHeroTagRaw = ({AccountId accountId, int uniqueCounterNumber});

extension type ProfileHeroTag(ProfileHeroTagRaw value) {
  AccountId get accountId => value.accountId;
  int get uniqueCounterNumber => value.uniqueCounterNumber;

  static ProfileHeroTag from(AccountId accountId, int uniqueCounterNumber) {
    return ProfileHeroTag((accountId: accountId, uniqueCounterNumber: uniqueCounterNumber));
  }
}

void openProfileView(
  BuildContext context,
  ProfileEntry profile,
  ProfileRefreshPriority priority,
  {
    ProfileHeroTag? heroTag,
    bool noAction = false,
  }
) {
  final pageKey = PageKey();
  MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(child:
      BlocProvider(
        create: (_) => ViewProfileBloc(profile, priority),
        lazy: false,
        child: ViewProfilePage(
          pageKey: pageKey,
          initialProfile: profile,
          noAction: noAction,
        ),
      ),
    ),
    pageKey,
  );
}

class ViewProfilePage extends StatelessWidget {
  final PageKey pageKey;
  final bool noAction;
  final ProfileEntry initialProfile;
  final ProfileHeroTag? heroTag;

  const ViewProfilePage({
    required this.pageKey,
    required this.initialProfile,
    this.heroTag,
    this.noAction = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        //backgroundColor: Colors.transparent,
        // iconTheme: const IconThemeData(
        //   color: Colors.black45,
        // ),
        actions: [
          BlocBuilder<ViewProfileBloc, ViewProfilesData>(builder: (context, state) {
            final Icon icon;
            final String tooltip;
            if (state.isFavorite.isFavorite) {
              icon = const Icon(Icons.star_rounded);
              tooltip = context.strings.view_profile_screen_remove_from_favorites_action;
            } else {
              icon = const Icon(Icons.star_outline_rounded);
              tooltip = context.strings.view_profile_screen_add_to_favorites_action;
            }
            return IconButton(
              onPressed: () {
                switch (state.isFavorite) {
                  case FavoriteStateIdle():
                    context.read<ViewProfileBloc>().add(ToggleFavoriteStatus(state.profile.uuid));
                  case FavoriteStateChangeInProgress():
                    showSnackBar(context.strings.generic_previous_action_in_progress);
                }
              },
              icon: icon,
              tooltip: tooltip,
            );
          }),
          menuActions([
            commonActionBlockProfile(context, () {
              context.read<ViewProfileBloc>().add(BlockProfile(initialProfile.uuid));
            })
          ]),
        ],
      ),
      body: myProfilePage(context),
      floatingActionButton: actionButton(context),
    );
  }

  Widget? actionButton(BuildContext context) {
    if (noAction) {
      return null;
    }

    return BlocBuilder<ViewProfileBloc, ViewProfilesData>(
      builder: (context, state) {
        return actionButtonFromAction(context, state);
      }
    );
  }

  Widget actionButtonFromAction(BuildContext context, ViewProfilesData s) {
    switch (s.profileActionState) {
      case ProfileActionState.like:
        return FloatingActionButton(
          onPressed: () => confirmProfileAction(
            context,
            s,
            context.strings.view_profile_screen_like_action_dialog_title
          ),
          tooltip: context.strings.view_profile_screen_like_action,
          child: const Icon(Icons.favorite),
        );
      case ProfileActionState.removeLike:
        return FloatingActionButton(
          onPressed: () => confirmProfileAction(
            context,
            s,
            context.strings.view_profile_screen_remove_like_action_dialog_title,
          ),
          tooltip: context.strings.view_profile_screen_remove_like_action,
          child: const Icon(Icons.undo),
        );
      case ProfileActionState.makeMatch:
        return FloatingActionButton(
          onPressed: () => openConversationScreen(context, s.profile),
          tooltip: context.strings.view_profile_screen_match_with_message_action,
          child: const Icon(Icons.waving_hand),
        );
      case ProfileActionState.chat:
        return FloatingActionButton(
          onPressed: () => openConversationScreen(context, s.profile),
          tooltip: context.strings.view_profile_screen_chat_action,
          child: const Icon(Icons.chat_rounded),
        );
    }
  }

  void confirmProfileAction(BuildContext context, ViewProfilesData s, String dialogTitle) async {
    final accepted = await showConfirmDialog(context, dialogTitle);
    if (context.mounted && accepted == true) {
      context.read<ViewProfileBloc>()
        .add(DoProfileAction(
          s.profile.uuid,
          s.profileActionState
        ));
    }
  }

  Widget myProfilePage(BuildContext context) {
    return BlocBuilder<ViewProfileBloc, ViewProfilesData>(
      builder: (context, state) {
        handleStateAction(context, state);

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: state.isNotAvailable ? 0.0 : 1.0,
          child: ViewProfileEntry(profile: state.profile, heroTag: heroTag),
        );
      }
    );
  }

  void handleStateAction(BuildContext context, ViewProfilesData state) {
    Future.delayed(Duration.zero, () async {
      if (!context.mounted) {
        return;
      }

      if (
        state.showAddToFavoritesCompleted ||
        state.showRemoveFromFavoritesCompleted ||
        state.showLikeCompleted ||
        state.showLikeFailedBecauseOfLimit ||
        state.showLikeFailedBecauseAlreadyLiked ||
        state.showLikeFailedBecauseAlreadyMatch ||
        state.showRemoveLikeCompleted ||
        state.showRemoveLikeFailedBecauseOfDoneBefore ||
        state.showRemoveLikeFailedBecauseOfAlreadyMatch ||
        state.showRemoveLikeFailedBecauseOfNotLiked ||
        state.showGenericError
      ) {
        if (state.showAddToFavoritesCompleted) {
          showSnackBar(context.strings.view_profile_screen_add_to_favorites_action_successful);
        }
        if (state.showRemoveFromFavoritesCompleted) {
          showSnackBar(context.strings.view_profile_screen_remove_from_favorites_action_successful);
        }
        if (state.showLikeCompleted) {
          showSnackBar(context.strings.view_profile_screen_like_action_successful);
        }
        if (state.showLikeFailedBecauseOfLimit) {
          showSnackBar(context.strings.view_profile_screen_like_action_try_again_tomorrow);
        }
        if (state.showLikeFailedBecauseAlreadyLiked) {
          showSnackBar(context.strings.view_profile_screen_like_action_like_already_sent);
        }
        if (state.showLikeFailedBecauseAlreadyMatch || state.showRemoveLikeFailedBecauseOfAlreadyMatch) {
          showSnackBar(context.strings.view_profile_screen_already_match);
        }
        if (state.showRemoveLikeCompleted) {
          showSnackBar(context.strings.view_profile_screen_remove_like_action_successful);
        }
        if (state.showRemoveLikeFailedBecauseOfDoneBefore) {
          showSnackBar(context.strings.view_profile_screen_remove_like_action_remove_done_previously);
        }
        if (state.showRemoveLikeFailedBecauseOfNotLiked) {
          showSnackBar(context.strings.view_profile_screen_remove_like_action_like_not_found);
        }
        if (state.showGenericError) {
          showSnackBar(context.strings.generic_error_occurred);
        }
        context.read<ViewProfileBloc>().add(ResetShowMessages());
      }

      if (state.isNotAvailable) {
        await showInfoDialog(
          context,
          context.strings.view_profile_screen_profile_not_available_dialog_description
        );
        if (context.mounted) {
          MyNavigator.removePage(context, pageKey);
        }
      } else if (state.isBlocked) {
        showSnackBar(context.strings.view_profile_screen_block_action_successful);
        if (context.mounted) {
          MyNavigator.removePage(context, pageKey);
        }
      }
    });
  }
}
