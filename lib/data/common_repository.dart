import 'dart:async';

import 'package:app/data/profile_repository.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/push_notification_manager.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:app/logic/app/app_visibility_provider.dart';

var log = Logger("CommonRepository");

class CommonRepository extends DataRepositoryWithLifecycle {
  final db = DatabaseManager.getInstance();
  final backgroundDb = BackgroundDatabaseManager.getInstance();
  final ServerConnectionManager connectionManager;
  final ProfileRepository profile;
  final ConnectedActionScheduler syncHandler;
  bool initDone = false;

  CommonRepository(this.connectionManager, this.profile)
    : syncHandler = ConnectedActionScheduler(connectionManager);

  Stream<bool> get notificationPermissionAsked =>
      db.commonStreamOrDefault((db) => db.app.watchNotificationPermissionAsked(), false);

  StreamSubscription<bool>? _isForegroundSubscription;
  DateTime? _backgroundedAt;
  Timer? _disconnectTimer;

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    _isForegroundSubscription = AppVisibilityProvider.getInstance().isForegroundStream
        .asyncMap((isForeground) async {
          _disconnectTimer?.cancel();

          if (isForeground) {
            final backgroundedAt = _backgroundedAt;
            if (backgroundedAt != null) {
              final now = DateTime.now();
              if (now.difference(backgroundedAt) > const Duration(days: 1)) {
                log.info("Refreshing profile grid automatically");
                await profile.resetMainProfileIterator();
              }
            }
            _backgroundedAt = null;

            final state = await connectionManager.state.firstOrNull;
            if (state == ServerConnectionState.noConnection) {
              await connectionManager.restart();
            }
          } else {
            _backgroundedAt = DateTime.now();
            _disconnectTimer = Timer(Duration(seconds: 10), () {
              connectionManager.close();
            });
          }

          return isForeground;
        })
        .listen(null);
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
    await _isForegroundSubscription?.cancel();
  }

  Future<void> setNotificationPermissionAsked(bool value) async {
    await DatabaseManager.getInstance().commonAction(
      (db) => db.app.updateNotificationPermissionAsked(value),
    );
  }

  @override
  Future<void> onLogin() async {
    // Force sending the FCM token to server. This is needed if this login
    // is for different account than previously.
    await BackgroundDatabaseManager.getInstance().commonAction(
      (db) => db.loginSession.updateFcmDeviceTokenAndPendingNotificationToken(null, null),
    );
  }

  @override
  Future<Result<(), ()>> onLoginDataSync() async {
    await PushNotificationManager.getInstance().initPushNotifications();
    return const Ok(());
  }

  @override
  Future<void> onResumeAppUsage() async {
    syncHandler.onResumeAppUsageSync(() async {
      await PushNotificationManager.getInstance().initPushNotifications();
    });
  }

  @override
  Future<void> onInitialSetupComplete() async {
    await PushNotificationManager.getInstance().initPushNotifications();
  }

  @override
  Future<void> onLogout() async {
    await PushNotificationManager.getInstance().logoutPushNotifications();
  }
}

// TODO(prod): Fix onLogout to run when token invalidation is detected
