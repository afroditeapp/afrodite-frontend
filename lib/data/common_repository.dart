
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/data/push_notification_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/storage/kv.dart';

var log = Logger("CommonRepository");

class CommonRepository extends DataRepositoryWithLifecycle {
  final db = DatabaseManager.getInstance();
  final backgroundDb = BackgroundDatabaseManager.getInstance();

  final syncHandler = ConnectedActionScheduler(ApiManager.getInstance());
  bool initDone = false;

  Stream<bool> get notificationPermissionAsked => db
    .commonStreamOrDefault(
      (db) => db.watchNotificationPermissionAsked(),
      NOTIFICATION_PERMISSION_ASKED_DEFAULT,
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
    await DatabaseManager.getInstance().commonAction((db) => db.updateNotificationPermissionAsked(value));
  }

  @override
  Future<void> onLogin() async {
    syncHandler.onLoginSync(() async {
      // Force sending the FCM token to server. This is needed if this login
      // is for different account than previously.
      await BackgroundDatabaseManager.getInstance().commonAction((db) => db.updateFcmDeviceTokenAndPendingNotificationToken(null, null));
      await PushNotificationManager.getInstance().initPushNotifications();
    });
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

class KvBooleanUpdate {
  KvBoolean key;
  bool value;
  KvBooleanUpdate(this.key, this.value);
}
