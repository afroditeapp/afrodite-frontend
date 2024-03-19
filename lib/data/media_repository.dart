


import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/media/send_to_slot.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("MediaRepository");

class MediaRepository extends DataRepository {
  MediaRepository._private();
  static final _instance = MediaRepository._private();
  factory MediaRepository.getInstance() {
    return _instance;
  }

  final ApiManager api = ApiManager.getInstance();

  @override
  Future<void> init() async {
    // nothing to do
  }

  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false}) async {
    final data = await api.media((api) => api.getContentFixed(
      imageOwner.accountId,
      id.contentId,
      isMatch,
    )).ok();
    if (data != null) {
      return data;
    } else {
      log.error("Image loading error");
      return null;
    }
  }

  Future<ContentId?> getProfileImage(AccountId imageOwner, bool isMatch) async {
    final data = await api.media((api) => api.getProfileContentInfo(
      imageOwner.accountId,
      isMatch
    )).ok();
    if (data != null) {
      final contentId = data.contentId0;
      if (contentId == null) {
        log.error("Image loading error: no contentId0");
        return null;
      } else {
        return contentId.id;
      }
    } else {
      log.error("Image loading error");
      return null;
    }
  }

  Future<MapTileResult> getMapTile(int z, int x, int y) async {
    final data = await api.mediaWrapper().requestValue((api) => api.getMapTileFixed(
      z,
      x,
      y.toString(),
    ), logError: false);

    switch (data) {
      case Ok(:final v):
        return MapTileSuccess(v);
      case Err(:final e):
        if (e.isNotFoundError()) {
          // No map tile available
          return MapTileNotAvailable();
        } else {
          ErrorManager.getInstance().send(ApiError());
          return MapTileError();
        }
    }
  }

  Future<ModerationList> nextModerationListFromServer(ModerationQueueType queue) async {
    return await api.mediaAdmin((api) => api.patchModerationRequestList(queue)).ok() ?? ModerationList();
  }

  Future<void> handleModerationRequest(AccountId accountId, bool accept) async {
    await api.mediaAdmin((api) => api.postHandleModerationRequest(accountId.accountId, HandleModerationRequest(accept: accept)));
  }

  Future<ContentId?> getSecuritySelfie(AccountId account) async {
    final img = await api.media((api) => api.getSecurityContentInfo(account.accountId)).ok();
    return img?.contentId?.id;
  }

  Future<ContentId?> getPendingSecuritySelfie(AccountId account) async {
    final img = await api.media((api) => api.getPendingSecurityContentInfo(account.accountId)).ok();
    return img?.contentId?.id;
  }

  Future<ContentId?> getPrimaryImage(AccountId account, bool isMatch) async {
    final info = await api.media((api) => api.getProfileContentInfo(account.accountId, isMatch)).ok();
    return info?.contentId0?.id;
  }

  /// Last event from stream is ProcessingCompleted or SendToSlotError.
  Stream<SendToSlotEvent> sendImageToSlot(File file, int slot, {bool secureCapture = false}) async* {
    final task = SendImageToSlotTask();
    yield* task.sendImageToSlot(file, slot, secureCapture: secureCapture);
  }
}

sealed class MapTileResult {}

class MapTileSuccess extends MapTileResult {
  Uint8List pngData;
  MapTileSuccess(this.pngData);
}
class MapTileError extends MapTileResult {}
class MapTileNotAvailable extends MapTileResult {}
