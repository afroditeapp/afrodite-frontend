

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
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
  final Profile profile = Profile(name: "test", profileText: "test", version: ProfileVersion(versionUuid: "123"));
  final File primaryProfileImage;
  final int uiIndex;

  ViewProfilePage(this.accountId, this.primaryProfileImage, this.uiIndex, {super.key});

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
    // return Hero(
    //   tag: accountId,
    //   child: Image.file(primaryProfileImage)
    // );
    //final primaryImage = PrimaryImage(contentId: image, gridCropSize: 0.0, gridCropX: 0.0, gridCropY: 0.0);
    return viewProifle(context, accountId, profile, PrimaryImageFile(primaryProfileImage, heroTransition: (accountId, uiIndex)), true);
  }
}
