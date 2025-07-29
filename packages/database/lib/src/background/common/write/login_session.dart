
import 'package:database/src/background/common/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

import '../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(
  tables: [
    schema.AccountId,
    schema.PushNotification,
  ],
)
class DaoWriteLoginSession extends DatabaseAccessor<CommonBackgroundDatabase> with _$DaoWriteLoginSessionMixin {
  DaoWriteLoginSession(super.db);

  Future<void> updateAccountIdUseOnlyFromDatabaseManager(AccountId? id) async {
    await into(accountId).insertOnConflictUpdate(
      AccountIdCompanion.insert(
        id: SingleRowTable.ID,
        uuidAccountId: Value(id),
      ),
    );
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
