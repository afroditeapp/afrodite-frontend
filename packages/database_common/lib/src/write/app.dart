import 'package:database_common/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.NotificationPermissionAsked,
    schema.VideoCallTipShown,
    schema.CurrentLocale,
    schema.ServerUrl,
  ],
)
class DaoWriteApp extends DatabaseAccessor<CommonDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  Future<void> updateNotificationPermissionAsked(bool value) async {
    await into(notificationPermissionAsked).insertOnConflictUpdate(
      NotificationPermissionAskedCompanion.insert(
        id: SingleRowTable.ID,
        notificationPermissionAsked: Value(value),
      ),
    );
  }

  Future<void> updateVideoCallTipShown(bool value) async {
    await into(videoCallTipShown).insertOnConflictUpdate(
      VideoCallTipShownCompanion.insert(id: SingleRowTable.ID, videoCallTipShown: Value(value)),
    );
  }

  Future<void> updateCurrentLocale(String? value) async {
    await into(currentLocale).insertOnConflictUpdate(
      CurrentLocaleCompanion.insert(id: SingleRowTable.ID, currentLocale: Value(value)),
    );
  }

  Future<void> updateServerUrl(String? url) async {
    await into(serverUrl).insertOnConflictUpdate(
      ServerUrlCompanion.insert(id: SingleRowTable.ID, serverUrl: Value(url)),
    );
  }
}
