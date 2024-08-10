



import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/login_repository.dart';

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


Widget accountImgWidget(
  AccountId accountId,
  ContentId contentId,
  {
    bool isMatch = false,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    ImageCacheSize cacheSize = ImageCacheSize.maxQuality,
  }
) {
  return Image(
    image: AccountImageProvider.create(
      accountId,
      contentId,
      isMatch: isMatch,
      sizeSetting: cacheSize,
      media: LoginRepository.getInstance().repositories.media,
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
    image: AccountImageProvider.create(
      accountId,
      contentId,
      isMatch: isMatch,
      media: LoginRepository.getInstance().repositories.media,
    ),
    width: width,
    height: height,
    alignment: alignment,
    fit: fit,
  );
}
