
import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/data/push_notification_manager.dart';
import 'package:pihka_frontend/data/utils.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/storage/kv.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("CommonRepository");

class CommonRepository extends DataRepository {
  CommonRepository._private();
  static final _instance = CommonRepository._private();
  factory CommonRepository.getInstance() {
    return _instance;
  }

  final db = DatabaseManager.getInstance();
  final backgroundDb = BackgroundDatabaseManager.getInstance();

  final syncHandler = ConnectedActionScheduler();
  bool initDone = false;

  Stream<bool> get notificationPermissionAsked => db
    .commonStreamOrDefault(
      (db) => db.watchNotificationPermissionAsked(),
      NOTIFICATION_PERMISSION_ASKED_DEFAULT,
    );

  final BehaviorSubject<KvBooleanUpdate> _kvBooleanUpdates = BehaviorSubject<KvBooleanUpdate>();

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    // Sync notification settings to shared preferences
    _kvBooleanUpdates.asyncMap((event) async {
      await KvBooleanManager.getInstance().setValue(event.key, event.value);
      return null;
    })
      .listen((event) {});

    backgroundDb
      .accountStream((db) => db.daoLocalNotificationSettings.watchMessages())
      .listen((state) {
        _kvBooleanUpdates.add(KvBooleanUpdate(
          KvBoolean.localNotificationSettingMessages,
          state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT,
        ));
      });
    backgroundDb
      .accountStream((db) => db.daoLocalNotificationSettings.watchLikes())
      .listen((state) {
        _kvBooleanUpdates.add(KvBooleanUpdate(
          KvBoolean.localNotificationSettingLikes,
          state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT,
        ));
      });
    backgroundDb
      .accountStream((db) => db.daoLocalNotificationSettings.watchModerationRequestStatus())
      .listen((state) {
        _kvBooleanUpdates.add(KvBooleanUpdate(
          KvBoolean.localNotificationSettingModerationRequestStatus,
          state ?? NOTIFICATION_CATEGORY_ENABLED_DEFAULT,
        ));
      });
  }

  Future<void> setNotificationPermissionAsked(bool value) async {
    await DatabaseManager.getInstance().commonAction((db) => db.updateNotificationPermissionAsked(value));
  }

  @override
  Future<void> onLogin() async {
    await KvIntManager.getInstance().incrementNotificationSessionId();

    syncHandler.onLoginSync(() async {
      // Force sending the FCM token to server. This is needed if this login
      // is for different account than previously.
      await KvStringManager.getInstance().setValue(KvString.fcmDeviceToken, null);
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
