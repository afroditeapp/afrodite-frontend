
import 'package:flutter/material.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

const MIBIBYTE = 1024 * 1024;
const CACHE_DEFAULT_BYTES = MIBIBYTE * 200;
const CACHE_MIN_BYTES = MIBIBYTE * 100;
const CACHE_MAX_BYTES = MIBIBYTE * 400;
const CACHE_FULL_SIZED_IMAGES_DEFAULT = true;
const CACHE_DOWNSCALING_SIZE_DEFAULT = MAX_IMG_WIDTH_AND_HEIGHT;


class ImageCacheSettings extends AppSingleton {
  static final _instance = ImageCacheSettings();
  ImageCacheSettings();
  factory ImageCacheSettings.getInstance() {
    return _instance;
  }

  final _imageCacheMaxBytes = BehaviorSubject<int>.seeded(CACHE_DEFAULT_BYTES);
  final _cacheFullSizedImages = BehaviorSubject<bool>.seeded(CACHE_FULL_SIZED_IMAGES_DEFAULT);
  final _cacheDownscalingSize = BehaviorSubject<int>.seeded(CACHE_DOWNSCALING_SIZE_DEFAULT);

  Stream<int> get imageCacheMaxBytes => _imageCacheMaxBytes.stream;
  Stream<bool> get cacheFullSizedImages => _cacheFullSizedImages.stream;
  Stream<int> get cacheDownscalingSize => _cacheDownscalingSize.stream;

  int get imageCacheMaxBytesValue => _imageCacheMaxBytes.value;
  bool get cacheFullSizedImagesValue => _cacheFullSizedImages.value;
  int get cacheDownscalingSizeValue => _cacheDownscalingSize.value;

  @override
  Future<void> init() async {
    DatabaseManager.getInstance()
      .accountStreamOrDefault(
        (db) => db.daoLocalImageSettings.watchLocalImageSettingImageCacheMaxBytes(),
        CACHE_DEFAULT_BYTES,
      )
      .listen((event) {
        if (event != imageCache.maximumSizeBytes) {
          imageCache.maximumSizeBytes = event;
        }
        _imageCacheMaxBytes.add(event);
      });

    DatabaseManager.getInstance()
      .accountStreamOrDefault(
        (db) => db.daoLocalImageSettings.watchCacheFullSizedImages(),
        CACHE_FULL_SIZED_IMAGES_DEFAULT,
      )
      .listen((event) {
        _cacheFullSizedImages.add(event);
      });

    DatabaseManager.getInstance()
      .accountStreamOrDefault(
        (db) => db.daoLocalImageSettings.watchImageCacheDownscalingSize(),
        CACHE_DOWNSCALING_SIZE_DEFAULT,
      )
      .listen((event) {
        _cacheDownscalingSize.add(event);
      });
  }

  ImageCacheSize getCurrentImageCacheSize() {
    if (_cacheFullSizedImages.value) {
      return ImageCacheSize.maxQuality;
    } else {
      return ImageCacheSize(_cacheDownscalingSize.value);
    }
  }

  Future<void> saveSettings(
    int maxBytes,
    bool cacheFullSizedImages,
    int downscalingSize,
  ) async {
    await DatabaseManager.getInstance().accountAction((db) async {
      await db.daoLocalImageSettings.updateImageCacheMaxBytes(maxBytes);
      await db.daoLocalImageSettings.updateCacheFullSizedImages(cacheFullSizedImages);
      await db.daoLocalImageSettings.updateImageCacheDownscalingSize(downscalingSize);
    });
  }
}
