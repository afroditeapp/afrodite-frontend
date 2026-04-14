import 'package:database_common/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart' as api;

import '../schema.dart' as schema;

part 'app.g.dart';

@DriftAccessor(
  tables: [
    schema.NotificationPermissionAsked,
    schema.VideoCallTipShown,
    schema.CurrentLocale,
    schema.ServerUrl,
    schema.ClientVersionInfo,
  ],
)
class DaoWriteApp extends DatabaseAccessor<CommonDatabase> with _$DaoWriteAppMixin {
  DaoWriteApp(super.db);

  Future<void> updateClientVersionInfo(api.ClientVersion value) async {
    final existingVersion = await (select(
      clientVersionInfo,
    )..where((table) => table.id.equals(SingleRowTable.ID.value))).getSingleOrNull();

    if (existingVersion != null &&
        existingVersion.majorVersion == value.major &&
        existingVersion.minorVersion == value.minor &&
        existingVersion.patchVersion == value.patch_) {
      return;
    }

    await into(clientVersionInfo).insertOnConflictUpdate(
      ClientVersionInfoCompanion.insert(
        id: SingleRowTable.ID,
        majorVersion: value.major,
        minorVersion: value.minor,
        patchVersion: value.patch_,
      ),
    );
  }

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
