import 'package:database_common_background/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

import '../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(tables: [schema.AccountId, schema.PushNotification])
class DaoWriteLoginSession extends DatabaseAccessor<CommonBackgroundDatabase>
    with _$DaoWriteLoginSessionMixin {
  DaoWriteLoginSession(super.db);

  Future<void> login(AccountId id) async {
    await transaction(() async {
      await into(accountId).insertOnConflictUpdate(
        AccountIdCompanion.insert(id: SingleRowTable.ID, accountId: Value(id)),
      );
      await into(pushNotification).insertOnConflictUpdate(
        PushNotificationCompanion.insert(
          id: SingleRowTable.ID,
          fcmDeviceToken: Value(null),
          pendingNotificationToken: Value(null),
        ),
      );
    });
  }

  Future<void> logout() async {
    await transaction(() async {
      await into(accountId).insertOnConflictUpdate(
        AccountIdCompanion.insert(id: SingleRowTable.ID, accountId: Value(null)),
      );
      await into(pushNotification).insertOnConflictUpdate(
        PushNotificationCompanion.insert(
          id: SingleRowTable.ID,
          fcmDeviceToken: Value(null),
          pendingNotificationToken: Value(null),
        ),
      );
    });
  }

  Future<void> updateFcmDeviceTokenAndPendingNotificationToken(
    FcmDeviceToken? token,
    PendingNotificationToken? notificationToken,
  ) async {
    await into(pushNotification).insertOnConflictUpdate(
      PushNotificationCompanion.insert(
        id: SingleRowTable.ID,
        fcmDeviceToken: Value(token),
        pendingNotificationToken: Value(notificationToken),
      ),
    );
  }
}
