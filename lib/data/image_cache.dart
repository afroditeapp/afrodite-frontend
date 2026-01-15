import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:app/ui_utils/profile_thumbnail_image.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:openapi/api.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:utils/utils.dart';

import 'package:image/image.dart' as img;
import 'package:app/model/freezed/utils/account_img_key.dart';

class ImageCacheData extends AppSingleton {
  ImageCacheData._private()
    : cacheManager = CacheManager(
        Config(
          "image_cache",
          stalePeriod: const Duration(days: 90),
          // Images are about 100 KiB each, so 10 000 images is about 1 GiB
          maxNrOfCacheObjects: 10000,
        ),
      );
  static final _instance = ImageCacheData._private();
  factory ImageCacheData.getInstance() {
    return _instance;
  }

  final CacheManager cacheManager;

  /// Get image bytes for profile picture.
  Future<Uint8List?> getImage(
    AccountId imageOwner,
    ContentId id, {
    bool isMatch = false,
    required MediaRepository media,
  }) async {
    if (kIsWeb) {
      // Web uses XMLHttpRequest for caching
      return await media.getImage(imageOwner, id, isMatch: isMatch);
    }
    final imgKey = "img:${imageOwner.aid}${id.cid}";
    final fileInfo = await cacheManager.getFileFromCache(imgKey);
    if (fileInfo != null) {
      try {
        return await fileInfo.file.readAsBytes();
      } catch (_) {
        // Fallback to image downloading
      }
    }

    final imageData = await media.getImage(imageOwner, id, isMatch: isMatch);
    if (imageData == null || imageData.isEmpty) {
      return null;
    }

    try {
      await cacheManager.putFile("null", imageData, key: imgKey);
    } catch (_) {
      // Ignore errors
    }
    return imageData;
  }

  /// Get PNG file bytes for map tile.
  Future<Uint8List?> getMapTile(
    int z,
    int x,
    int y,
    int version, {
    required MediaRepository media,
  }) async {
    final String? mapTileCacheKey;
    if (kIsWeb) {
      // Web uses XMLHttpRequest for caching
      mapTileCacheKey = null;
    } else {
      final key = createMapTileKey(z, x, y, version);
      mapTileCacheKey = key;
      final fileInfo = await cacheManager.getFileFromCache(key);
      if (fileInfo != null) {
        try {
          return await fileInfo.file.readAsBytes();
        } catch (_) {
          // Fallback to image downloading
        }
      }
    }

    final tileResult = await media.getMapTile(z, x, y, version);
    final Uint8List tilePngData;
    switch (tileResult) {
      case MapTileSuccess tileResult:
        tilePngData = tileResult.pngData;
      case MapTileNotAvailable():
        tilePngData = _cachedEmptyMapTile();
      case MapTileError():
        return null;
    }

    if (mapTileCacheKey != null) {
      try {
        if (tilePngData.isEmpty) {
          return null;
        }
        await cacheManager.putFile("null", tilePngData, key: mapTileCacheKey);
      } catch (_) {
        // Ignore errors
      }
    }

    return tilePngData;
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}

String createMapTileKey(int z, int x, int y, int version) {
  return "map_tile:${z}_${x}_${y}_$version";
}

Uint8List? _emptyMapTilePng;

Uint8List _cachedEmptyMapTile() {
  final data = _emptyMapTilePng ?? _emptyMapTilePngBytes();
  _emptyMapTilePng = data;
  return data;
}

Uint8List _emptyMapTilePngBytes() {
  final imageBuffer = img.Image(width: 1, height: 1);

  for (var pixel in imageBuffer) {
    pixel
      ..r = MAP_BACKGROUND_COLOR.r
      ..g = MAP_BACKGROUND_COLOR.g
      ..b = MAP_BACKGROUND_COLOR.b
      ..a = 255;
  }

  return img.encodePng(imageBuffer);
}

class AccountImageProvider extends ImageProvider<AccountImgKey> {
  final AccountImgKey imgInfo;
  final bool isMatch;
  final MediaRepository media;

  AccountImageProvider._(this.imgInfo, {this.isMatch = false, required this.media});

  @override
  ImageStreamCompleter loadImage(AccountImgKey key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(() async {
      final imgBytes = await ImageCacheData.getInstance().getImage(
        imgInfo.accountId,
        imgInfo.contentId,
        isMatch: isMatch,
        media: media,
      );

      if (imgBytes == null) {
        return Future<ImageInfo>.error("Failed to load the image");
      }

      final buffer = await ImmutableBuffer.fromUint8List(imgBytes);
      final codec = await decode(buffer);
      final frame = await codec.getNextFrame();

      final cropArea = imgInfo.cropArea;
      if (cropArea == null) {
        return ImageInfo(image: frame.image);
      }

      final pictureRecorder = PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      final painter = CroppedImagePainter(frame.image, cropArea);
      final srcRect = painter.calculateSrcRect();
      final int dstSize;
      final Rect dstRect;
      if (imgInfo.cacheSize == ImageCacheSize.useImageResolution()) {
        dstSize = srcRect.width.toInt();
        dstRect = Rect.fromLTWH(0, 0, srcRect.width, srcRect.width);
      } else {
        dstSize = imgInfo.cacheSize.squareSize();
        dstRect = Rect.fromLTWH(0, 0, dstSize.toDouble(), dstSize.toDouble());
      }
      canvas.drawImageRect(frame.image, srcRect, dstRect, Paint());
      final image = await pictureRecorder.endRecording().toImage(dstSize, dstSize);
      return ImageInfo(image: image);
    }());
  }

  @override
  Future<AccountImgKey> obtainKey(ImageConfiguration configuration) => SynchronousFuture(imgInfo);

  static ImageProvider<Object> create(
    AccountId accountId,
    ContentId contentId, {
    bool isMatch = false,
    required ImageCacheSize cacheSize,
    required MediaRepository media,
    required CropArea? cropArea,
  }) {
    final ImageCacheSize size;
    if (!kIsWeb &&
        Platform.isIOS &&
        cropArea == null &&
        cacheSize != ImageCacheSize.useImageResolution()) {
      // Downscaling with ResizeImage seems to create blurry images
      // at least with iPhone SE (2020), so increase image resolution
      // as a workaround on iOS. Alternative solution could be
      // resizing images using AccountImageProvider as that seems
      // to create sharper looking images.
      size = ImageCacheSize.maxDisplaySize();
    } else {
      size = cacheSize;
    }

    final key = AccountImgKey(
      accountId: accountId,
      contentId: contentId,
      cacheSize: size,
      cropArea: cropArea,
    );
    final imgProvider = AccountImageProvider._(key, isMatch: isMatch, media: media);
    if (cropArea == null && size != ImageCacheSize.useImageResolution()) {
      return ResizeImage(
        imgProvider,
        width: size.width,
        height: size.height,
        allowUpscaling: false,
        policy: ResizeImagePolicy.fit,
      );
    } else {
      // AccountImageProvider handles resizing
      return imgProvider;
    }
  }
}

/// Either width or height or both must be set
class ImageCacheSize {
  final int? width;
  final int? height;
  ImageCacheSize.useImageResolution() : width = null, height = null;
  ImageCacheSize._height({required int this.height}) : width = null;
  ImageCacheSize._widthAndHeight({required int this.width, required int this.height});

  /// Use this size if image size changes when app window size changes.
  factory ImageCacheSize.maxDisplaySize() {
    int? width;
    int? height;
    for (final d in PlatformDispatcher.instance.displays) {
      width = max(width ?? 0, d.size.width.toInt());
      height = max(height ?? 0, d.size.height.toInt());
    }
    final maxWidth = width ?? 1920;
    final maxHeight = height ?? 1080;
    return ImageCacheSize._widthAndHeight(width: maxWidth, height: maxHeight);
  }

  factory ImageCacheSize.constantHeight(BuildContext context, double height) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._height(height: (height * devicePixelRatio).round());
  }

  factory ImageCacheSize.constantWidthAndHeight(BuildContext context, double width, double height) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._widthAndHeight(
      width: (width * devicePixelRatio).round(),
      height: (height * devicePixelRatio).round(),
    );
  }

  factory ImageCacheSize.constantSquare(BuildContext context, double widthAndHeight) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._widthAndHeight(
      width: (widthAndHeight * devicePixelRatio).round(),
      height: (widthAndHeight * devicePixelRatio).round(),
    );
  }

  static ImageCacheSize squareImageForAppBarThumbnail(BuildContext context, double widthAndHeight) {
    // Multiply size by 2 to make images more smoother on iPhone SE (2020)
    return ImageCacheSize.constantSquare(context, widthAndHeight * 2);
  }

  static ImageCacheSize squareImageForGrid(BuildContext context, double widthAndHeight) {
    return ImageCacheSize.constantSquare(context, widthAndHeight);
  }

  static ImageCacheSize squareImageForListWithTextContent(
    BuildContext context,
    double widthAndHeight,
  ) {
    return ImageCacheSize.constantSquare(context, widthAndHeight);
  }

  @override
  bool operator ==(Object other) {
    return other is ImageCacheSize && other.width == width && other.height == height;
  }

  @override
  int get hashCode => Object.hash(width, height);

  int squareSize() {
    final w = width;
    final h = height;
    if (w != null && h != null) {
      return min(w, h);
    } else {
      return (w ?? h)!;
    }
  }
}

class PrecacheImageForViewProfileScreen {
  static Future<void> usingProfileEntry(BuildContext context, ProfileEntry e) async {
    final first = e.content.firstOrNull;
    if (first != null && first.primary == true && first.accepted == true) {
      // AccountImageProvider.create does not need isMatch
      // set to true as image is available locally and
      // it is loaded to ImageCache.
      await PrecacheImageForViewProfileScreen.usingAccountAndContentIds(
        context,
        e.accountId,
        first.id,
      );
    }
  }

  static Future<void> usingAccountAndContentIds(
    BuildContext context,
    AccountId account,
    ContentId content,
  ) async {
    final imageProvider = AccountImageProvider.create(
      account,
      content,
      cacheSize: PrecacheImageForViewProfileScreen.cacheSizeForViewProfileScreenImages(context),
      media: context.read<RepositoryInstances>().media,
      cropArea: null,
    );
    await precacheImage(imageProvider, context);
  }

  static ImageCacheSize cacheSizeForViewProfileScreenImages(BuildContext context) {
    if (kIsWeb || !Platform.isIOS) {
      return ImageCacheSize.constantHeight(context, VIEW_PROFILE_WIDGET_IMG_HEIGHT);
    } else {
      // Downscaling with ResizeImage seems to create blurry images
      // at least with iPhone SE (2020), so don't downscale images
      // on iOS. If image resizing is needed consider using
      // AccountImageProvider as that seems to create sharper looking images.
      return ImageCacheSize.useImageResolution();
    }
  }
}
