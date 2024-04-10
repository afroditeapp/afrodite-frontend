
import 'dart:async';

import 'package:logging/logging.dart';
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
}
