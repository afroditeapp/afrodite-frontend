



import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils/account_img_key.dart';

/// Widget for showing account image. It will show progress indicator while
/// image is being loaded.
class AccountImage extends StatelessWidget {
  const AccountImage({
    required this.accountId,
    required this.contentId,
    this.width,
    this.height,
    // this.imageBuilder = defaultImgBuilder,
    Key? key,
  }) : super(key: key);
  final AccountId accountId;
  final ContentId contentId;
  final double? width;
  final double? height;
  // final Widget Function(XFile file) imageBuilder;

  @override
  Widget build(BuildContext context) {
     return accountImgWidget(accountId, contentId);
  }

  Widget buildProgressIndicator() {
    return SizedBox(
      width: width,
      height: height,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

Widget defaultImgBuilder(XFile f) {
  return xfileImgWidget(f);
}

Widget xfileImgWidget(XFile imageFile, {double? width, double? height, AlignmentGeometry alignment = Alignment.center}) {
  if (kIsWeb) {
    throw UnsupportedError("xfileImgWidget: Error cases create correct UI?");
    // return FutureBuilder(
    //   future: imageFile.readAsBytes(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       final bytes = snapshot.data;
    //       if (bytes != null) {
    //         return Image.memory(bytes);
    //       } else {
    //         return Container();
    //       }
    //     } else {
    //       return Container();
    //     }
    //   }
    // );
  } else {
    return Image.file(File(imageFile.path), width: width, height: height, alignment: alignment);
  }
}

/// Image with InkWell ink splash effect.
Widget xfileImgWidgetInk(
  XFile imageFile,
  {
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    BoxFit? fit,
  }
) {
  if (kIsWeb) {
    throw UnsupportedError("xfileImgWidget: Error cases create correct UI?");
    // return FutureBuilder(
    //   future: imageFile.readAsBytes(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       final bytes = snapshot.data;
    //       if (bytes != null) {
    //         return Image.memory(bytes);
    //       } else {
    //         return Container();
    //       }
    //     } else {
    //       return Container();
    //     }
    //   }
    // );
  } else {
    return Ink.image(
      image: FileImage(File(imageFile.path)),
      width: width,
      height: height,
      alignment: alignment,
      fit: fit,
    );
  }
}


Widget accountImgWidget(AccountId accountId, ContentId contentId, {bool isMatch = false, double? width, double? height, AlignmentGeometry alignment = Alignment.center}) {
  return Image(
    image: AccountImageProvider(
      AccountImgKey(accountId: accountId, contentId: contentId),
      isMatch: isMatch,
    ),
    width: width,
    height: height,
    alignment: alignment
  );
}

/// Image with InkWell ink splash effect.
Widget accountImgWidgetInk(
  AccountId accountId,
  ContentId contentId,
  {
    bool isMatch = false,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    BoxFit? fit,
  }
) {
  return Ink.image(
    image: AccountImageProvider(
      AccountImgKey(accountId: accountId, contentId: contentId),
      isMatch: isMatch,
    ),
    width: width,
    height: height,
    alignment: alignment,
    fit: fit,
  );
}
