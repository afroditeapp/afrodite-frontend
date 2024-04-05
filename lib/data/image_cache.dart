import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/storage/encryption.dart';
import 'package:pihka_frontend/ui/normal/settings/location.dart';
import 'package:pihka_frontend/utils.dart';

import 'package:image/image.dart' as img;
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

  Future<XFile?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false}) async {
    if (kIsWeb) {
      throw UnsupportedError("getImage is not supported on web");
    }

    final fileInfo = await cacheManager.getFileFromCache(id.contentId);
    if (fileInfo != null) {
      // TODO: error handling?

      return XFile(fileInfo.file.path);
    }

    final imageData = await MediaRepository.getInstance().getImage(imageOwner, id, isMatch: isMatch);
    if (imageData == null) {
      return null;
    }

    final file = await cacheManager.putFile("null", imageData, key: id.contentId);
    return XFile(file.path);
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
