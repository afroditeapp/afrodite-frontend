import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/config.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/login_repository.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/account_background_database_manager.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/firebase_options.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/main.dart';
import 'package:utils/utils.dart';
import 'package:encryption/encryption.dart';
import 'package:pihka_frontend/utils/result.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("PushNotificationManager");

// TODO(prod): For ios check app capabilities related to push notifications

class PushNotificationManager extends AppSingleton {
  PushNotificationManager._private();
  static final _instance = PushNotificationManager._private();
  factory PushNotificationManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;
  FirebaseApp? _firebaseApp;
  StreamSubscription<String>? _tokenSubscription;

  final PublishSubject<String> _newFcmTokenReceived = PublishSubject();

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _newFcmTokenReceived.asyncMap((fcmToken) async {
      await _refreshTokenToServer(fcmToken);
    }).listen((value) {});
  }

  /// Initializes push notifications. Can be called multiple times.
  Future<void> initPushNotifications() async {
    final enabled = await NotificationManager.getInstance().areNotificationsEnabled();
    if (!enabled) {
      return;
    }

    if (Platform.isAndroid) {
      try {
        await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
      } catch (_) {
        log.warning("Google Play Services are not available");
        return;
      }
    }

    if (_firebaseApp == null) {
      final app = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (app.isAutomaticDataCollectionEnabled) {
        log.info("Disabling Firebase automatic data collection");
        await app.setAutomaticDataCollectionEnabled(false);
      }
      _firebaseApp = app;
    }

    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (Platform.isIOS && apnsToken == null) {
      log.error("Initing push notification support failed: APNS token is null");
      return;
    }

    if (_tokenSubscription == null) {
      _tokenSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        _newFcmTokenReceived.add(token);
      });
      _tokenSubscription?.onError((_) {
        log.error("FCM onTokenRefresh error");
      });
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken == null) {
      log.error("FCM token is null");
      return;
    }

    _newFcmTokenReceived.add(fcmToken);
  }

  Future<void> _refreshTokenToServer(String fcmToken) async {
    final savedToken = await BackgroundDatabaseManager.getInstance().commonStreamSingle((db) => db.watchFcmDeviceToken());
    if (savedToken?.token != fcmToken) {
      log.info("FCM token changed, sending token to server");
      final newToken = FcmDeviceToken(token: fcmToken);
      final api = LoginRepository.getInstance().repositoriesOrNull?.api;
      if (api == null) {
        log.info("FCM token changed, skipping FCM token update because server API is not available");
        return;
      }
      final result = await api.chat((api) => api.postSetDeviceToken(newToken)).ok();
      if (result != null) {
        log.info("FCM token sending successful");
        final dbResult = await BackgroundDatabaseManager.getInstance().commonAction((db) => db.updateFcmDeviceTokenAndPendingNotificationToken(newToken, result));
        if (dbResult.isOk()) {
          log.error("FCM token saving to local database successful");
        } else {
          log.error("FCM token saving to local database failed");
        }
      } else {
        log.error("Failed to send FCM token to server");
      }
    } else {
      log.info("Current FCM token is already on server");
    }
  }

  Future<void> logoutPushNotifications() async {
    await _tokenSubscription?.cancel();
    if (_firebaseApp != null) {
      try {
        // On iOS this seems to throw exception about APNS token
        // at least when APNS is not configured.
        await FirebaseMessaging.instance.deleteToken();
      } catch (e) {
        log.error("Failed to delete FCM token");
        log.finest("Exception: $e");
      }
    }
    // TODO(prod): Make sure that server unassociates this FCM token with the user
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This might run on a separate isolate than main isolate, so nothing is
  // initialized in that case.

  initLogging();
  await SecureStorageManager.getInstance().init();
  final db = BackgroundDatabaseManager.getInstance();
  await db.init();
  await loadLocalizationsFromBackgroundDatabaseIfNeeded();

  log.info("Handling FCM background message");

  // TODO(microservice): Use chat server URL instead.
  final chatUrl = await db.commonStreamSingleOrDefault(
    (db) => db.watchServerUrlAccount(),
    defaultServerUrlAccount(),
  );
  final pendingNotificationToken = await db.commonStreamSingle((db) => db.watchPendingNotificationToken());
  if (pendingNotificationToken == null) {
    log.error("Downloading pending notification failed: pending notification token is null");
    return;
  }

  final currentAccountId = await db.commonStreamSingle((db) => db.watchAccountId());
  if (currentAccountId == null) {
    log.error("Downloading pending notification failed: AccountId is not available");
    return;
  }
  final accountBackgroundDb = db.getAccountBackgroundDatabaseManager(currentAccountId);

  final apiProvider = ApiProvider(chatUrl);
  await apiProvider.init();
  final ApiWrapper<ChatApi> chatApi = ApiWrapper(apiProvider.chat, NoConnection());
  final result = await chatApi.requestValue((api) => api.postGetPendingNotification(pendingNotificationToken), logError: false);
  switch (result) {
    case Ok(:final v):
      final manager = NotificationManager.getInstance();
      await manager.init();
      if (!await manager.areNotificationsEnabled()) {
        return;
      }

      if (v.value == 0x1) {
        await _handlePushNotificationNewMessageReceived(v.newMessageReceivedFrom ?? [], accountBackgroundDb);
      }
    case Err():
      log.error("Downloading pending notification failed");
  }
}

Future<void> _handlePushNotificationNewMessageReceived(List<AccountId> messageSenders, AccountBackgroundDatabaseManager accountBackgroundDb) async {
  for (final sender in messageSenders) {
    await NotificationMessageReceived.getInstance().updateMessageReceivedCount(sender, 1, accountBackgroundDb);
    // Prevent showing the notification again if it is dismissed, another
    // message push notfication for the same sender arives and app is not
    // opened (retrieving pending messages from the server resets this value)
    await accountBackgroundDb.accountAction((db) => db.daoNewMessageNotification.setNotificationShown(sender, true));
  }
}
