

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/content.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:pihka_frontend/localizations.dart';


class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.view_profile_screen_my_profile_title)),
      body: myProfilePage(context),
      floatingActionButton: BlocBuilder<MyProfileBloc, MyProfileData>(
        builder: ((context, state) {
          final profile = state.profile;
          void Function()? onPressed;
          if (profile != null) {
            onPressed = () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => EditProfilePage(
                initialProfile: profile,
                profilePicturesBloc: context.read<ProfilePicturesBloc>(),
                editMyProfileBloc: context.read<EditMyProfileBloc>(),
              ))
            );
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
