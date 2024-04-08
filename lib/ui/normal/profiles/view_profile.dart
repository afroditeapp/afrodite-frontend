


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

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
  {
    ProfileHeroTag? heroTag,
    bool noAction = false,
  }
) {
  context.read<ViewProfileBloc>().add(SetProfileView(profile));
  final Route<void> route;
  route = MaterialPageRoute<void>(
    builder: (_) => ViewProfilePage(initialProfile: profile, noAction: noAction)
  );
  Navigator.push(
    context,
    route,
  );
}

class ViewProfilePage extends StatelessWidget {
  final bool noAction;
  final ProfileEntry initialProfile;
  final ProfileHeroTag? heroTag;

  const ViewProfilePage({required this.initialProfile, this.heroTag, this.noAction = false, super.key});

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
          BlocBuilder<ViewProfileBloc, ViewProfilesData?>(builder: (context, state) {
            final s = state;
            if (s == null) {
              return const SizedBox.shrink();
            }
            final Icon icon;
            final String tooltip;
            if (s.isFavorite.isFavorite) {
              icon = const Icon(Icons.star_rounded);
              tooltip = context.strings.view_profile_screen_remove_from_favorites_action;
            } else {
              icon = const Icon(Icons.star_outline_rounded);
              tooltip = context.strings.view_profile_screen_add_to_favorites_action;
            }
            return IconButton(
              onPressed: () {
                switch (s.isFavorite) {
                  case FavoriteStateIdle():
                    context.read<ViewProfileBloc>().add(ToggleFavoriteStatus(s.profile.uuid));
                  case FavoriteStateChangeInProgress():
                    showSnackBar(context.strings.generic_previous_action_in_progress);
                }
              },
              icon: icon,
              tooltip: tooltip,
            );
          }),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem<void>(
                  onTap: () async {
                    final accepted = await showConfirmDialog(context, context.strings.view_profile_screen_block_action_dialog_title);
                    if (context.mounted && accepted == true) {
                      context.read<ViewProfileBloc>().add(BlockProfile(initialProfile.uuid));
                    }
                  },
                  child: Text(context.strings.view_profile_screen_block_action),
                ),
              ];
            },
          ),
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

    return BlocBuilder<ViewProfileBloc, ViewProfilesData?>(
      builder: (context, state) {
        if (state == null || state.profile.uuid != initialProfile.uuid) {
          return const SizedBox.shrink();
        }
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
          child: const Icon(Icons.favorite_rounded),
        );
      case ProfileActionState.removeLike:
        return FloatingActionButton(
          onPressed: () => confirmProfileAction(
            context,
            s,
            context.strings.view_profile_screen_remove_like_action_dialog_title,
          ),
          tooltip: context.strings.view_profile_screen_remove_like_action,
          child: const Icon(Icons.undo_rounded),
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
    return BlocBuilder<ViewProfileBloc, ViewProfilesData?>(
      builder: (context, state) {
        if (state == null || state.profile.uuid != initialProfile.uuid) {
          return const SizedBox.shrink();
        }

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

      if (state.showLikeCompleted || state.showRemoveLikeCompleted) {
        if (state.showLikeCompleted) {
          showSnackBar(context.strings.view_profile_screen_like_action_successful);
        }
        if (state.showRemoveLikeCompleted) {
          showSnackBar(context.strings.view_profile_screen_remove_like_action_successful);
        }
        context.read<ViewProfileBloc>().add(ResetShowMessages());
      }

      // Added canPop tests here because testing emitting isBlocked with delay
      // resulted a black screen once.

      if (state.isNotAvailable) {
        await showInfoDialog(
          context,
          context.strings.view_profile_screen_profile_not_available_dialog_description
        );
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      } else if (state.isBlocked) {
        showSnackBar(context.strings.view_profile_screen_block_action_successful);
        if (context.mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }
}
