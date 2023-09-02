


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';


Widget viewProifle(BuildContext context, AccountId account, Profile profile, PrimaryImage img, bool showGridImage) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Column(
        children: [
          viewProifleImage(context, account, profile, img, showGridImage, constraints),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.name, style: Theme.of(context).textTheme.titleLarge),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.profileText, style: Theme.of(context).textTheme.bodyMedium),
          ),

        ]
      );
    }
  );
}

Widget viewProifleImage(BuildContext context, AccountId account, Profile profile, PrimaryImage img, bool showGridImage, BoxConstraints constraints) {

  final double imgMaxWidth;
  if (showGridImage) {
    imgMaxWidth = constraints.maxWidth / 2.0;
  } else {
    imgMaxWidth = constraints.maxWidth;
  }

  final Widget primaryImageWidget;
  final imgContentId = img.contentId;
  if (imgContentId != null) {
    primaryImageWidget = FutureBuilder(
      future: ImageCacheData.getInstance().getImage(account, imgContentId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator(imgMaxWidth);
          }
          case ConnectionState.none || ConnectionState.done: {
            final data = snapshot.data;
            if (data != null) {
              return InkWell( // TODO: remove?
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ImagePage(account, imgContentId)));
                },
                child: Image.memory(
                  data,
                  width: imgMaxWidth,
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
