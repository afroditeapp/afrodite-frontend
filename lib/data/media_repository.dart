import 'dart:async';

import 'package:app/data/general/notification/state/media_content_moderation_completed.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/utils/api.dart';
import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/account/initial_setup.dart';
import 'package:app/data/account_repository.dart';
import 'package:app/data/media/send_to_slot.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/ui/normal/settings/media/retry_initial_setup_images.dart';
import 'package:app/utils/option.dart';
import 'package:app/utils/result.dart';
import 'package:utils/utils.dart';

final _log = Logger("MediaRepository");

class MediaRepository extends DataRepositoryWithLifecycle {
  final ConnectedActionScheduler syncHandler;
  final ApiManager api;
  final AccountDatabaseManager db;
  final AccountBackgroundDatabaseManager accountBackgroundDb;

  final AccountRepository account;

  final AccountId currentUser;

  MediaRepository(
    this.account,
    this.db,
    this.accountBackgroundDb,
    ServerConnectionManager connectionManager,
    this.currentUser,
  ) : syncHandler = ConnectedActionScheduler(connectionManager),
      api = connectionManager;

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
    await db.accountAction((db) => db.app.updateMediaSyncDone(false));
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    return await reloadMyMediaContent()
        .andThen((_) => _reloadMediaNotificationSettings())
        .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateMediaSyncDone(true)));
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      final syncDone =
          await db.accountStreamSingle((db) => db.app.watchMediaSyncDone()).ok() ?? false;
      if (!syncDone) {
        await reloadMyMediaContent()
            .andThen((_) => _reloadMediaNotificationSettings())
            .andThenEmptyErr((_) => db.accountAction((db) => db.app.updateMediaSyncDone(true)));
      }
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await reloadMyMediaContent();
  }

  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id, {bool isMatch = false}) => api
      .media((api) => api.getContentFixed(imageOwner.aid, id.cid, isMatch))
      .onErr(() => _log.error("Image loading error"))
      .ok();

  Future<MapTileResult> getMapTile(int z, int x, int y) async {
    final data = await api.mediaWrapper().requestValue(
      (api) => api.getMapTileFixed(z, x, y.toString()),
      logError: false,
    );

    switch (data) {
      case Ok(:final v):
        return MapTileSuccess(v);
      case Err(:final e):
        if (e.isNotFoundError()) {
          // No map tile available
          return MapTileNotAvailable();
        } else {
          return MapTileError();
        }
    }
  }

  Future<ContentId?> getSecuritySelfie(AccountId account) =>
      api.media((api) => api.getSecurityContentInfo(account.aid)).ok().map((img) => img.c?.cid);

  /// Reload current profile and security content.
  Future<Result<(), ()>> reloadMyMediaContent() async {
    final infoResult = await api.media((api) => api.getMediaContentInfo()).ok();
    if (infoResult == null) {
      return const Err(());
    }

    return await db
        .accountAction((db) => db.myMedia.setMyMediaContent(info: infoResult))
        .emptyErr();
  }

  /// Last event from stream is ProcessingCompleted or SendToSlotError.
  Stream<SendToSlotEvent> sendImageToSlot(
    Uint8List imgBytes,
    int slot, {
    bool secureCapture = false,
  }) async* {
    final task = SendImageToSlotTask(account, api);
    yield* task.sendImageToSlot(imgBytes, slot, secureCapture: secureCapture);
    await task.dispose();
  }

  Future<void> handleMediaContentModerationCompletedEvent() async {
    final notification = await api
        .media((api) => api.postGetMediaContentModerationCompletedNotification())
        .ok();

    if (notification == null) {
      return;
    }

    await NotificationMediaContentModerationCompleted.handleMediaContentModerationCompleted(
      notification,
      accountBackgroundDb,
    );

    final viewed = MediaContentModerationCompletedNotificationViewed(
      accepted: notification.accepted.id.toViewed(),
      rejected: notification.rejected.id.toViewed(),
      deleted: notification.deleted.id.toViewed(),
    );
    await api
        .mediaAction((api) => api.postMarkMediaContentModerationCompletedNotificationViewed(viewed))
        .andThen(
          (_) => accountBackgroundDb.accountAction(
            (db) => db.notification.mediaContentAccepted.updateViewedId(viewed.accepted),
          ),
        )
        .andThen(
          (_) => accountBackgroundDb.accountAction(
            (db) => db.notification.mediaContentRejected.updateViewedId(viewed.rejected),
          ),
        );
  }

  Future<Result<(), ()>> setProfileContent(SetProfileContent imgInfo) => api
      .mediaAction((api) => api.putProfileContent(imgInfo))
      .onOk(() => reloadMyMediaContent())
      .emptyErr();

  Future<Result<AccountContent, ()>> loadAllContent() =>
      api.media((api) => api.getAllAccountMediaContent(currentUser.aid)).emptyErr();

  Future<Result<(), ()>> retryInitialSetupImages(RetryInitialSetupImages content) async {
    final result = await InitialSetupUtils(
      api,
    ).handleInitialSetupImages(content.securitySelfie, content.profileImgs);
    await reloadMyMediaContent();
    return result;
  }

  Future<Result<(), ()>> _reloadMediaNotificationSettings() async {
    return await api
        .media((api) => api.getMediaAppNotificationSettings())
        .andThenEmptyErr(
          (v) => accountBackgroundDb.accountAction(
            (db) => db.appNotificationSettings.updateMediaNotificationSettings(v),
          ),
        );
  }
}

sealed class MapTileResult {}

class MapTileSuccess extends MapTileResult {
  Uint8List pngData;
  MapTileSuccess(this.pngData);
}

class MapTileError extends MapTileResult {}

class MapTileNotAvailable extends MapTileResult {}
