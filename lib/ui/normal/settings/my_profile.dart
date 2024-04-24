

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/location.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:pihka_frontend/localizations.dart';


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
      body: myProfilePage(context),
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
        if (profile != null) {
          return ViewProfileEntry(profile: profile);
        } else {
          return Text(context.strings.generic_empty);
        }
      }
    );
  }
}
