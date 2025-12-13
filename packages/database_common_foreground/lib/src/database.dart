import 'package:database_common_foreground/src/read/app.dart';
import 'package:database_common_foreground/src/read/demo_account.dart';
import 'package:database_common_foreground/src/write/app.dart';
import 'package:database_common_foreground/src/write/demo_account.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'schema.dart' as schema;

part 'database.g.dart';

/// Common app data which can be accessed when app is in foreground
@DriftDatabase(
  tables: [schema.DemoAccount, schema.ImageEncryptionKey, schema.NotificationPermissionAsked],
  daos: [
    // Read
    DaoReadApp,
    DaoReadDemoAccount,
    // Write
    DaoWriteApp,
    DaoWriteDemoAccount,
  ],
)
class CommonForegroundDatabase extends _$CommonForegroundDatabase {
  CommonForegroundDatabase(QueryExcecutorProvider dbProvider)
    : super(dbProvider.getQueryExcecutor());

  CommonForegroundDatabaseRead get read => CommonForegroundDatabaseRead(this);
  CommonForegroundDatabaseWrite get write => CommonForegroundDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class CommonForegroundDatabaseRead {
  final CommonForegroundDatabase db;
  CommonForegroundDatabaseRead(this.db);
  DaoReadDemoAccount get demoAccount => db.daoReadDemoAccount;
  DaoReadApp get app => db.daoReadApp;
}

class CommonForegroundDatabaseWrite {
  final CommonForegroundDatabase db;
  CommonForegroundDatabaseWrite(this.db);
  DaoWriteDemoAccount get demoAccount => db.daoWriteDemoAccount;
  DaoWriteApp get app => db.daoWriteApp;
}
