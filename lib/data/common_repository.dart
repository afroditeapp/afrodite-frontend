
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:app/api/api_manager.dart';
import 'package:app/data/push_notification_manager.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/utils/result.dart';

var log = Logger("CommonRepository");

class CommonRepository extends DataRepositoryWithLifecycle {
  final db = DatabaseManager.getInstance();
  final backgroundDb = BackgroundDatabaseManager.getInstance();

  final ConnectedActionScheduler syncHandler;
  bool initDone = false;

  CommonRepository(ServerConnectionManager connectionManager) :
    syncHandler = ConnectedActionScheduler(connectionManager);

  Stream<bool> get notificationPermissionAsked => db
    .commonStreamOrDefault(
      (db) => db.app.watchNotificationPermissionAsked(),
      false,
    );

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
  }

  Future<void> setNotificationPermissionAsked(bool value) async {
    await DatabaseManager.getInstance().commonAction((db) => db.app.updateNotificationPermissionAsked(value));
  }

  @override
  Future<void> onLogin() async {
    // Force sending the FCM token to server. This is needed if this login
    // is for different account than previously.
    await BackgroundDatabaseManager.getInstance().commonAction((db) => db.loginSession.updateFcmDeviceTokenAndPendingNotificationToken(null, null));
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
