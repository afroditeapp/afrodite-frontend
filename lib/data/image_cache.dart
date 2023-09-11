




import 'dart:io';
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


  Future<File?> getImage(AccountId imageOwner, ContentId id) async {
    final fileInfo = await cacheManager.getFileFromCache(id.contentId);
    if (fileInfo != null) {
      // TODO: error handling?
      return fileInfo.file;
    }

    final imageData = await MediaRepository.getInstance().getImage(imageOwner, id);
    if (imageData == null) {
      return null;
    }

    return await cacheManager.putFile("null", imageData, key: id.contentId);
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}
