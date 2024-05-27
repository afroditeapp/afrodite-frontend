import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/api/api_wrapper.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received_static.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/database/background_database_manager.dart';
import 'package:pihka_frontend/firebase_options.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/main.dart';
import 'package:pihka_frontend/storage/encryption.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/result.dart';

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
  StreamSubscription<RemoteMessage>? _messageSubscription;

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        // TODO(prod): remove this log
        log.finest("FCM token refreshed: $token");
        refreshTokenToServer(token);
      });
      _tokenSubscription?.onError((_) {
        log.error("FCM onTokenRefresh error");
      });
    }

    _messageSubscription ??= FirebaseMessaging.onMessage.listen((message) {
      // TODO(prod): remove this log
      log.finest("FCM message received: $message");
    });

    final fcmToken = await FirebaseMessaging.instance.getToken();
    log.info("Get FCM token called");
    // TODO(prod): remove this log
    log.finest("FCM token: $fcmToken");

    if (fcmToken == null) {
      log.error("FCM token is null");
      return;
    }
  }

  Future<void> refreshTokenToServer(String fcmToken) async {
    final savedToken = await BackgroundDatabaseManager.getInstance().commonStreamSingle((db) => db.watchFcmDeviceToken());
    if (savedToken?.value != fcmToken) {
      log.info("FCM token changed, sending token to server");
      final newToken = FcmDeviceToken(value: fcmToken);
      final result = await ApiManager.getInstance().chatAction((api) => api.postSetDeviceToken(newToken));
      if (result.isOk()) {
        await BackgroundDatabaseManager.getInstance().commonAction((db) => db.updateFcmDeviceToken(newToken));
      } else {
        log.error("Failed to send FCM token to server");
      }
    }
  }

  Future<void> logoutPushNotifications() async {
    await _tokenSubscription?.cancel();
    await _messageSubscription?.cancel();
    if (_firebaseApp != null) {
      await FirebaseMessaging.instance.deleteToken();
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

  // TODO(prod): remove this log
  log.finest("FCM background message: ${message.messageId}");
  log.finest("FCM background message: ${message.data}");
  // TODO: query notification from backend with FCM token

  // TODO(microservice): Use chat server URL instead.
  final chatUrl = await db.commonStreamSingle((db) => db.watchServerUrlAccount());
  if (chatUrl == null) {
    log.error("Downloading pending notification failed: chat server URL is null");
    return;
  }
  final fcmToken = await BackgroundDatabaseManager.getInstance().commonStreamSingle((db) => db.watchFcmDeviceToken());
  if (fcmToken == null) {
    log.error("Downloading pending notification failed: FCM token is null");
    return;
  }

  final ApiWrapper<ChatApi> chatApi = ApiWrapper(ApiProvider(chatUrl).chat);
  final result = await chatApi.requestValue((api) => api.postGetPendingNotification(fcmToken), logError: false);
  switch (result) {
    case Ok(:final v):
      final manager = NotificationManager.getInstance();
      await manager.init();
      if (!await manager.areNotificationsEnabled()) {
        return;
      }

      if (v.value == 0x1) {
        await NotificationMessageReceivedStatic.getInstance().updateState(true);
      }
    case Err():
      log.error("Downloading pending notification failed");
  }
}
