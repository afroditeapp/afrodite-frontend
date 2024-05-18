import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/firebase_options.dart';
import 'package:pihka_frontend/utils.dart';

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
  }

  Future<void> logoutPushNotifications() async {
    await _tokenSubscription?.cancel();
    await _messageSubscription?.cancel();
    await FirebaseMessaging.instance.deleteToken();
    // TODO(prod): Make sure that server unassociates this FCM token with the user
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // TODO(prod): remove this log
  log.finest("FCM background message: ${message.messageId}");
  // TODO: query notification from backend with FCM token
}
