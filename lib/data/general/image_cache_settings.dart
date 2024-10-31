
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:rxdart/rxdart.dart';

const MIBIBYTE = 1024 * 1024;
const CACHE_DEFAULT_BYTES = MIBIBYTE * 200;
const CACHE_MIN_BYTES = MIBIBYTE * 100;
const CACHE_MAX_BYTES = MIBIBYTE * 400;
const CACHE_FULL_SIZED_IMAGES_DEFAULT = true;
const CACHE_DOWNSCALING_SIZE_DEFAULT = MAX_IMG_WIDTH_AND_HEIGHT;


class ImageCacheSettings implements LifecycleMethods {
  final AccountDatabaseManager db;

  ImageCacheSettings(this.db);

  final _imageCacheMaxBytes = BehaviorSubject<int>.seeded(CACHE_DEFAULT_BYTES);
  final _cacheFullSizedImages = BehaviorSubject<bool>.seeded(CACHE_FULL_SIZED_IMAGES_DEFAULT);
  final _cacheDownscalingSize = BehaviorSubject<int>.seeded(CACHE_DOWNSCALING_SIZE_DEFAULT);

  Stream<int> get imageCacheMaxBytes => _imageCacheMaxBytes.stream;
  Stream<bool> get cacheFullSizedImages => _cacheFullSizedImages.stream;
  Stream<int> get cacheDownscalingSize => _cacheDownscalingSize.stream;

  int get imageCacheMaxBytesValue => _imageCacheMaxBytes.value;
  bool get cacheFullSizedImagesValue => _cacheFullSizedImages.value;
  int get cacheDownscalingSizeValue => _cacheDownscalingSize.value;

  StreamSubscription<int>? _imageCacheMaxBytesSubscription;
  StreamSubscription<bool>? _cacheFullSizedImagesSubscription;
  StreamSubscription<int>? _cacheDownscalingValueSubscription;

  @override
  Future<void> init() async {
    _imageCacheMaxBytesSubscription = db
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

    _cacheFullSizedImagesSubscription = db
      .accountStreamOrDefault(
        (db) => db.daoLocalImageSettings.watchCacheFullSizedImages(),
        CACHE_FULL_SIZED_IMAGES_DEFAULT,
      )
      .listen((event) {
        _cacheFullSizedImages.add(event);
      });

    _cacheDownscalingValueSubscription = db
      .accountStreamOrDefault(
        (db) => db.daoLocalImageSettings.watchImageCacheDownscalingSize(),
        CACHE_DOWNSCALING_SIZE_DEFAULT,
      )
      .listen((event) {
        _cacheDownscalingSize.add(event);
      });
  }

  @override
  Future<void> dispose() async {
    await _imageCacheMaxBytesSubscription?.cancel();
    await _cacheFullSizedImagesSubscription?.cancel();
    await _cacheDownscalingValueSubscription?.cancel();
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
    // Clear image cache
    final currentMaxBytes = imageCache.maximumSizeBytes;
    imageCache.maximumSizeBytes = 0;
    imageCache.maximumSizeBytes = currentMaxBytes;

    await db.accountAction((db) async {
      await db.daoLocalImageSettings.updateImageCacheMaxBytes(maxBytes);
      await db.daoLocalImageSettings.updateCacheFullSizedImages(cacheFullSizedImages);
      await db.daoLocalImageSettings.updateImageCacheDownscalingSize(downscalingSize);
    });
  }
}
