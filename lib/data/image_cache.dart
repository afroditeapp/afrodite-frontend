import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/storage/encryption.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:utils/utils.dart';

import 'package:image/image.dart' as img;
import 'package:app/model/freezed/utils/account_img_key.dart';

var log = Logger("ImageCacheData");

class ImageCacheData extends AppSingleton {
  ImageCacheData._private(): cacheManager = CacheManager(
    Config(
      "image_cache",
      stalePeriod: const Duration(days: 90),
      // Images are about 100 KiB each, so 10 000 images is about 1 GiB
      maxNrOfCacheObjects: 10000,
    )
  );
  static final _instance = ImageCacheData._private();
  factory ImageCacheData.getInstance() {
    return _instance;
  }

  final CacheManager cacheManager;

  /// Get image bytes for profile picture.
  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false, required MediaRepository media}) async {
    if (kIsWeb) {
      // Web uses XMLHttpRequest for caching
      return await media.getImage(imageOwner, id, isMatch: isMatch);
    }
    final imgKey = "img:${imageOwner.aid}${id.cid}";
    final fileInfo = await cacheManager.getFileFromCache(imgKey);
    if (fileInfo != null) {
      try {
        final encryptedImgBytes = await fileInfo.file.readAsBytes();
        final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(encryptedImgBytes);
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
      final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(imageData);
      await cacheManager.putFile("null", encryptedImgBytes, key: imgKey);
    } catch (_) {
      // Ignore errors
    }
    return imageData;
  }

  /// Get PNG file bytes for map tile.
  Future<Uint8List?> getMapTile(int z, int x, int y, int version, {required MediaRepository media}) async {
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
          final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(encryptedImgBytes);
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
        final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(tilePngData);
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
    pixel..r = MAP_BACKGROUND_COLOR.r
        ..g = MAP_BACKGROUND_COLOR.g
        ..b = MAP_BACKGROUND_COLOR.b
        ..a = 255;
  }

  return img.encodePng(imageBuffer);
}

// Use only ContentId as key for image cache as that is most likely
// faster than using both AccountId and ContentId. Also all images
// have unique ContentId.
class AccountImageProvider extends ImageProvider<ContentId> {
  final AccountImgKey imgInfo;
  final bool isMatch;
  final MediaRepository media;

  AccountImageProvider._(this.imgInfo, {this.isMatch = false, required this.media});

  @override
  ImageStreamCompleter loadImage(ContentId key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      () async {
        final imgBytes =
          await ImageCacheData.getInstance().getImage(imgInfo.accountId, imgInfo.contentId, isMatch: isMatch, media: media);

        if (imgBytes == null) {
          return Future<ImageInfo>.error("Failed to load the image");
        }

        final buffer = await ImmutableBuffer.fromUint8List(imgBytes);
        final codec = await decode(buffer);
        final frame = await codec.getNextFrame();

        return ImageInfo(image: frame.image);
      }(),
    );
  }

  @override
  Future<ContentId> obtainKey(ImageConfiguration configuration) =>
    SynchronousFuture(imgInfo.contentId);

  static ImageProvider<Object> create(
    AccountId accountId,
    ContentId contentId,
    {
      bool isMatch = false,
      ImageCacheSize sizeSetting = ImageCacheSize.maxQuality,
      required MediaRepository media,
    }
  ) {
    final key = AccountImgKey(accountId: accountId, contentId: contentId);
    final imgProvider = AccountImageProvider._(key, isMatch: isMatch, media: media);
    if (sizeSetting == ImageCacheSize.maxQuality) {
      return imgProvider;
    } else {
      final size = sizeSetting.maxSize;
      return ResizeImage(
        imgProvider,
        width: size,
        height: size,
        allowUpscaling: false,
        policy: ResizeImagePolicy.fit,
      );
    }
  }
}

const MAX_IMG_WIDTH_AND_HEIGHT = 1920;

enum ImageCacheSizeSetting {
  /// Downscale to 1/4 of the max image size (Full HD)
  tiny,
  /// Downscale to 1/3 of the max image size (Full HD)
  low,
  /// Downscale to 1/2 of the max image size (Full HD)
  medium,
  /// Downscale to 1/1.5 of the max image size (Full HD)
  high,
  /// No downscaling
  maxQuality;

  ImageCacheSize getImgSize() {
    final size = switch (this) {
      ImageCacheSizeSetting.tiny =>
        MAX_IMG_WIDTH_AND_HEIGHT ~/ 4,
      ImageCacheSizeSetting.low =>
        MAX_IMG_WIDTH_AND_HEIGHT ~/ 3,
      ImageCacheSizeSetting.medium =>
        MAX_IMG_WIDTH_AND_HEIGHT ~/ 2,
      ImageCacheSizeSetting.high =>
        MAX_IMG_WIDTH_AND_HEIGHT ~/ 1.5,
      ImageCacheSizeSetting.maxQuality =>
        MAX_IMG_WIDTH_AND_HEIGHT,
    };

    return ImageCacheSize(size);
  }
}

class ImageCacheSize {
  final int maxSize;
  const ImageCacheSize(this.maxSize);

  static const ImageCacheSize maxQuality = ImageCacheSize(MAX_IMG_WIDTH_AND_HEIGHT);

  static ImageCacheSize sizeForAppBarThumbnail() {
    return LoginRepository.getInstance().repositoriesOrNull?.imageCacheSettings.getCurrentImageCacheSize() ?? maxQuality;
  }

  static ImageCacheSize sizeForGrid() {
    return LoginRepository.getInstance().repositoriesOrNull?.imageCacheSettings.getCurrentImageCacheSize() ?? maxQuality;
  }

  static ImageCacheSize sizeForListWithTextContent() {
    return LoginRepository.getInstance().repositoriesOrNull?.imageCacheSettings.getCurrentImageCacheSize() ?? maxQuality;
  }

  static ImageCacheSize sizeForViewProfile() {
    return LoginRepository.getInstance().repositoriesOrNull?.imageCacheSettings.getCurrentImageCacheSize() ?? maxQuality;
  }
}
