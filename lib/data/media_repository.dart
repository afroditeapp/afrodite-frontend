


import 'dart:async';

import 'package:camera/camera.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/account/initial_setup.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/media/send_to_slot.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/ui/normal/settings/media/retry_initial_setup_images.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/api.dart';
import 'package:pihka_frontend/utils/result.dart';

var log = Logger("MediaRepository");

class MediaRepository extends DataRepository {
  MediaRepository._private();
  static final _instance = MediaRepository._private();
  factory MediaRepository.getInstance() {
    return _instance;
  }

  final syncHandler = ConnectedActionScheduler();

  final ApiManager api = ApiManager.getInstance();
  final DatabaseManager db = DatabaseManager.getInstance();

  @override
  Future<void> init() async {
    // nothing to do
  }

  @override
  Future<void> onLogin() async {
    syncHandler.onLoginSync(() async {
      final r1 = await reloadMyProfileContent();
      final r2 = await reloadMySecurityContent();
      if (r1.isOk() && r2.isOk()) {
        await db.accountAction((db) => db.daoInitialSync.updateMediaSyncDone(true));
      }
    });
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final syncDone = await db.accountStreamSingle((db) => db.daoInitialSync.watchMediaSyncDone()).ok() ?? false;
      if (!syncDone) {
        final r1 = await reloadMyProfileContent();
        final r2 = await reloadMySecurityContent();
        if (r1.isOk() && r2.isOk()) {
          await db.accountAction((db) => db.daoInitialSync.updateProfileSyncDone(true));
        }
      }
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadMyProfileContent();
    await reloadMySecurityContent();
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
          ErrorManager.getInstance().show(e);
          return MapTileError();
        }
    }
  }

  Future<ModerationList> nextModerationListFromServer(ModerationQueueType queue) async {
    return await api.mediaAdmin((api) => api.patchModerationRequestList(queue)).ok() ?? ModerationList();
  }

  Future<void> handleModerationRequest(AccountId accountId, bool accept) async {
    await api.mediaAdminAction((api) => api.postHandleModerationRequest(accountId.accountId, HandleModerationRequest(accept: accept)));
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

  /// Reload current and pending profile content.
  Future<Result<void, void>> reloadMyProfileContent() async {
    final accountId = await LoginRepository.getInstance().accountId.first;
    if (accountId == null) {
      log.error("reloadMyProfileContent: accountId is null");
      return const Err(null);
    }

    final info = await api.media((api) => api.getProfileContentInfo(accountId.accountId, false)).ok();
    if (info == null) {
      return const Err(null);
    }

    final r1 = await db.accountAction((db) => db.daoCurrentContent.setApiProfileContent(content: info));
    if (r1.isErr()) {
      return const Err(null);
    }

    final pendingInfo = await api.media((api) => api.getPendingProfileContentInfo(accountId.accountId)).ok();
    if (pendingInfo == null) {
      return const Err(null);
    }

    return await db.accountAction((db) => db.daoPendingContent.setApiPendingProfileContent(pendingContent: pendingInfo));
  }

  /// Reload current and pending security content.
  Future<Result<void, void>> reloadMySecurityContent() async {
    final accountId = await LoginRepository.getInstance().accountId.first;
    if (accountId == null) {
      log.error("reloadMySecurityContent: accountId is null");
      return const Err(null);
    }

    final info = await api.media((api) => api.getSecurityContentInfo(accountId.accountId)).ok();
    if (info == null) {
      return const Err(null);
    }

    final r = await db.accountAction((db) => db.daoCurrentContent.setSecurityContent(securityContent: Value(info.contentId?.id)));
    if (r.isErr()) {
      return const Err(null);
    }

    final pendingInfo = await api.media((api) => api.getPendingSecurityContentInfo(accountId.accountId)).ok();
    if (pendingInfo == null) {
      return const Err(null);
    }

    return await db.accountAction((db) => db.daoPendingContent.setPendingSecurityContent(pendingSecurityContent: Value(pendingInfo.contentId?.id)));
  }

  /// Last event from stream is ProcessingCompleted or SendToSlotError.
  Stream<SendToSlotEvent> sendImageToSlot(XFile file, int slot, {bool secureCapture = false}) async* {
    final task = SendImageToSlotTask();
    yield* task.sendImageToSlot(file, slot, secureCapture: secureCapture);
  }

  Future<Result<ModerationRequest?, void>> currentModerationRequestState() =>
    api.media((api) => api.getModerationRequest())
      .mapOk((v) => v.request);

  Future<Result<void, void>> setProfileContent(SetProfileContent imgInfo) =>
    api.mediaAction((api) => api.putProfileContent(imgInfo))
      .onOk(() => reloadMyProfileContent());

  Future<Result<void, void>> setPendingProfileContent(SetProfileContent imgInfo) =>
    api.mediaAction((api) => api.putPendingProfileContent(imgInfo))
      .onOk(() => reloadMyProfileContent());

  Future<Result<AccountContent, void>> loadAllContent() async {
    final accountId = await LoginRepository.getInstance().accountId.first;
    if (accountId == null) {
      log.error("loadAllContent: accountId is null");
      return const Err(null);
    }
    return await api.media((api) => api.getAllAccountMediaContent(accountId.accountId));
  }

  Future<Result<void, void>> createNewModerationRequest(List<ContentId> content) async {
    final request = ModerationRequestContentExtensions.fromList(content);
    if (request == null) {
      log.error("createNewModerationRequest: request is null");
      return const Err(null);
    }

    return await api.mediaAction((api) => api.putModerationRequest(request));
  }

  Future<Result<void, void>> deleteCurrentModerationRequest() =>
    api.mediaAction((api) => api.deleteModerationRequest());

  Future<Result<void, void>> retryInitialSetupImages(RetryInitialSetupImages content) async {
    final result = await InitialSetupUtils().handleInitialSetupImages(content.securitySelfie, content.profileImgs);
    await reloadMyProfileContent();
    await reloadMySecurityContent();
    return result;
  }
}

sealed class MapTileResult {}

class MapTileSuccess extends MapTileResult {
  Uint8List pngData;
  MapTileSuccess(this.pngData);
}
class MapTileError extends MapTileResult {}
class MapTileNotAvailable extends MapTileResult {}
