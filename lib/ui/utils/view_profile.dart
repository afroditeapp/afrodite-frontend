


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/database/profile_entry.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/view_image_screen.dart';

const double imgHeight = 400;

Widget viewProifle(BuildContext context, AccountId account, ProfileEntry profile, ProfileHeroTag? heroTransition, bool showGridImage) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final Widget imgWidget = viewProifleImage(context, profile, heroTransition, showGridImage, constraints);
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

Widget viewProifleImage(BuildContext context, ProfileEntry profile, ProfileHeroTag? heroTransition, bool showGridImage, BoxConstraints constraints) {

  final double imgMaxWidth;
  if (showGridImage) {
    imgMaxWidth = constraints.maxWidth / 2.0;
  } else {
    imgMaxWidth = constraints.maxWidth;
  }

  final Widget primaryImageWidget = accountImgWidget(
    profile.uuid,
    profile.imageUuid,
    width: imgMaxWidth,
    height: imgHeight,
  );

  final Widget imgWidget;
  if (heroTransition != null) {
    imgWidget = Hero(
      tag: heroTransition,
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

Widget buildProgressIndicator(double imgMaxWidth) {
  return SizedBox(width: imgMaxWidth, child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  ));
}
