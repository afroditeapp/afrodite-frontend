


import 'package:app/logic/account/account.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/ui/normal/settings/admin/account_admin_settings.dart';
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
  ProfileActionState? initialProfileAction,
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
        create: (_) => ViewProfileBloc(profile, initialProfileAction, priority),
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
    return BlocBuilder<ViewProfileBloc, ViewProfilesData>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              favoriteButton(context, state),
              menuActions([
                commonActionBlockProfile(context, () {
                  context.read<ViewProfileBloc>().add(BlockProfile(initialProfile.uuid));
                }),
                BlocBuilder<AccountBloc, AccountBlocData>(
                  builder: (_, state) {
                    final p = AccountAdminSettingsPermissions(state.permissions);
                    if (p.somePermissionEnabled()) {
                      return MenuItemButton(
                        onPressed: () {
                          MyNavigator.push(context, MaterialPage<void>(child: AccountAdminSettingsScreen(
                            accountId: initialProfile.uuid,
                            age: initialProfile.age,
                            name: initialProfile.name,
                          )));
                        },
                        child: const Text("Admin"),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ]),
            ],
          ),
          body: myProfilePage(context),
          floatingActionButton: actionButton(context, state),
        );
      }
    );
  }

  Widget favoriteButton(BuildContext context, ViewProfilesData state) {
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
  }

  Widget? actionButton(BuildContext context, ViewProfilesData state) {
    if (noAction) {
      return null;
    }

    switch (state.profileActionState) {
      case ProfileActionState.like:
        return FloatingActionButton(
          onPressed: () => confirmProfileAction(
            context,
            state,
            context.strings.view_profile_screen_like_action_dialog_title
          ),
          tooltip: context.strings.view_profile_screen_like_action,
          child: const Icon(Icons.waving_hand),
        );
      case ProfileActionState.makeMatch || ProfileActionState.chat:
        return FloatingActionButton(
          onPressed: () => openConversationScreen(context, state.profile),
          tooltip: context.strings.view_profile_screen_chat_action,
          child: const Icon(Icons.chat_rounded),
        );
      case null:
        return null;
    }
  }

  void confirmProfileAction(BuildContext context, ViewProfilesData s, String dialogTitle, {String? details}) async {
    final accepted = await showConfirmDialog(context, dialogTitle, details: details);
    final action = s.profileActionState;
    if (context.mounted && accepted == true && action != null) {
      context.read<ViewProfileBloc>()
        .add(DoProfileAction(
          s.profile.uuid,
          action,
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
        if (state.showLikeFailedBecauseAlreadyMatch) {
          showSnackBar(context.strings.view_profile_screen_already_match);
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
