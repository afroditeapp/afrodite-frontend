


import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

var log = Logger("MediaRepository");

class MediaRepository extends AppSingleton {
  MediaRepository._private();
  static final _instance = MediaRepository._private();
  factory MediaRepository.getInstance() {
    return _instance;
  }

  @override
  Future<void> init() async {
    // nothing to do
  }

  final ApiManager api = ApiManager.getInstance();

  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id) async {
    final data = await api.media((api) => api.getImageFixed(
      imageOwner.accountId,
      id.contentId,
      false
    ));
    if (data != null) {
      return data;
    } else {
      log.error("Image loading error");
      return null;
    }
  }

  Future<ContentId?> getProfileImage(AccountId imageOwner, bool isMatch) async {
    final data = await api.media((api) => api.getPrimaryImageInfo(
      imageOwner.accountId,
      isMatch
    ));
    if (data != null) {
      return data.contentId;
    } else {
      log.error("Image loading error");
      return null;
    }
  }

  Future<MapTileResult> getMapTile(int z, int x, int y) async {
    try {
      final data = await api.mediaWrapper().requestWithException(false, (api) => api.getMapTileFixed(
        z,
        x,
        y.toString(),
      ));
      if (data != null) {
        return MapTileSuccess(data);
      } else {
        log.error("Map tile loading error: request successfull, but no tile data");
        ErrorManager.getInstance().send(ApiError());
        return MapTileError();
      }
    } on ApiException catch (e) {
      if (e.code == 404) {
        // No map tile available
        return MapTileNotAvailable();
      } else {
        log.error(e);
        ErrorManager.getInstance().send(ApiError());
        return MapTileError();
      }
    }
  }

  Future<ModerationList> nextModerationListFromServer() async {
    return await api.mediaAdmin((api) => api.patchModerationRequestList()) ?? ModerationList();
  }

  Future<void> handleModerationRequest(AccountId accountId, bool accept) async {
    await api.mediaAdmin((api) => api.postHandleModerationRequest(accountId.accountId, HandleModerationRequest(accept: accept)));
  }

  Future<ContentId?> getSecuritySelfie(AccountId account) async {
    final img = await api.mediaAdmin((api) => api.getSecurityImageInfo(account.accountId));
    return img?.contentId;
  }

  Future<PrimaryImage?> getPrimaryImage(AccountId account, bool isMatch) async {
    return await api.media((api) => api.getPrimaryImageInfo(account.accountId, isMatch));
  }
}

sealed class MapTileResult {}

class MapTileSuccess extends MapTileResult {
  Uint8List pngData;
  MapTileSuccess(this.pngData);
}
class MapTileError extends MapTileResult {}
class MapTileNotAvailable extends MapTileResult {}
