

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/profile_pictures.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/edit_my_profile.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui/utils/view_profile.dart';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/loading_dialog.dart';


class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.view_profile_screen_my_profile_title),
        actions: [
          IconButton(
            onPressed: () =>
              MyNavigator.push(context, const MaterialPage<void>(child: LocationScreen())),
            icon: const Icon(Icons.location_on),
            tooltip: context.strings.profile_location_screen_title,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: myProfilePage(context)),
          ProgressDialogOpener<MyProfileBloc, MyProfileData>(
            dialogVisibilityGetter: (state) => state.loadingMyProfile,
          )
        ]
      ),
      floatingActionButton: BlocBuilder<MyProfileBloc, MyProfileData>(
        builder: ((context, state) {
          final profile = state.profile;
          void Function()? onPressed;
          if (profile != null) {
            onPressed = () {
              final pageKey = PageKey();
              MyNavigator.pushWithKey(
                context,
                MaterialPage<void>(child: EditProfilePage(
                  pageKey: pageKey,
                  initialProfile: profile,
                  profilePicturesBloc: context.read<ProfilePicturesBloc>(),
                  editMyProfileBloc: context.read<EditMyProfileBloc>(),
                  profileAttributesBloc: context.read<ProfileAttributesBloc>(),
                )),
                pageKey,
              );
            };
          }

          return FloatingActionButton(
            onPressed: onPressed,
            tooltip: context.strings.view_profile_screen_my_profile_edit_action,
            child: const Icon(Icons.edit),
          );
        })
      ),
    );
  }

  Widget myProfilePage(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, profileState) {
        final profile = profileState.profile;

        final Widget wantedWidget;
        if (profile != null) {
          wantedWidget = Align(
            alignment: Alignment.topCenter,
            child: ViewProfileEntry(profile: profile),
          );
        } else {
          wantedWidget = Center(
            child: Column(
              children: [
                const Spacer(),
                Text(context.strings.view_profile_screen_my_profile_loading_failed),
                const Padding(padding: EdgeInsets.all(8)),
                ElevatedButton(
                  onPressed: () => context.read<MyProfileBloc>().add(ReloadMyProfile()),
                  child: Text(context.strings.generic_try_again),
                ),
                const Spacer(flex: 3),
              ],
            ),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: wantedWidget,
        );
      }
    );
  }
}
