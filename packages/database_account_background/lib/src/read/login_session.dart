import 'package:database_account_background/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

import '../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(tables: [schema.AccountId, schema.PushNotification])
class DaoReadLoginSession extends DatabaseAccessor<AccountBackgroundDatabase>
    with _$DaoReadLoginSessionMixin {
  DaoReadLoginSession(super.db);

  Stream<AccountId?> watchAccountId() => _watchAccountIdColumn((r) => r.accountId);

  Stream<T?> _watchAccountIdColumn<T extends Object>(T? Function(AccountIdData) extractColumn) {
    return (select(
      accountId,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }

  Stream<PushNotificationDeviceToken?> watchPushNotificationDeviceToken() =>
      _watchPushNotificationColumn((r) => r.pushNotificationDeviceToken);

  Stream<VapidPublicKey?> watchVapidPublicKey() =>
      _watchPushNotificationColumn((r) => r.vapidPublicKey);

  Stream<PushNotificationEncryptionKey?> watchPushNotificationEncryptionKey() =>
      _watchPushNotificationColumn((r) => r.pushNotificationEncryptionKey);

  Stream<int?> watchPushNotificationInfoSyncVersion() =>
      _watchPushNotificationColumn((r) => r.syncVersionPushNotificationInfo);

  Stream<T?> _watchPushNotificationColumn<T extends Object>(
    T? Function(PushNotificationData) extractColumn,
  ) {
    return (select(
      pushNotification,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
