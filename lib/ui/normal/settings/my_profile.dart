

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:pihka_frontend/localizations.dart';


class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile());

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.pageMyProfileTitle)),
      body: myProfilePage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const EditProfilePage()),),
        tooltip: 'Edit profile',
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget myProfilePage(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, accountState) {
        final id = accountState.accountId;
        if (id == null) {
          return Text(context.strings.generic_error);
        } else {
          return BlocBuilder<ProfileBloc, ProfileData>(
            builder: (context, profileState) {
              final profile = profileState.profile;
              final img = profileState.primaryImage;
              if (profile != null && img != null) {
                return viewProifle(context, id, profile, PrimaryImageInfo(img), false);
              } else {
                return Text(context.strings.genericEmpty);
              }
            }
          );
        }
      }
    );
  }
}
