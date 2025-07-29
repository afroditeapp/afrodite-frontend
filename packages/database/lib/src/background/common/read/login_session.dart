
import 'package:database/src/background/common/database.dart';
import 'package:database/src/utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

import '../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(
  tables: [
    schema.AccountId,
    schema.PushNotification,
  ]
)
class DaoReadLoginSession extends DatabaseAccessor<CommonBackgroundDatabase> with _$DaoReadLoginSessionMixin {
  DaoReadLoginSession(super.db);

  Stream<AccountId?> watchAccountId() =>
    _watchAccountIdColumn((r) => r.uuidAccountId);

  Stream<FcmDeviceToken?> watchFcmDeviceToken() =>
    _watchPushNotificationColumn((r) => r.fcmDeviceToken);

  Stream<PendingNotificationToken?> watchPendingNotificationToken() =>
    _watchPushNotificationColumn((r) => r.pendingNotificationToken);

  Stream<T?> _watchAccountIdColumn<T extends Object>(T? Function(AccountIdData) extractColumn) {
    return (select(accountId)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }

  Stream<T?> _watchPushNotificationColumn<T extends Object>(T? Function(PushNotificationData) extractColumn) {
    return (select(pushNotification)..where((t) => t.id.equals(SingleRowTable.ID.value)))
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
