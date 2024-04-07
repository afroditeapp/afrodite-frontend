


import 'package:flutter/material.dart';
import 'package:pihka_frontend/database/profile_entry.dart';

import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/image.dart';

const double PROFILE_IMG_HEIGHT = 400;

Widget viewProifle(BuildContext context, ProfileEntry profile, {ProfileHeroTag? heroTag}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final Widget imgWidget = viewProifleImage(context, profile, heroTag);
      String profileText;
      if (profile.profileText.isEmpty) {
        profileText = "";
      } else {
        profileText = profile.profileText;
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            imgWidget,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(profile.name, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(profileText, style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),

          ]
        ),
      );
    }
  );
}

Widget viewProifleImage(BuildContext context, ProfileEntry profile, ProfileHeroTag? heroTag) {
  final Widget primaryImageWidget = accountImgWidget(
    profile.uuid,
    profile.imageUuid,
    height: PROFILE_IMG_HEIGHT,
  );

  final Widget imgWidget;
  if (heroTag != null) {
    imgWidget = Hero(
      tag: heroTag.value,
      child: primaryImageWidget
    );
  } else {
    imgWidget = primaryImageWidget;
  }

  return Row(
    children: [
      imgWidget,
    ]
  );
}
