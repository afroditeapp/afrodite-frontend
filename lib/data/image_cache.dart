import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/storage/encryption.dart';
import 'package:pihka_frontend/ui/normal/settings/location.dart';
import 'package:pihka_frontend/utils.dart';

import 'package:image/image.dart' as img;
import 'package:pihka_frontend/model/freezed/utils/account_img_key.dart';
import 'package:pihka_frontend/utils/tmp_dir.dart';

var log = Logger("ImageCacheData");

class ImageCacheData extends AppSingleton {
  ImageCacheData._private(): cacheManager = CacheManager(
    Config(
      "imageCache",
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 2000,
    )
  );
  static final _instance = ImageCacheData._private();
  factory ImageCacheData.getInstance() {
    return _instance;
  }

  final CacheManager cacheManager;

  /// Get image bytes for profile picture.
  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false}) async {
    if (kIsWeb) {
      throw UnsupportedError("getImage is not supported on web");
    }

    final fileInfo = await cacheManager.getFileFromCache(id.contentId);
    if (fileInfo != null) {
      // TODO: error handling?

      final encryptedImgBytes = await fileInfo.file.readAsBytes();
      final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(encryptedImgBytes);
      return decryptedImgBytes;
    }

    final imageData = await MediaRepository.getInstance().getImage(imageOwner, id, isMatch: isMatch);
    if (imageData == null) {
      return null;
    }

    final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(imageData);
    await cacheManager.putFile("null", encryptedImgBytes, key: id.contentId);
    return imageData;
  }

  /// Get PNG file bytes for map tile.
  Future<Uint8List?> getMapTile(int z, int x, int y) async {
    final key = createMapTileKey(z, x, y);
    final fileInfo = await cacheManager.getFileFromCache(key);
    if (fileInfo != null) {
      // TODO: error handling?
      final encryptedImgBytes = await fileInfo.file.readAsBytes();
      final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(encryptedImgBytes);
      return decryptedImgBytes;
    }

    final tileResult = await MediaRepository.getInstance().getMapTile(z, x, y);
    switch (tileResult) {
      case MapTileSuccess tileResult:
        final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(tileResult.pngData);
        await cacheManager.putFile("null", encryptedImgBytes, key: key);
        return tileResult.pngData;
      case MapTileNotAvailable():
        return await emptyMapTile();
      case MapTileError():
        return null;
    }
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}

String createMapTileKey(int z, int x, int y) {
  return "map_tile_${z}_${x}_$y";
}

Future<Uint8List?> emptyMapTile() async {
  final imgFile = await TmpDirUtils.emptyMapTileFilePath();
  if (await imgFile.exists()) {
    final encryptedImgBytes = await imgFile.readAsBytes();
    final decryptedImgBytes = await ImageEncryptionManager.getInstance().decryptImageData(encryptedImgBytes);
    return decryptedImgBytes;
  }

  final imageBuffer = img.Image(width: 1, height: 1);

  for (var pixel in imageBuffer) {
    pixel..r = MAP_BACKGROUND_COLOR.red
        ..g = MAP_BACKGROUND_COLOR.green
        ..b = MAP_BACKGROUND_COLOR.blue
        ..a = 255;
  }

  final pngBytes = img.encodePng(imageBuffer);
  final encryptedImgBytes = await ImageEncryptionManager.getInstance().encryptImageData(pngBytes);

  try {
    await imgFile.writeAsBytes(encryptedImgBytes.toList());
    return pngBytes;
  } on IOException catch (e) {
    log.error(e);
    ErrorManager.getInstance().send(FileError());
    return null;
  }
}

// Use only ContentId as key for image cache as that is most likely
// faster than using both AccountId and ContentId. Also all images
// have unique ContentId.
class AccountImageProvider extends ImageProvider<ContentId> {
  final AccountImgKey imgInfo;
  final bool isMatch;

  AccountImageProvider(this.imgInfo, {this.isMatch = false});

  @override
  ImageStreamCompleter loadImage(ContentId key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(
      () async {
        final imgBytes =
          await ImageCacheData.getInstance().getImage(imgInfo.accountId, imgInfo.contentId, isMatch: isMatch);

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
}
