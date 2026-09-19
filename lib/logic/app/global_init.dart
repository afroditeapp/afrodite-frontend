import 'dart:async';

import 'package:app/api/error_manager.dart';
import 'package:app/data/app_version.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/data/push_notification_manager.dart';
import 'package:app/data/utils/app_attestation.dart';
import 'package:app/database/common_database_manager.dart';
import 'package:app/utils/app_running_detector/app_running_detector.dart';
import 'package:app/utils/camera.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

final _log = Logger("GlobalInitManager");

enum GlobalInitState { inProgress, completed, appIsAlreadyRunning, appVersionDowngradeDetected }

class GlobalInitManager extends AppSingletonNoInit {
  GlobalInitManager._private();
  static final _instance = GlobalInitManager._private();
  factory GlobalInitManager.getInstance() {
    return _instance;
  }

  bool _initDone = false;
  bool _appVersionDowngradeDetected = false;
  bool _continueAfterDowngradeTriggered = false;

  final BehaviorSubject<GlobalInitState> _globalInitState = BehaviorSubject.seeded(
    GlobalInitState.inProgress,
  );
  Stream<GlobalInitState> get globalInitState => _globalInitState.stream;

  Future<void> _init() async {
    if (_initDone) {
      return;
    }
    _initDone = true;

    if (await isAppAlreadyRunning()) {
      _log.fine("App is already running");
      _globalInitState.add(GlobalInitState.appIsAlreadyRunning);
      return;
    }

    _appVersionDowngradeDetected = await AppVersionManager.getInstance()
        .detectAppVersionDowngradeAndUpdateAppVersionInSharedPrefs();
    if (_appVersionDowngradeDetected) {
      _log.warning("App version downgrade detected, pausing global init");
      _globalInitState.add(GlobalInitState.appVersionDowngradeDetected);
      return;
    }

    await _continueInit();
  }

  Future<void> _continueInit() async {
    await CommonDatabaseManager.getInstance().init();

    await ErrorManager.getInstance().init();
    await CameraManager.getInstance().init();
    await NotificationManager.getInstance().init();
    await PushNotificationManager.getInstance().init();
    await AppAttestationManager.getInstance().init();

    await LoginRepository.getInstance().init();

    // Initializes formatting for other locales as well
    await initializeDateFormatting("en_US", null);

    _log.fine("Global init completed");
    _globalInitState.add(GlobalInitState.completed);
  }

  Future<void> ignoreVersionDowngradeAndContinueInit() async {
    if (!_appVersionDowngradeDetected || _continueAfterDowngradeTriggered) {
      return;
    }
    _continueAfterDowngradeTriggered = true;

    _log.info("Continuing global init");

    _globalInitState.add(GlobalInitState.inProgress);
    await _continueInit();
  }

  /// Global init should be triggered after splash screen
  /// is visible.
  Future<void> triggerGlobalInit() async {
    unawaited(_init());
  }
}
