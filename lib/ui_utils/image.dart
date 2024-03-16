



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/localizations.dart';

/// Widget for showing account image. It will show progress indicator while
/// image is being loaded.
class AccountImage extends StatelessWidget {
  const AccountImage({
    required this.accountId,
    required this.contentId,
    this.imageBuilder = defaultImgBuilder,
    Key? key,
  }) : super(key: key);
  final AccountId accountId;
  final ContentId contentId;
  final Widget Function(File file) imageBuilder;

  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      future: ImageCacheData.getInstance().getImage(accountId, contentId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator();
          }
          case ConnectionState.none || ConnectionState.done: {
            final imageFile = snapshot.data;
            if (imageFile != null) {
              return imageBuilder(imageFile);
            } else {
              return Text(context.strings.generic_error);
            }
          }
        }
      },
    );
  }

  Widget buildProgressIndicator() {
    return const SizedBox(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
    ));
  }
}

Widget defaultImgBuilder(File f) {
  return Image.file(f);
}
