import 'package:async/async.dart';
import 'package:database_account_background/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

import '../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(tables: [schema.AccountId, schema.PushNotification])
class DaoWriteLoginSession extends DatabaseAccessor<AccountBackgroundDatabase>
    with _$DaoWriteLoginSessionMixin {
  DaoWriteLoginSession(super.db);

  Future<void> setAccountIdIfNull(AccountId id) async {
    await transaction(() async {
      final currentAccountId = await db.read.loginSession.watchAccountId().firstOrNull;
      if (currentAccountId == null) {
        await into(
          accountId,
        ).insertOnConflictUpdate(AccountIdCompanion.insert(id: SingleRowTable.ID, accountId: id));
      }
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
