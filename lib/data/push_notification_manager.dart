import 'dart:async';
import 'dart:io';

import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:flutter/foundation.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';
import 'package:native_push/native_push.dart';
import 'package:openapi/api.dart';
import 'package:app/ui/utils/web_notifications/web_notifications.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/firebase_options.dart';
import 'package:utils/utils.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("PushNotificationManager");

class PushNotificationManager extends AppSingleton {
  PushNotificationManager._private();
  static final _instance = PushNotificationManager._private();
  factory PushNotificationManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;
  bool _nativePushInitialized = false;
  StreamSubscription<(NotificationService, String?)>? _tokenSubscription;
  Map<String, String>? _appLaunchNotificationPayload;

  final PublishSubject<String> _newDeviceTokenReceived = PublishSubject();

  int initRetryWaitSeconds = 5;

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    NativePush().notificationStream.listen((notificationData) {
      final parsedPayload = NotificationPayload.parseMap(notificationData);
      if (parsedPayload == null) {
        return;
      }
      NotificationManager.getInstance().onReceivedPayload.add(parsedPayload);
    });

    final payload = await NativePush().initialNotification();
    if (payload != null) {
      _appLaunchNotificationPayload = payload;
    }

    _newDeviceTokenReceived
        .asyncMap((fcmToken) async {
          await _refreshTokenToServer(fcmToken);
        })
        .listen((value) {});

    if (kIsWeb) {
      watchWebNotificationPermission().listen((status) {
        if (status == NotificationPermissionStatus.granted &&
            LoginRepository.getInstance().repositoriesOrNull != null) {
          _log.info("Web notification permission granted, initializing push notifications");
          initPushNotifications();
        }
      });
    }
  }

  /// Initializes push notifications. Can be called multiple times.
  Future<void> initPushNotifications() async {
    if (!kIsWeb && Platform.isAndroid) {
      try {
        await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
      } catch (_) {
        _log.warning("Google Play Services are not available");
        return;
      }
    }

    await _initNativePushIfNeeded();

    if (_tokenSubscription == null) {
      _tokenSubscription = NativePush().notificationTokenStream.listen((tokenTuple) {
        final (service, token) = tokenTuple;
        if (token != null) {
          _newDeviceTokenReceived.add(token);
        }
      });
      _tokenSubscription?.onError((_) {
        _log.error("NativePush token refresh error");
      });
    }

    await triggerTokenRefresh();
  }

  /// Can be called multiple times
  Future<void> _initNativePushIfNeeded() async {
    if (!_nativePushInitialized) {
      final Map<String, String>? firebaseOptions;
      if (!kIsWeb && Platform.isAndroid) {
        firebaseOptions = DefaultFirebaseOptions.android.toMapForNativePush();
      } else {
        firebaseOptions = null;
      }

      try {
        _log.fine("Running native push initialize function");
        await NativePush().initialize(firebaseOptions: firebaseOptions);
      } catch (e) {
        _log.error("Native push initialization failed, error: $e");
        return;
      }

      _log.fine("Running native push registerForRemoteNotification function");
      final registered = await NativePush().registerForRemoteNotification(
        options: [],
        vapidKey: await getVapidKey(),
      );
      if (!registered) {
        _log.error("Failed to register for remote notifications");
        return;
      }

      _nativePushInitialized = true;
      _log.fine("Native push init completed");
    }
  }

  Future<void> _refreshTokenToServer(String deviceToken) async {
    // TODO(future): Improve code so that repositoriesOrNull access
    // is not needed.
    final accountBackgroundDb =
        LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
    if (accountBackgroundDb == null) {
      return;
    }
    final savedToken = await accountBackgroundDb
        .accountStreamSingle((db) => db.loginSession.watchPushNotificationDeviceToken())
        .ok();
    if (savedToken?.token != deviceToken) {
      _log.info("Push notification device token changed, sending token to server");
      final newToken = PushNotificationDeviceToken(token: deviceToken);
      final api = LoginRepository.getInstance().repositoriesOrNull?.api;
      if (api == null) {
        _log.info(
          "Push notification device token changed, skipping token update because server API is not available",
        );
        return;
      }
      final result = await api.common((api) => api.postSetDeviceToken(newToken)).ok();
      if (result != null) {
        _log.info("Push notification device token sending successful");
        final dbResult = await accountBackgroundDb.accountAction(
          (db) => db.loginSession.updateDeviceTokenAndEncryptionKey(newToken, result),
        );
        if (dbResult.isOk()) {
          _log.info("Push notification device token saving to local database successful");
        } else {
          _log.error("Push notification device token saving to local database failed");
        }
      } else {
        _log.error("Failed to send push notification device token to server");
      }
    } else {
      _log.info("Current push notification device token is already on server");
    }
  }

  Future<String?> getVapidKey() async {
    if (kIsWeb) {
      final repositories = LoginRepository.getInstance().repositoriesOrNull;
      if (repositories != null) {
        final dbVapidKey = await repositories.accountBackgroundDb
            .accountStreamSingle((db) => db.loginSession.watchVapidPublicKey())
            .ok();
        if (dbVapidKey != null) {
          return dbVapidKey.key;
        }

        await repositories.common.receivePushNotificationInfo();

        final dbVapidKeySecond = await repositories.accountBackgroundDb
            .accountStreamSingle((db) => db.loginSession.watchVapidPublicKey())
            .ok();
        if (dbVapidKeySecond != null) {
          return dbVapidKeySecond.key;
        }

        _log.error("Getting VAPID public key failed");
      }
    }
    return null;
  }

  Future<void> triggerTokenRefresh() async {
    if (!_nativePushInitialized) {
      return;
    }
    _log.fine("Trigger token refresh");
    final (_, token) = await NativePush().notificationToken;
    if (token == null) {
      _log.error("Notification token is null");
      return;
    }
    _newDeviceTokenReceived.add(token);
  }

  Future<void> logoutPushNotifications() async {
    await _tokenSubscription?.cancel();
  }

  ParsedPayload? getAndRemoveAppLaunchNotificationPayload() {
    final payload = _appLaunchNotificationPayload;
    _appLaunchNotificationPayload = null;
    if (payload != null) {
      final parsedPayload = NotificationPayload.parseMap(payload);
      if (parsedPayload != null) {
        return parsedPayload;
      }
    }
    return null;
  }
}

class FirebaseOptions {
  final String apiKey;
  final String appId;
  final String projectId;

  const FirebaseOptions({required this.apiKey, required this.appId, required this.projectId});

  Map<String, String> toMapForNativePush() => {
    'apiKey': DefaultFirebaseOptions.currentPlatform.apiKey,
    'applicationId': DefaultFirebaseOptions.currentPlatform.appId,
    'projectId': DefaultFirebaseOptions.currentPlatform.projectId,
  };
}
