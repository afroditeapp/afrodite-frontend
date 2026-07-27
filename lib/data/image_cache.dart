import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:app/data/general_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/crop_image_screen.dart';
import 'package:app/ui_utils/profile_thumbnail_image.dart';
import 'package:app/utils/api.dart';
import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/data/media_repository.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:utils/utils.dart';

import 'package:image/image.dart' as img;
import 'package:app/model/freezed/utils/account_img_key.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/localizations.dart';

class ImageCacheData extends AppSingleton {
  ImageCacheData._private()
    : cacheManager = GeneralCacheManager(
        // Images are about 100 KiB each on high quality, so 10 000 images is about 1 GiB
        maxNrOfCacheObjects: 10000,
      );
  static final _instance = ImageCacheData._private();
  factory ImageCacheData.getInstance() {
    return _instance;
  }

  final GeneralCacheManager cacheManager;

  /// 1 hour cooldown for showing image quality degraded snackbar.
  static const _degradedQualitySnackbarCooldown = Duration(hours: 1);

  UtcDateTime? _lastDegradedQualitySnackbarTime;

  /// Get image bytes for profile picture.
  Future<Uint8List?> getImage(
    AccountId imageOwner,
    ContentId id, {
    bool isMatch = false,
    required MediaRepository media,
  }) async {
    final userPreferredQualityResult = await media.db.accountData(
      (r) => r.app.getUserPreferredContentQuality(),
    );
    final userPreferredQuality =
        userPreferredQualityResult.ok()?.quality ?? ContentQualityVariant.default_.value;

    final r = await _getImageWithQuality(
      imageOwner,
      id,
      isMatch: isMatch,
      preferredQuality: userPreferredQuality,
      media: media,
    );
    return r;
  }

  /// Check if received quality is lower than requested and show snackbar.
  void _checkShowDegradedQualitySnackbar(int requestedQuality, String receivedQuality) {
    if (_qualityIsDegraded(requestedQuality, receivedQuality)) {
      final now = UtcDateTime.now();
      final last = _lastDegradedQualitySnackbarTime;
      if (last == null || now.difference(last) >= _degradedQualitySnackbarCooldown) {
        _lastDegradedQualitySnackbarTime = now;
        showSnackBar(R.strings.snackbar_image_quality_degraded);
      }
    }
  }

  /// Returns true if [received] is lower quality than [requested].
  /// Lower int value is lower quality
  bool _qualityIsDegraded(int requested, String received) {
    final receivedValue = int.tryParse(received);
    if (receivedValue == null) return true;
    return receivedValue < requested;
  }

  Future<Uint8List?> _getImageWithQuality(
    AccountId imageOwner,
    ContentId id, {
    bool isMatch = false,
    required int preferredQuality,
    required MediaRepository media,
  }) async {
    if (kIsWeb) {
      // Web uses XMLHttpRequest for caching
      final result = await media.getImage(
        imageOwner,
        id,
        isMatch: isMatch,
        preferredQuality: preferredQuality.toString(),
      );
      if (result case ContentQualityData(:final etag) || ContentQualityNotModified(:final etag)) {
        _checkShowDegradedQualitySnackbar(preferredQuality, etag);
      }
      return switch (result) {
        ContentQualityData(:final data) => data,
        ContentQualityNotModified(:final data) => data,
        _ => null,
      };
    }
    final imgKey = "img:${imageOwner.aid}${id.cid}:q$preferredQuality";
    final fileInfo = await cacheManager.getFileFromCache(imgKey);
    if (fileInfo != null && fileInfo.isFresh) {
      // Still fresh, return cached data
      return fileInfo.data;
    }

    final result = await media.getImage(
      imageOwner,
      id,
      isMatch: isMatch,
      preferredQuality: preferredQuality.toString(),
      ifNoneMatch: fileInfo?.etag,
    );
    if (result != null) {
      switch (result) {
        case ContentQualityNotModified(:final etag, :final cacheControlMaxAge):
          _checkShowDegradedQualitySnackbar(preferredQuality, etag);
          await cacheManager.renewTimestamps(imgKey, cacheControlMaxAge: cacheControlMaxAge);
          return fileInfo?.data;
        case ContentQualityData(:final data, :final etag, :final cacheControlMaxAge):
          _checkShowDegradedQualitySnackbar(preferredQuality, etag);
          if (data.isEmpty) {
            return null;
          }
          try {
            await cacheManager.putFile(
              data,
              key: imgKey,
              etag: etag,
              cacheControlMaxAge: cacheControlMaxAge,
            );
          } catch (_) {
            // Ignore errors
          }
          return result.data;
      }
    } else {
      return null;
    }
  }

  /// Get PNG file bytes for map tile.
  Future<Uint8List?> getMapTile(
    int z,
    int x,
    int y,
    int version, {
    required MediaRepository media,
  }) async {
    if (kIsWeb) {
      // Web uses XMLHttpRequest for caching
      final tileResult = await media.getMapTile(z, x, y, version);
      switch (tileResult) {
        case MapTileSuccess(:final pngData):
          return pngData;
        case MapTileNotAvailable():
          return _cachedEmptyMapTile();
        case MapTileError():
          return null;
        case MapTileNotModified(:final data):
          return data;
      }
    }

    final key = createMapTileKey(z, x, y, version);
    final fileInfo = await cacheManager.getFileFromCache(key);
    if (fileInfo != null && fileInfo.isFresh) {
      return fileInfo.data;
    }

    final tileResult = await media.getMapTile(z, x, y, version, ifNoneMatch: fileInfo?.etag);
    switch (tileResult) {
      case MapTileNotModified(:final cacheControlMaxAge):
        await cacheManager.renewTimestamps(key, cacheControlMaxAge: cacheControlMaxAge);
        return fileInfo?.data;
      case MapTileSuccess(:final pngData, :final etag, :final cacheControlMaxAge):
        try {
          if (pngData.isEmpty) {
            return null;
          }
          await cacheManager.putFile(
            pngData,
            key: key,
            etag: etag,
            cacheControlMaxAge: cacheControlMaxAge,
          );
          return pngData;
        } catch (_) {
          // Ignore errors
          return pngData;
        }
      case MapTileNotAvailable():
        return _cachedEmptyMapTile();
      case MapTileError():
        return fileInfo?.data;
    }
  }

  @override
  Future<void> init() async {
    await cacheManager.init();
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

    final config = context.read<ClientFeaturesConfigBloc>().state.config;
    final requireFace = config.profile?.firstImage?.requireFaceDetectedWhenViewing ?? false;

    if (first != null && (!requireFace || first.faceDetected) && first.accepted) {
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
