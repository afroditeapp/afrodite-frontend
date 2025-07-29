
import 'package:drift/drift.dart';
import 'package:database_utils/database_utils.dart';

part 'common_database.g.dart';

const COMMON_DB_DATA_ID = Value(0);
const NOTIFICATION_PERMISSION_ASKED_DEFAULT = false;

class Common extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get demoAccountUsername => text().nullable()();
  TextColumn get demoAccountPassword => text().nullable()();
  TextColumn get demoAccountToken => text().nullable()();
  BlobColumn get imageEncryptionKey => blob().nullable()();

  /// If true don't show notification permission asking dialog when
  /// app main view (bottom navigation is visible) is opened.
  BoolColumn get notificationPermissionAsked => boolean()
    .withDefault(const Constant(NOTIFICATION_PERMISSION_ASKED_DEFAULT))();

  /// If true info dialog about chat has been shown when
  /// chat list screen (bottom navigation is visible) is opened.
  BoolColumn get chatInfoDialogShown => boolean()
    .withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Common])
class CommonDatabase extends _$CommonDatabase {
  CommonDatabase(QueryExcecutorProvider dbProvider) :
    super(dbProvider.getQueryExcecutor());

  @override
  int get schemaVersion => 1;

  Future<void> updateDemoAccountUsername(String? username) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        demoAccountUsername: Value(username),
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

  Future<void> updateChatInfoDialogShown(bool value) async {
    await into(common).insertOnConflictUpdate(
      CommonCompanion.insert(
        id: COMMON_DB_DATA_ID,
        chatInfoDialogShown: Value(value),
      ),
    );
  }

  Stream<String?> watchDemoAccountUsername() =>
    watchColumn((r) => r.demoAccountUsername);

  Stream<String?> watchDemoAccountPassword() =>
    watchColumn((r) => r.demoAccountPassword);

  Stream<String?> watchDemoAccountToken() =>
    watchColumn((r) => r.demoAccountToken);

  Stream<Uint8List?> watchImageEncryptionKey() =>
    watchColumn((r) => r.imageEncryptionKey);

  Stream<bool?> watchNotificationPermissionAsked() =>
    watchColumn((r) => r.notificationPermissionAsked);

  Stream<bool?> watchChatInfoDialogShown() =>
    watchColumn((r) => r.chatInfoDialogShown);

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
