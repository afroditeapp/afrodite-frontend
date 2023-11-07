

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef ProfileHeroTag = (AccountId accountId, int uniqueCounterNumber);

class ViewProfilePage extends StatelessWidget {
  // final AccountId accountId;
  // final Profile profile;
  // final File primaryProfileImage;
  // final int uiIndex;

  const ViewProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.transparent,
        // iconTheme: const IconThemeData(
        //   color: Colors.black45,
        // ),
        actions: [
          BlocBuilder<ViewProfileBloc, ViewProfilesData?>(builder: (context, state) {
            final currentState = state;
            if (currentState == null) {
              return Container();
            }
            final Icon icon;
            if (currentState.isFavorite) {
              icon = const Icon(Icons.star_rounded);
            } else {
              icon = const Icon(Icons.star_outline_rounded);
            }
            return IconButton(
              onPressed: () =>
                context.read<ViewProfileBloc>().add(ToggleFavoriteStatus(currentState.accountId)),
              icon: icon,
            );
          }),
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: "block", child: Text("Block")),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case "block": {
                  showConfirmDialog(context, "Block profile?")
                    .then((value) {
                      if (value == true) {
                        context.read<ViewProfileBloc>().add(BlockCurrentProfile());
                      }
                    });
                }
              }
            },
          ),
        ],
      ),
      body: myProfilePage(context),
      floatingActionButton: BlocBuilder<ViewProfileBloc, ViewProfilesData?>(
        builder: (context, state) {
          final currentState = state;
          if (currentState == null) {
            return Container();
          }
          switch (currentState.profileActionState) {
            case ProfileActionState.like:
              return FloatingActionButton(
                onPressed: () =>
                  showConfirmDialog(context, "Send like?")
                    .then((value) {
                      if (value == true) {
                        context.read<ViewProfileBloc>()
                          .add(DoProfileAction(
                            currentState.accountId,
                            currentState.profileActionState
                          ));
                      }
                    }),
                tooltip: 'Send like',
                child: const Icon(Icons.favorite_rounded),
              );
            case ProfileActionState.removeLike:
              return FloatingActionButton(
                onPressed: () =>
                  showConfirmDialog(context, "Remove like?")
                    .then((value) {
                      if (value == true) {
                        context.read<ViewProfileBloc>()
                          .add(DoProfileAction(
                            currentState.accountId,
                            currentState.profileActionState
                          ));
                      }
                    }),
                tooltip: 'Remove like',
                child: const Icon(Icons.undo_rounded),
              );
            case ProfileActionState.makeMatch:
              return FloatingActionButton(
                onPressed: () {
                  context.read<ConversationBloc>().add(SetConversationView(currentState.accountId, currentState.profile.name, currentState.primaryProfileImage));
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ConversationPage(currentState.accountId)));
                },
                tooltip: 'Send message to make a match',
                child: const Icon(Icons.waving_hand),
              );
            case ProfileActionState.chat:
              return FloatingActionButton(
                onPressed: () {
                  context.read<ConversationBloc>().add(SetConversationView(currentState.accountId, currentState.profile.name, currentState.primaryProfileImage));
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ConversationPage(currentState.accountId)));
                },
                tooltip: 'Open chat',
                child: const Icon(Icons.chat_rounded),
              );
          }
        }
      ),
      //extendBodyBehindAppBar: true,
    );
  }

  Widget myProfilePage(BuildContext context) {
    // TODO: Use BlocBuilder instead of StreamBuilder?
    final state = context.read<ViewProfileBloc>().state;
    if (state == null) {
      return Container();
    }

    final accountId = state.accountId;
    final primaryProfileImage = state.primaryProfileImage;

    return BlocBuilder<ViewProfileBloc, ViewProfilesData?>(
      builder: (context, state) {
        if (state == null) {
          return Container();
        }

        final img = PrimaryImageFile(primaryProfileImage, heroTransition: state.imgTag);
        if (state.isNotAvailable) {
          Future.delayed(Duration.zero, () {
            showInfoDialog(context, "Profile not available").then((value) {
              Navigator.pop(context);
            });
          });
          return Container();
        } else if (state.showLoadingError) {
          Future.delayed(Duration.zero, () {
            showSnackBar("Profile loading error");
          }).then((value) => context.read<ViewProfileBloc>().add(ResetShowMessages()));
        } else if (state.showLikeCompleted) {
          Future.delayed(Duration.zero, () {
            showSnackBar("Like sent");
          }).then((value) => context.read<ViewProfileBloc>().add(ResetShowMessages()));
        } else if (state.showRemoveLikeCompleted) {
          Future.delayed(Duration.zero, () {
            showSnackBar("Like removed");
          }).then((value) => context.read<ViewProfileBloc>().add(ResetShowMessages()));
        } else if (state.isBlocked) {
          Future.delayed(Duration.zero, () {
            showSnackBar("Profile was blocked");
            Navigator.pop(context);
          });
        }

        return viewProifle(context, accountId, state.profile, img, true);
      }
    );
  }
}
