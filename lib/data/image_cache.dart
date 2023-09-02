




import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/media_repository.dart';
import 'package:pihka_frontend/ui/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';


class ImageCacheData extends AppSingleton {
  ImageCacheData._private(): cacheManager = CacheManager(
    Config(
      "imageCache",
      stalePeriod: Duration(days: 30),
      maxNrOfCacheObjects: 2000,
    )
  );
  static final _instance = ImageCacheData._private();
  factory ImageCacheData.getInstance() {
    return _instance;
  }

  final CacheManager cacheManager;


  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id) async {
    final fileInfo = await cacheManager.getFileFromCache(id.contentId);
    if (fileInfo != null) {
      // TODO: error handling?
      final fileBytes = await fileInfo.file.readAsBytes();
      return fileBytes;
    }

    final imageData = await MediaRepository.getInstance().getImage(imageOwner, id);
    if (imageData == null) {
      return null;
    }

    await cacheManager.putFile("null", imageData, key: id.contentId);

    return imageData;
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}
