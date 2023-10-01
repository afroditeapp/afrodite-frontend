

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef ProfileHeroTag = (AccountId accountId, int index);

class ViewProfilePage extends StatelessWidget {
  final AccountId accountId;
  final Profile profile;
  final File primaryProfileImage;
  final int uiIndex;

  const ViewProfilePage(this.accountId, this.profile, this.primaryProfileImage, this.uiIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.transparent,
        // iconTheme: const IconThemeData(
        //   color: Colors.black45,
        // ),
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
    return StreamBuilder<Profile?>(
      stream: ProfileRepository.getInstance().getProfileStream(accountId),
      initialData: profile,
      builder: (context, snapshot) {
        final img = PrimaryImageFile(primaryProfileImage, heroTransition: (accountId, uiIndex));
        final data = snapshot.data;
        if (data != null) {
          return viewProifle(context, accountId, data, img, true);
        } else {
          return viewProifle(context, accountId, profile, img, true);
        }
      }
    );
  }
}
