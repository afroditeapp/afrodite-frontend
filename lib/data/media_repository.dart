


import 'dart:async';

import 'package:async/async.dart' show StreamExtensions;
import 'package:camera/camera.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/error_manager.dart';
import 'package:pihka_frontend/data/account/initial_setup.dart';
import 'package:pihka_frontend/data/account_repository.dart';
import 'package:pihka_frontend/data/media/send_to_slot.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:pihka_frontend/database/account_database_manager.dart';
import 'package:pihka_frontend/ui/normal/settings/media/retry_initial_setup_images.dart';
import 'package:pihka_frontend/utils/api.dart';
import 'package:pihka_frontend/utils/app_error.dart';
import 'package:pihka_frontend/utils/option.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:utils/utils.dart';

var log = Logger("MediaRepository");

class MediaRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler syncHandler;
  final ApiManager api;
  final AccountDatabaseManager db;

  final AccountRepository account;

  final AccountId currentUser;

  MediaRepository(this.account, this.db, ServerConnectionManager connectionManager, this.currentUser) :
    syncHandler = ConnectedActionScheduler(connectionManager),
    api = connectionManager.api;

  @override
  Future<void> init() async {
    // nothing to do
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
  }

  @override
  Future<void> onLogin() async {
    await db.accountAction((db) => db.daoInitialSync.updateMediaSyncDone(false));

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
          await db.accountAction((db) => db.daoInitialSync.updateMediaSyncDone(true));
        }
      }
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadMyProfileContent();
    await reloadMySecurityContent();
  }

  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false}) =>
    api.media((api) => api.getContentFixed(
      imageOwner.accountId,
      id.contentId,
      isMatch,
    ))
    .onErr(() => log.error("Image loading error"))
    .ok();

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

  Future<ModerationList> nextModerationListFromServer(ModerationQueueType queue) async =>
    await api.mediaAdmin((api) => api.patchModerationRequestList(queue)).ok() ?? ModerationList();

  Future<void> handleModerationRequest(AccountId accountId, bool accept) =>
    api.mediaAdminAction((api) => api.postHandleModerationRequest(
      accountId.accountId,
      HandleModerationRequest(accept: accept))
    );

  Future<ContentId?> getSecuritySelfie(AccountId account) =>
    api.media((api) => api.getSecurityContentInfo(account.accountId))
      .ok()
      .map((img) => img.contentId?.id);

  Future<ContentId?> getPendingSecuritySelfie(AccountId account) =>
    api.media((api) => api.getPendingSecurityContentInfo(account.accountId))
      .ok()
      .map((img) => img.contentId?.id);

  /// Reload current and pending profile content.
  Future<Result<void, void>> reloadMyProfileContent() async {
    final infoResult = await api.media((api) => api.getProfileContentInfo(currentUser.accountId, isMatch: false)).ok();
    final info = infoResult?.content;
    final version = infoResult?.version;
    if (info == null || version == null) {
      return const Err(null);
    }

    final r1 = await db.accountAction((db) => db.daoCurrentContent.setApiProfileContent(content: info, version: version));
    if (r1.isErr()) {
      return const Err(null);
    }

    final pendingInfo = await api.media((api) => api.getPendingProfileContentInfo(currentUser.accountId)).ok();
    if (pendingInfo == null) {
      return const Err(null);
    }

    return await db.accountAction((db) => db.daoPendingContent.setApiPendingProfileContent(pendingContent: pendingInfo));
  }

  /// Reload current and pending security content.
  Future<Result<void, void>> reloadMySecurityContent() async {
    final info = await api.media((api) => api.getSecurityContentInfo(currentUser.accountId)).ok();
    if (info == null) {
      return const Err(null);
    }

    final r = await db.accountAction((db) => db.daoCurrentContent.setSecurityContent(securityContent: Value(info.contentId?.id)));
    if (r.isErr()) {
      return const Err(null);
    }

    final pendingInfo = await api.media((api) => api.getPendingSecurityContentInfo(currentUser.accountId)).ok();
    if (pendingInfo == null) {
      return const Err(null);
    }

    return await db.accountAction((db) => db.daoPendingContent.setPendingSecurityContent(pendingSecurityContent: Value(pendingInfo.contentId?.id)));
  }

  /// Last event from stream is ProcessingCompleted or SendToSlotError.
  Stream<SendToSlotEvent> sendImageToSlot(XFile file, int slot, {bool secureCapture = false}) async* {
    final task = SendImageToSlotTask(account, api);
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

  Future<Result<AccountContent, void>> loadAllContent() =>
    api.media((api) => api.getAllAccountMediaContent(currentUser.accountId));

  Future<Result<void, void>> createNewModerationRequest(List<ContentId> content) =>
    Future.value(ModerationRequestContentExtensions.fromList(content))
      .okOr(const MissingValue())
      .inspectErr((e) => e.logError(log))
      .andThen((r) => api.mediaAction((api) => api.putModerationRequest(r)));

  Future<Result<void, void>> deleteCurrentModerationRequest() =>
    api.mediaAction((api) => api.deleteModerationRequest());

  Future<Result<void, void>> retryInitialSetupImages(RetryInitialSetupImages content) async {
    final result = await InitialSetupUtils(api).handleInitialSetupImages(content.securitySelfie, content.profileImgs);
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
