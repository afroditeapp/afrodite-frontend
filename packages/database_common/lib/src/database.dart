import 'package:database_common/src/read/app.dart';
import 'package:database_common/src/read/demo_account.dart';
import 'package:database_common/src/read/login_session.dart';
import 'package:database_common/src/write/app.dart';
import 'package:database_common/src/write/demo_account.dart';
import 'package:database_common/src/write/login_session.dart';
import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'schema.dart' as schema;

part 'database.g.dart';

/// Common app data which can be accessed when app is in foreground
@DriftDatabase(
  tables: [
    schema.DemoAccount,
    schema.ImageEncryptionKey,
    schema.NotificationPermissionAsked,
    schema.AccountId,
    schema.ServerUrl,
    schema.CurrentLocale,
  ],
  daos: [
    // Read
    DaoReadApp,
    DaoReadDemoAccount,
    DaoReadLoginSession,
    // Write
    DaoWriteApp,
    DaoWriteDemoAccount,
    DaoWriteLoginSession,
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
  DaoReadLoginSession get loginSession => db.daoReadLoginSession;
}

class CommonForegroundDatabaseWrite {
  final CommonForegroundDatabase db;
  CommonForegroundDatabaseWrite(this.db);
  DaoWriteDemoAccount get demoAccount => db.daoWriteDemoAccount;
  DaoWriteApp get app => db.daoWriteApp;
  DaoWriteLoginSession get loginSession => db.daoWriteLoginSession;
}
