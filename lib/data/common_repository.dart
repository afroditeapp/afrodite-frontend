
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/push_notification_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/database_manager.dart';

var log = Logger("CommonRepository");


class CommonRepository extends DataRepository {
  CommonRepository._private();
  static final _instance = CommonRepository._private();
  factory CommonRepository.getInstance() {
    return _instance;
  }

  final syncHandler = ConnectedActionScheduler();
  bool initDone = false;

  Stream<bool> get notificationPermissionAsked => DatabaseManager.getInstance()
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

  Future<void> setNotificationPermissionAsked(bool value) async {
    await DatabaseManager.getInstance().commonAction((db) => db.updateNotificationPermissionAsked(value));
  }

  @override
  Future<void> onLogin() async {
    syncHandler.onLoginSync(() async {
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
