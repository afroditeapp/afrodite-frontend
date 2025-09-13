import 'dart:async';
import 'dart:io';

import 'package:app/data/general/notification/state/automatic_profile_search.dart';
import 'package:app/data/general/notification/state/profile_text_moderation_completed.dart';
import 'package:app/data/general/notification/state/media_content_moderation_completed.dart';
import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/utils/app_error.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/api/api_provider.dart';
import 'package:app/api/api_wrapper.dart';
import 'package:app/config.dart';
import 'package:app/data/general/notification/state/like_received.dart';
import 'package:app/data/general/notification/state/message_received.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/database/account_background_database_manager.dart';
import 'package:app/database/background_database_manager.dart';
import 'package:app/firebase_options.dart';
import 'package:app/localizations.dart';
import 'package:app/main.dart';
import 'package:utils/utils.dart';
import 'package:encryption/encryption.dart';
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
  FirebaseApp? _firebaseApp;
  StreamSubscription<String>? _tokenSubscription;

  final PublishSubject<String> _newFcmTokenReceived = PublishSubject();

  int initRetryWaitSeconds = 5;

  @override
  Future<void> init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _newFcmTokenReceived
        .asyncMap((fcmToken) async {
          await _refreshTokenToServer(fcmToken);
        })
        .listen((value) {});
  }

  /// Initializes push notifications. Can be called multiple times.
  Future<void> initPushNotifications() async {
    if (kIsWeb) {
      // Push notifications are not supported on web.
      return;
    }

    if (DefaultFirebaseOptions.currentPlatform.apiKey.isEmpty) {
      // Firebase configuration is missing
      return;
    }

    final enabled = await NotificationManager.getInstance().areNotificationsEnabled();
    if (!enabled) {
      return;
    }

    if (Platform.isAndroid) {
      try {
        await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
      } catch (_) {
        _log.warning("Google Play Services are not available");
        return;
      }
    }

    await _initFirebaseIfNeeded();

    if (_tokenSubscription == null) {
      _tokenSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        _newFcmTokenReceived.add(token);
      });
      _tokenSubscription?.onError((_) {
        _log.error("FCM onTokenRefresh error");
      });
    }

    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (Platform.isIOS && apnsToken == null) {
      // iOS only. If apnsToken is null then getToken will throw exception.
      // The token is not available directly after initializing FirebaseApp.
      _log.error("Initing push notification support failed: APNS token is null");
      unawaited(Future.delayed(Duration(seconds: initRetryWaitSeconds), initPushNotifications));
      initRetryWaitSeconds *= 2;
      return;
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken == null) {
      _log.error("FCM token is null");
      return;
    }

    _newFcmTokenReceived.add(fcmToken);
  }

  /// Can be called multiple times
  Future<void> _initFirebaseIfNeeded() async {
    if (_firebaseApp == null) {
      final app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      if (app.isAutomaticDataCollectionEnabled) {
        _log.info("Disabling Firebase automatic data collection");
        await app.setAutomaticDataCollectionEnabled(false);
      }
      _firebaseApp = app;
    }
  }

  Future<void> _refreshTokenToServer(String fcmToken) async {
    final savedToken = await BackgroundDatabaseManager.getInstance().commonStreamSingle(
      (db) => db.loginSession.watchFcmDeviceToken(),
    );
    if (savedToken?.token != fcmToken) {
      _log.info("FCM token changed, sending token to server");
      final newToken = FcmDeviceToken(token: fcmToken);
      final api = LoginRepository.getInstance().repositoriesOrNull?.api;
      if (api == null) {
        _log.info(
          "FCM token changed, skipping FCM token update because server API is not available",
        );
        return;
      }
      final result = await api.common((api) => api.postSetDeviceToken(newToken)).ok();
      if (result != null) {
        _log.info("FCM token sending successful");
        final dbResult = await BackgroundDatabaseManager.getInstance().commonAction(
          (db) => db.loginSession.updateFcmDeviceTokenAndPendingNotificationToken(newToken, result),
        );
        if (dbResult.isOk()) {
          _log.error("FCM token saving to local database successful");
        } else {
          _log.error("FCM token saving to local database failed");
        }
      } else {
        _log.error("Failed to send FCM token to server");
      }
    } else {
      _log.info("Current FCM token is already on server");
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
        _log.error("Failed to delete FCM token");
        _log.finest("Exception: $e");
      }
    }
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

  _log.info("Handling FCM background message");

  final accountUrl = await db.commonStreamSingleOrDefault(
    (db) => db.app.watchServerUrl(),
    defaultServerUrl(),
  );
  // TODO(prod): Single DB query should be used for getting
  // pendingNotificationToken and currentAccountId.
  // Or move pending notification token to account background DB?
  final pendingNotificationToken = await db.commonStreamSingle(
    (db) => db.loginSession.watchPendingNotificationToken(),
  );
  if (pendingNotificationToken == null) {
    _log.error("Downloading pending notification failed: pending notification token is null");
    return;
  }

  final currentAccountId = await db.commonStreamSingle((db) => db.loginSession.watchAccountId());
  if (currentAccountId == null) {
    _log.error("Downloading pending notification failed: AccountId is not available");
    return;
  }

  final apiProvider = ApiProvider(accountUrl);
  await apiProvider.init();
  final ApiWrapper<CommonApi> commonApi = ApiWrapper(apiProvider.common, NoConnection());
  final result = await commonApi.requestValue(
    (api) => api.postGetPendingNotification(pendingNotificationToken),
    logError: false,
  );

  final accountBackgroundDb = LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
  if (accountBackgroundDb != null &&
      accountBackgroundDb.id == currentAccountId &&
      !accountBackgroundDb.isClosed) {
    accountBackgroundDb.pushNotificationHandlerIsUsingDb = true;
    await _handlePendingNotification(result, accountBackgroundDb);
    accountBackgroundDb.pushNotificationHandlerIsUsingDb = false;
    if (accountBackgroundDb.pushNotificationHandlerShouldCloseDb) {
      await accountBackgroundDb.close();
    }
  } else {
    final accountBackgroundDb = await db.getAccountBackgroundDatabaseManager(currentAccountId);
    await _handlePendingNotification(result, accountBackgroundDb);
    await accountBackgroundDb.close();
  }
}

Future<void> _handlePendingNotification(
  Result<PendingNotificationWithData, ValueApiError> result,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  switch (result) {
    case Ok(:final v):
      final manager = NotificationManager.getInstance();
      await manager.init();
      if (!await manager.areNotificationsEnabled()) {
        return;
      }

      if ((v.value & 0x1) == 0x1) {
        await _handlePushNotificationNewMessageReceived(v.newMessage, accountBackgroundDb);
      }
      if ((v.value & 0x2) == 0x2) {
        await _handlePushNotificationReceivedLikesChanged(
          v.receivedLikesChanged,
          accountBackgroundDb,
        );
      }
      if ((v.value & 0x4) == 0x4) {
        await _handlePushNotificationMediaContentModerationCompleted(
          v.mediaContentModerationCompleted,
          accountBackgroundDb,
        );
      }
      if ((v.value & 0x8) == 0x8) {
        await _handlePushNotificationNewsChanged(v.newsChanged, accountBackgroundDb);
      }
      if ((v.value & 0x10) == 0x10) {
        await _handlePushNotificationProfileStringModerationCompleted(
          v.profileStringModerationCompleted,
          accountBackgroundDb,
        );
      }
      if ((v.value & 0x20) == 0x20) {
        await _handlePushNotificationAutomaticProfileSearchCompleted(
          v.automaticProfileSearchCompleted,
          accountBackgroundDb,
        );
      }
      if ((v.value & 0x40) == 0x40) {
        await _handlePushNotificationAdminNotification(v.adminNotification, accountBackgroundDb);
      }
    case Err():
      _log.error("Downloading pending notification failed");
  }
}

Future<void> _handlePushNotificationNewMessageReceived(
  NewMessageNotificationList? messageSenders,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (messageSenders == null) {
    return;
  }

  for (final sender in messageSenders.v) {
    await NotificationMessageReceived.getInstance().updateMessageReceivedCount(
      sender.a,
      sender.m,
      sender.c,
      accountBackgroundDb,
    );
    // Prevent showing the notification again if it is dismissed, another
    // message push notfication for the same sender arives and app is not
    // opened (retrieving pending messages from the server resets this value)
    await accountBackgroundDb.accountAction(
      (db) => db.notification.setNewMessageNotificationShown(sender.a, true),
    );
  }
}

Future<void> _handlePushNotificationReceivedLikesChanged(
  NewReceivedLikesCountResult? r,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (r == null) {
    return;
  }

  await NotificationLikeReceived.getInstance().incrementReceivedLikesCount(accountBackgroundDb);
  await accountBackgroundDb.accountAction(
    (db) => db.newReceivedLikesCount.updateSyncVersionReceivedLikes(r),
  );
}

Future<void> _handlePushNotificationMediaContentModerationCompleted(
  MediaContentModerationCompletedNotification? notification,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (notification == null) {
    return;
  }
  await NotificationMediaContentModerationCompleted.handleMediaContentModerationCompleted(
    notification,
    accountBackgroundDb,
  );
}

Future<void> _handlePushNotificationProfileStringModerationCompleted(
  ProfileStringModerationCompletedNotification? notification,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (notification == null) {
    return;
  }
  await NotificationProfileStringModerationCompleted.handleProfileStringModerationCompleted(
    notification,
    accountBackgroundDb,
  );
}

Future<void> _handlePushNotificationNewsChanged(
  UnreadNewsCountResult? r,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (r == null) {
    return;
  }
  await NotificationNewsItemAvailable.getInstance().handleNewsCountUpdate(r, accountBackgroundDb);
}

Future<void> _handlePushNotificationAutomaticProfileSearchCompleted(
  AutomaticProfileSearchCompletedNotification? notification,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (notification == null) {
    return;
  }
  await NotificationAutomaticProfileSearch.handleAutomaticProfileSearchCompleted(
    notification,
    accountBackgroundDb,
  );
}

Future<void> _handlePushNotificationAdminNotification(
  AdminNotification? notification,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (notification == null) {
    return;
  }
  await NotificationNewsItemAvailable.getInstance().showAdminNotification(
    notification,
    accountBackgroundDb,
  );
}
