


import 'dart:async';

import 'package:app/data/general/notification/state/media_content_moderation_completed.dart';
import 'package:app/data/general/notification/state/profile_text_moderation_completed.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/api/error_manager.dart';
import 'package:app/data/account/initial_setup.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/media/send_to_slot.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/ui/normal/settings/media/retry_initial_setup_images.dart';
import 'package:app/utils/option.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

var log = Logger("MediaRepository");

class MediaRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler syncHandler;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;

  final AccountRepository account;

  final AccountId currentUser;

  MediaRepository(this.account, this.db, this.accountBackgroundDb, ServerConnectionManager connectionManager, this.currentUser) :
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
  }

  @override
  Future<Result<void, void>> onLoginDataSync() async {
    return await reloadMyMediaContent()
      .andThen((_) => _reloadMediaNotificationSettings())
      .andThen((_) => db.accountAction((db) => db.daoInitialSync.updateMediaSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final syncDone = await db.accountStreamSingle((db) => db.daoInitialSync.watchMediaSyncDone()).ok() ?? false;
      if (!syncDone) {
        await reloadMyMediaContent()
          .andThen((_) => _reloadMediaNotificationSettings())
          .andThen((_) => db.accountAction((db) => db.daoInitialSync.updateMediaSyncDone(true)));
      }
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadMyMediaContent();
  }

  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false}) =>
    api.media((api) => api.getContentFixed(
      imageOwner.aid,
      id.cid,
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

  Future<ContentId?> getSecuritySelfie(AccountId account) =>
    api.media((api) => api.getSecurityContentInfo(account.aid))
      .ok()
      .map((img) => img.c?.cid);

  /// Reload current profile and security content.
  Future<Result<void, void>> reloadMyMediaContent() async {
    final infoResult = await api.media((api) => api.getMediaContentInfo()).ok();
    if (infoResult == null) {
      return const Err(null);
    }

    return await db.accountAction((db) => db.daoCurrentContent.setMediaContent(info: infoResult));
  }

  /// Last event from stream is ProcessingCompleted or SendToSlotError.
  Stream<SendToSlotEvent> sendImageToSlot(Uint8List imgBytes, int slot, {bool secureCapture = false}) async* {
    final task = SendImageToSlotTask(account, api);
    yield* task.sendImageToSlot(imgBytes, slot, secureCapture: secureCapture);
  }

  Future<void> handleMediaContentModerationCompletedEvent() async {
    final notification = await api.media((api) => api.postGetMediaContentModerationCompletedNotification()).ok();

    if (notification == null) {
      return;
    }

    await NotificationMediaContentModerationCompleted.handleMediaContentModerationCompleted(notification, accountBackgroundDb);

    await api.mediaAction((api) => api.postMarkMediaContentModerationCompletedNotificationViewed(
      MediaContentModerationCompletedNotificationViewed(accepted: notification.accepted, rejected: notification.rejected),
    )).ok();
  }

  Future<void> handleProfileTextModerationCompletedEvent() async {
    final notification = await api.profile((api) => api.postGetProfileTextModerationCompletedNotification()).ok();

    if (notification == null) {
      return;
    }

    await NotificationProfileTextModerationCompleted.handleProfileTextModerationCompleted(notification, accountBackgroundDb);

    await api.profileAction((api) => api.postMarkProfileTextModerationCompletedNotificationViewed(
      ProfileTextModerationCompletedNotificationViewed(accepted: notification.accepted, rejected: notification.rejected),
    )).ok();
  }

  Future<Result<void, void>> setProfileContent(SetProfileContent imgInfo) =>
    api.mediaAction((api) => api.putProfileContent(imgInfo))
      .onOk(() => reloadMyMediaContent());

  Future<Result<AccountContent, void>> loadAllContent() =>
    api.media((api) => api.getAllAccountMediaContent(currentUser.aid));

  Future<Result<void, void>> retryInitialSetupImages(RetryInitialSetupImages content) async {
    final result = await InitialSetupUtils(api).handleInitialSetupImages(content.securitySelfie, content.profileImgs);
    await reloadMyMediaContent();
    return result;
  }

  Future<Result<void, void>> _reloadMediaNotificationSettings() async {
    return await api.media((api) => api.getMediaAppNotificationSettings())
      .andThen((v) => accountBackgroundDb.accountAction(
        (db) => db.daoLocalNotificationSettings.updateMediaNotificationSettings(v),
      ));
  }
}

sealed class MapTileResult {}

class MapTileSuccess extends MapTileResult {
  Uint8List pngData;
  MapTileSuccess(this.pngData);
}
class MapTileError extends MapTileResult {}
class MapTileNotAvailable extends MapTileResult {}
