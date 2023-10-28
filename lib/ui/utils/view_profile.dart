


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/normal/profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';

const double imgHeight = 400;

Widget viewProifle(BuildContext context, AccountId account, Profile profile, PrimaryImageProvider img, bool showGridImage) {
  return LayoutBuilder(
    builder: (context, constraints) {

      final Widget imgWidget;
      switch (img) {
        case PrimaryImageFile():

          final tag = img.heroTransition;
          if (tag != null) {
            imgWidget = Hero(
              tag: tag,
              child: Image.file(
                img.file,
                width: constraints.maxWidth,
                height: imgHeight,
              ),
            );
          } else {
            imgWidget = Image.file(
              img.file,
              width: constraints.maxWidth,
              height: imgHeight,
            );
          }
        case PrimaryImageInfo():
          imgWidget = viewProifleImage(context, account, profile, img, showGridImage, constraints);
      }
      String profileText;
      if (profile.profileText.isEmpty) {
        profileText = AppLocalizations.of(context).genericEmpty;
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

Widget viewProifleImage(BuildContext context, AccountId account, Profile profile, PrimaryImageInfo img, bool showGridImage, BoxConstraints constraints) {

  final double imgMaxWidth;
  if (showGridImage) {
    imgMaxWidth = constraints.maxWidth / 2.0;
  } else {
    imgMaxWidth = constraints.maxWidth;
  }

  final Widget primaryImageWidget;
  final imgContentId = img.img.contentId;
  if (imgContentId != null) {
    primaryImageWidget = FutureBuilder(
      future: ImageCacheData.getInstance().getImage(account, imgContentId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator(imgMaxWidth);
          }
          case ConnectionState.none || ConnectionState.done: {
            final imageFile = snapshot.data;
            if (imageFile != null) {
              return InkWell( // TODO: remove?
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ImagePage(account, imgContentId)));
                },
                child: Image.file(
                  imageFile,
                  width: imgMaxWidth,
                  height: imgHeight,
                ),
              );
            } else {
              return Text(AppLocalizations.of(context).genericError);
            }
          }
        }
    },);
  } else {
    primaryImageWidget = Text(AppLocalizations.of(context).genericEmpty);
  }

  return Row(
    children: [
      primaryImageWidget,
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


sealed class PrimaryImageProvider {}

class PrimaryImageFile extends PrimaryImageProvider {
  final File file;
  final ProfileHeroTag? heroTransition;
  PrimaryImageFile(this.file, {this.heroTransition});
}

class PrimaryImageInfo extends PrimaryImageProvider {
  final PrimaryImage img;
  PrimaryImageInfo(this.img);
}


/// Notifies the [ProfileView] to remove viewed profile from list.
class RemoveProfileFromList {}
