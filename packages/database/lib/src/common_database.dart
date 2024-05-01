

import 'package:async/async.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'utils.dart';

part 'common_database.g.dart';

const COMMON_DB_DATA_ID = Value(0);
const NOTIFICATION_PERMISSION_ASKED_DEFAULT = false;

class Common extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get demoAccountUserId => text().nullable()();
  TextColumn get demoAccountPassword => text().nullable()();
  TextColumn get demoAccountToken => text().nullable()();
  TextColumn get serverUrlAccount => text().nullable()();
  TextColumn get serverUrlMedia => text().nullable()();
  TextColumn get serverUrlProfile => text().nullable()();
  TextColumn get serverUrlChat => text().nullable()();
  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
  BlobColumn get imageEncryptionKey => blob().nullable()();

  /// Notification session ID prevents running notification payloads related to
  /// other accounts.
  IntColumn get notificationSessionId => integer().map(const NullAwareTypeConverter.wrap(NotificationSessionIdConverter())).nullable()();

  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  BoolColumn get notificationPermissionAsked => boolean()
    .withDefault(const Constant(NOTIFICATION_PERMISSION_ASKED_DEFAULT))();
}

@DriftDatabase(tables: [Common])
class CommonDatabase extends _$CommonDatabase {
  CommonDatabase(LazyDatabaseProvider dbProvider) :
    super(dbProvider.getLazyDatabase());

  @override
  int get schemaVersion => 1;

  Future<void> updateDemoAccountUserId(String? userId) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountUserId: Value(userId),
      ),
    );
  }

  Future<void> updateDemoAccountPassword(String? password) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountPassword: Value(password),
      ),
    );
  }

  Future<void> updateDemoAccountToken(String? token) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountToken: Value(token),
      ),
    );
  }

  Future<void> updateServerUrlAccount(String? url) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        serverUrlAccount: Value(url),
      ),
    );
  }

  Future<void> updateAccountIdUseOnlyFromDatabaseManager(AccountId? id) async {
    await transaction(() async {
      Value<NotificationSessionId?> updateNotificationSessionValueIfNeeded = const Value.absent();
      final currentAccountId = await watchAccountId().firstOrNull;
      if (currentAccountId != id) {
        final currentNotificationSessionId = await watchNotificationSessionId().firstOrNull;
        final nextId = (currentNotificationSessionId?.id ?? 0) + 1;
        updateNotificationSessionValueIfNeeded = Value(NotificationSessionId(id: nextId));
      }

      await into(common).insertOnConflictUpdate(
        CommonCompanion.insert(
          id: COMMON_DB_DATA_ID,
          uuidAccountId: Value(id),
          notificationSessionId: updateNotificationSessionValueIfNeeded,
        ),
      );
    });
  }

  Future<void> updateImageEncryptionKey(Uint8List key) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        imageEncryptionKey: Value(key),
      ),
    );
  }

  Future<void> updateNotificationPermissionAsked(bool value) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        notificationPermissionAsked: Value(value),
      ),
    );
  }

  Stream<String?> watchDemoAccountUserId() =>
    watchColumn((r) => r.demoAccountUserId);

  Stream<String?> watchDemoAccountPassword() =>
    watchColumn((r) => r.demoAccountPassword);

  Stream<String?> watchDemoAccountToken() =>
    watchColumn((r) => r.demoAccountToken);

  Stream<String?> watchServerUrlAccount() =>
    watchColumn((r) => r.serverUrlAccount);

  Stream<String?> watchServerUrlMedia() =>
    watchColumn((r) => r.serverUrlMedia);

  Stream<String?> watchServerUrlProfile() =>
    watchColumn((r) => r.serverUrlProfile);

  Stream<String?> watchServerUrlChat() =>
    watchColumn((r) => r.serverUrlChat);

  Stream<AccountId?> watchAccountId() =>
    watchColumn((r) => r.uuidAccountId);

  Stream<Uint8List?> watchImageEncryptionKey() =>
    watchColumn((r) => r.imageEncryptionKey);

  Stream<bool?> watchNotificationPermissionAsked() =>
    watchColumn((r) => r.notificationPermissionAsked);

  Stream<NotificationSessionId?> watchNotificationSessionId() =>
    watchColumn((r) => r.notificationSessionId);

  SimpleSelectStatement<$CommonTable, CommonData> _selectFromDataId() {
    return select(common)
      ..where((t) => t.id.equals(COMMON_DB_DATA_ID.value));
  }

  Stream<T?> watchColumn<T extends Object>(T? Function(CommonData) extractColumn) {
    return _selectFromDataId()
      .map(extractColumn)
      .watchSingleOrNull();
  }
}
