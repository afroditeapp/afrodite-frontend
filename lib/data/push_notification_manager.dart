import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/data/general/notification/state/automatic_profile_search.dart';
import 'package:app/data/general/notification/state/profile_text_moderation_completed.dart';
import 'package:app/data/general/notification/state/media_content_moderation_completed.dart';
import 'package:app/data/general/notification/state/news_item_available.dart';
import 'package:app/data/general/notification/utils/notification_payload.dart';
import 'package:app/utils/app_error.dart';
import 'package:flutter/foundation.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:logging/logging.dart';
import 'package:native_push/native_push.dart';
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
  bool _nativePushInitialized = false;
  StreamSubscription<(NotificationService, String?)>? _tokenSubscription;
  Map<String, String>? _appLaunchNotificationPayload;

  final PublishSubject<String> _newFcmTokenReceived = PublishSubject();

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

    await _initNativePushIfNeeded();

    if (_tokenSubscription == null) {
      _tokenSubscription = NativePush().notificationTokenStream.listen((tokenTuple) {
        final (service, token) = tokenTuple;
        if (token != null) {
          _newFcmTokenReceived.add(token);
        }
      });
      _tokenSubscription?.onError((_) {
        _log.error("NativePush token refresh error");
      });
    }

    final (service, token) = await NativePush().notificationToken;
    if (token == null) {
      _log.error("Notification token is null");
      return;
    }

    _newFcmTokenReceived.add(token);
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

      await NativePush().initialize(firebaseOptions: firebaseOptions);

      // Register for remote notifications with all available options
      final options = [
        NotificationOption.alert,
        NotificationOption.badge,
        NotificationOption.sound,
        NotificationOption.criticalAlert,
        NotificationOption.carPlay,
        NotificationOption.providesAppNotificationSettings,
        NotificationOption.provisional,
      ];

      final registered = await NativePush().registerForRemoteNotification(options: options);
      if (!registered) {
        _log.error("Failed to register for remote notifications");
        return;
      }

      _nativePushInitialized = true;
    }
  }

  Future<void> _refreshTokenToServer(String fcmToken) async {
    // TODO(future): Improve code so that repositoriesOrNull access
    // is not needed.
    final accountBackgroundDb =
        LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
    if (accountBackgroundDb == null) {
      return;
    }
    final savedToken = await accountBackgroundDb
        .accountStreamSingle((db) => db.loginSession.watchFcmDeviceToken())
        .ok();
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
        final dbResult = await accountBackgroundDb.accountAction(
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

  // NOTE: If push notication is dismissed and
  // app is opened it appears again. One way to prevent
  // that would be to store all received push
  // notifications in a file and handle all notifications
  // before WebSocket is connected.

  // Prevent showing launch notification again
  Future<void> updateDbWithLaunchNotificationData() async {
    final payload = _appLaunchNotificationPayload;
    if (payload == null) {
      return;
    }

    final accountIdString = payload["a"];
    final dataString = payload["data"];
    if (dataString == null) {
      _log.error("DB update failed: data field not found from notification payload");
      return;
    }
    final data = PendingNotificationWithData.fromJson(jsonDecode(dataString));
    if (data == null) {
      _log.error("DB update failed: data field is invalid");
      return;
    }

    final db = BackgroundDatabaseManager.getInstance();
    final currentAccountId = await db.commonStreamSingle((db) => db.loginSession.watchAccountId());
    if (currentAccountId == null) {
      _log.error("DB update failed: AccountId is not available");
      return;
    }

    if (currentAccountId.aid != accountIdString) {
      _log.error("DB update failed: notification is for other account");
      return;
    }

    final accountBackgroundDb = await db.getAccountBackgroundDatabaseManager(currentAccountId);
    await _handlePendingNotification(Ok(data), accountBackgroundDb);
    await accountBackgroundDb.close();
  }
}

Future<void> _handleBackgroundNotification(Map<String, String> _) async {
  initLogging();
  await SecureStorageManager.getInstance().init();
  final db = BackgroundDatabaseManager.getInstance();
  await db.init();
  await loadLocalizationsFromBackgroundDatabaseIfNeeded();

  _log.info("Handling background notification");

  final serverUrl = await db.commonStreamSingleOrDefault(
    (db) => db.app.watchServerUrl(),
    defaultServerUrl(),
  );
  final currentAccountId = await db.commonStreamSingle((db) => db.loginSession.watchAccountId());
  if (currentAccountId == null) {
    _log.error("Downloading pending notification failed: AccountId is not available");
    return;
  }

  final accountBackgroundDb = LoginRepository.getInstance().repositoriesOrNull?.accountBackgroundDb;
  if (accountBackgroundDb != null &&
      accountBackgroundDb.id == currentAccountId &&
      !accountBackgroundDb.isClosed) {
    // This is main isolate and database is already open
    accountBackgroundDb.pushNotificationHandlerIsUsingDb = true;
    await _handleWithAccountBackgroundDb(serverUrl, currentAccountId, accountBackgroundDb);
    accountBackgroundDb.pushNotificationHandlerIsUsingDb = false;
    if (accountBackgroundDb.pushNotificationHandlerShouldCloseDb) {
      await accountBackgroundDb.close();
    }
  } else {
    final accountBackgroundDb = await db.getAccountBackgroundDatabaseManager(currentAccountId);
    await _handleWithAccountBackgroundDb(serverUrl, currentAccountId, accountBackgroundDb);
    await accountBackgroundDb.close();
  }
}

Future<void> _handleWithAccountBackgroundDb(
  String serverUrl,
  AccountId currentAccountId,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  final pendingNotificationToken = await accountBackgroundDb
      .accountStreamSingle((db) => db.loginSession.watchPendingNotificationToken())
      .ok();
  if (pendingNotificationToken == null) {
    _log.error("Downloading pending notification failed: pending notification token is null");
    return;
  }

  final apiProvider = ApiProvider(serverUrl);
  await apiProvider.init();
  final ApiWrapper<CommonApi> commonApi = ApiWrapper(apiProvider.common, NoConnection());
  final result = await commonApi.requestValue(
    (api) => api.postGetPendingNotification(pendingNotificationToken),
    logError: false,
  );
  await _handlePendingNotification(result, accountBackgroundDb);
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
      await _handlePushNotificationNewMessageReceived(v.newMessage, accountBackgroundDb);
      await _handlePushNotificationReceivedLikesChanged(
        v.receivedLikesChanged,
        accountBackgroundDb,
      );
      final mediaContentAccepted = v.mediaContentAccepted;
      if (mediaContentAccepted != null) {
        await NotificationMediaContentModerationCompleted.handleAccepted(
          mediaContentAccepted,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      final mediaContentRejected = v.mediaContentRejected;
      if (mediaContentRejected != null) {
        await NotificationMediaContentModerationCompleted.handleRejected(
          mediaContentRejected,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      final mediaContentDeleted = v.mediaContentDeleted;
      if (mediaContentDeleted != null) {
        await NotificationMediaContentModerationCompleted.handleDeleted(
          mediaContentDeleted,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      await _handlePushNotificationNewsChanged(v.newsChanged, accountBackgroundDb);
      final nameAccepted = v.profileNameAccepted;
      if (nameAccepted != null) {
        await NotificationProfileStringModerationCompleted.handleNameAccepted(
          nameAccepted,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      final nameRejected = v.profileNameRejected;
      if (nameRejected != null) {
        await NotificationProfileStringModerationCompleted.handleNameRejected(
          nameRejected,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      final textAccepted = v.profileTextAccepted;
      if (textAccepted != null) {
        await NotificationProfileStringModerationCompleted.handleTextAccepted(
          textAccepted,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      final textRejected = v.profileTextRejected;
      if (textRejected != null) {
        await NotificationProfileStringModerationCompleted.handleTextRejected(
          textRejected,
          accountBackgroundDb,
          onlyDbUpdate: true,
        );
      }
      await _handlePushNotificationAutomaticProfileSearchCompleted(
        v.automaticProfileSearchCompleted,
        accountBackgroundDb,
      );
      await _handlePushNotificationAdminNotification(v.adminNotification, accountBackgroundDb);
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
      onlyDbUpdate: true,
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
  await NotificationLikeReceived.getInstance().handleNewReceivedLikesCount(
    r,
    accountBackgroundDb,
    onlyDbUpdate: true,
  );
}

Future<void> _handlePushNotificationNewsChanged(
  UnreadNewsCountResult? r,
  AccountBackgroundDatabaseManager accountBackgroundDb,
) async {
  if (r == null) {
    return;
  }
  await NotificationNewsItemAvailable.getInstance().handleNewsCountUpdate(
    r,
    accountBackgroundDb,
    onlyDbUpdate: true,
  );
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
    onlyDbUpdate: true,
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
    onlyDbUpdate: true,
  );
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
