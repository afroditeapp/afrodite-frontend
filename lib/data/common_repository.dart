import 'dart:async';

import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/data/utils/ios_delay_app_suspend_task.dart';
import 'package:async/async.dart' show StreamExtensions;
import 'package:logging/logging.dart';
import 'package:app/api/server_connection_manager.dart';
import 'package:app/data/push_notification_manager.dart';
import 'package:app/data/utils.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/database/database_manager.dart';
import 'package:app/utils/result.dart';
import 'package:app/logic/app/app_visibility_provider.dart';
import 'package:openapi/api.dart';

final _log = Logger("CommonRepository");

class CommonRepository extends DataRepositoryWithLifecycle {
  final db = DatabaseManager.getInstance();
  final backgroundDb = BackgroundDatabaseManager.getInstance();
  final AccountId currentUser;
  final ServerConnectionManager connectionManager;
  final ProfileRepository profile;
  final ConnectedActionScheduler syncHandler;
  bool initDone = false;

  CommonRepository(this.currentUser, this.connectionManager, this.profile)
    : syncHandler = ConnectedActionScheduler(connectionManager);

  Stream<bool> get notificationPermissionAsked =>
      db.commonStreamOrDefault((db) => db.app.watchNotificationPermissionAsked(), false);

  StreamSubscription<bool>? _isForegroundSubscription;
  DateTime? _backgroundedAt;
  Timer? _disconnectTimer;

  StreamSubscription<ServerConnectionState>? _automaticLogoutSubscription;

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    await IosDelayAppSuspendTask.allow();

    _isForegroundSubscription = AppVisibilityProvider.getInstance().isForegroundStream
        .asyncMap((isForeground) async {
          _disconnectTimer?.cancel();

          if (isForeground) {
            await IosDelayAppSuspendTask.dispose();

            final backgroundedAt = _backgroundedAt;
            if (backgroundedAt != null) {
              final now = DateTime.now();
              if (now.difference(backgroundedAt) > const Duration(days: 1)) {
                _log.info("Refreshing profile grid automatically");
                await profile.resetMainProfileIterator();
              }
            }
            _backgroundedAt = null;

            final state = await connectionManager.state.firstOrNull;
            if (state == ServerConnectionState.noConnection) {
              await connectionManager.restartIfRestartNotOngoing();
            }
          } else {
            _backgroundedAt = DateTime.now();
            _disconnectTimer = Timer(Duration(seconds: 10), () async {
              await connectionManager.close();
              await IosDelayAppSuspendTask.dispose();
            });
          }

          return isForeground;
        })
        .listen(null);

    _automaticLogoutSubscription = connectionManager.state.listen((v) {
      if (v == ServerConnectionState.waitingRefreshToken) {
        // Tokens are invalid. Logout is required.
        _log.info("Automatic logout");
        LoginRepository.getInstance().logout(currentUser);
      }
    });
  }

  @override
  Future<void> dispose() async {
    await syncHandler.dispose();
    await _isForegroundSubscription?.cancel();
    await _automaticLogoutSubscription?.cancel();
    await IosDelayAppSuspendTask.forbid();
    await IosDelayAppSuspendTask.dispose();
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
