import 'dart:ui';

import 'package:app/data/login_repository.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:app/ui_utils/profile_thumbnail_image.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/storage/encryption.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:utils/utils.dart';

import 'package:image/image.dart' as img;
import 'package:app/model/freezed/utils/account_img_key.dart';

var log = Logger("ImageCacheData");

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
        final encryptedImgBytes = await fileInfo.file.readAsBytes();
        final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(
          encryptedImgBytes,
        );
        return decryptedImgBytes;
      } catch (_) {
        // Fallback to image downloading
      }
    }

    final imageData = await media.getImage(imageOwner, id, isMatch: isMatch);
    if (imageData == null) {
      return null;
    }

    try {
      final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(
        imageData,
      );
      await cacheManager.putFile("null", encryptedImgBytes, key: imgKey);
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
          final encryptedImgBytes = await fileInfo.file.readAsBytes();
          final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(
            encryptedImgBytes,
          );
          return decryptedImgBytes;
        } catch (_) {
          // Fallback to image downloading
        }
      }
    }

    final tileResult = await media.getMapTile(z, x, y);
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
        final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(
          tilePngData,
        );
        await cacheManager.putFile("null", encryptedImgBytes, key: mapTileCacheKey);
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
      final painter = CroppedImagePainter(frame.image, cropArea, 1.0);
      final srcRect = painter.calculateSrcRect();
      final dstRect = Rect.fromLTWH(0, 0, srcRect.width, srcRect.height);
      canvas.drawImageRect(frame.image, srcRect, dstRect, Paint());
      final image = await pictureRecorder.endRecording().toImage(
        srcRect.width.round(),
        srcRect.height.round(),
      );
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
    final key = AccountImgKey(
      accountId: accountId,
      contentId: contentId,
      cacheSize: cacheSize,
      cropArea: cropArea,
    );
    final imgProvider = AccountImageProvider._(key, isMatch: isMatch, media: media);
    return ResizeImage(
      imgProvider,
      width: cacheSize.width,
      height: cacheSize.height,
      allowUpscaling: false,
      policy: ResizeImagePolicy.fit,
    );
  }
}

class ImageCacheSize {
  final int? width;
  final int? height;
  ImageCacheSize._({this.width, this.height});

  factory ImageCacheSize.fullScreen(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._(
      width: (size.width * devicePixelRatio).round(),
      height: (size.height * devicePixelRatio).round(),
    );
  }

  factory ImageCacheSize._divideFullScreen(BuildContext context, int heightDivider) {
    final size = MediaQuery.sizeOf(context);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._(
      width: (size.width ~/ heightDivider * devicePixelRatio).round(),
      height: (size.height ~/ heightDivider * devicePixelRatio).round(),
    );
  }

  factory ImageCacheSize.halfScreen(BuildContext context) {
    return ImageCacheSize._divideFullScreen(context, 2);
  }

  factory ImageCacheSize.width(BuildContext context, double width) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._(width: (width * devicePixelRatio).round());
  }

  factory ImageCacheSize.height(BuildContext context, double height) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return ImageCacheSize._(height: (height * devicePixelRatio).round());
  }

  static ImageCacheSize sizeForAppBarThumbnail(BuildContext context) {
    return ImageCacheSize._divideFullScreen(context, 4);
  }

  static ImageCacheSize sizeForGrid(BuildContext context, double height) {
    return ImageCacheSize.height(context, height);
  }

  static ImageCacheSize sizeForListWithTextContent(BuildContext context, double height) {
    return ImageCacheSize.height(context, height);
  }

  @override
  bool operator ==(Object other) {
    return other is ImageCacheSize && other.width == width && other.height == height;
  }

  @override
  int get hashCode => Object.hash(width, height);
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
      cacheSize: ImageCacheSize.height(context, VIEW_PROFILE_WIDGET_IMG_HEIGHT),
      media: LoginRepository.getInstance().repositories.media,
      cropArea: null,
    );
    await precacheImage(imageProvider, context);
  }
}
