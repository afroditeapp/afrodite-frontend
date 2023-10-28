

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/logic/profile/view_profiles/view_profiles.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef ProfileHeroTag = (AccountId accountId, int index);

/// Might return [RemoveProfileFromList] when navigating back to previous page
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
            if (currentState.isFavorite) {
              return IconButton(
                onPressed: () async {
                  context.read<ViewProfileBloc>().add(ToggleFavoriteStatus(currentState.accountId));
                },
                icon: const Icon(Icons.star_rounded),
              );
            } else {
              return IconButton(
                onPressed: () async {
                  context.read<ViewProfileBloc>().add(ToggleFavoriteStatus(currentState.accountId));
                },
                icon: const Icon(Icons.star_outline_rounded),
              );
            }
          })
        ],
      ),
      body: myProfilePage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (),
        tooltip: 'Like',
        child: const Icon(Icons.favorite),
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
    final profile = state.profile;
    final primaryProfileImage = state.primaryProfileImage;

    return StreamBuilder<GetProfileResult>(
      stream: ProfileRepository.getInstance().getProfileStream(accountId),
      initialData: GetProfileSuccess(profile),
      builder: (context, snapshot) {
        final img = PrimaryImageFile(primaryProfileImage, heroTransition: state.imgTag);
        switch (snapshot.data) {
          case GetProfileSuccess data:
            return viewProifle(context, accountId, data.profile, img, true);
          case GetProfileDoesNotExist(): {
            // TODO: Is this called multiple times?
            Future.delayed(Duration.zero, () {
              showInfoDialog(context, "Profile not available").then((value) {
                Navigator.pop(context, RemoveProfileFromList());
              });
            });

            return viewProifle(context, accountId, profile, img, true);
          }
          case GetProfileFailed() || null: {
            Future.delayed(Duration.zero, () {
              showSnackBar("Profile loading error");
            });
            return viewProifle(context, accountId, profile, img, true);
          }
        }
      }
    );
  }
}
