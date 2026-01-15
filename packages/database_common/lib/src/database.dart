import 'package:database_common/src/read/app.dart';
import 'package:database_common/src/read/demo_account.dart';
import 'package:database_common/src/read/login_session.dart';
import 'package:database_common/src/read/general_cache.dart';
import 'package:database_common/src/write/app.dart';
import 'package:database_common/src/write/demo_account.dart';
import 'package:database_common/src/write/login_session.dart';
import 'package:database_common/src/write/general_cache.dart';
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
    schema.NotificationPermissionAsked,
    schema.AccountId,
    schema.ServerUrl,
    schema.CurrentLocale,
    schema.GeneralCache,
  ],
  daos: [
    // Read
    DaoReadApp,
    DaoReadDemoAccount,
    DaoReadLoginSession,
    DaoReadGeneralCache,
    // Write
    DaoWriteApp,
    DaoWriteDemoAccount,
    DaoWriteLoginSession,
    DaoWriteGeneralCache,
  ],
)
class CommonDatabase extends _$CommonDatabase {
  CommonDatabase(QueryExcecutorProvider dbProvider) : super(dbProvider.getQueryExcecutor());

  CommonDatabaseRead get read => CommonDatabaseRead(this);
  CommonDatabaseWrite get write => CommonDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class CommonDatabaseRead {
  final CommonDatabase db;
  CommonDatabaseRead(this.db);
  DaoReadDemoAccount get demoAccount => db.daoReadDemoAccount;
  DaoReadApp get app => db.daoReadApp;
  DaoReadLoginSession get loginSession => db.daoReadLoginSession;
  DaoReadGeneralCache get generalCache => db.daoReadGeneralCache;
}

class CommonDatabaseWrite {
  final CommonDatabase db;
  CommonDatabaseWrite(this.db);
  DaoWriteDemoAccount get demoAccount => db.daoWriteDemoAccount;
  DaoWriteApp get app => db.daoWriteApp;
  DaoWriteLoginSession get loginSession => db.daoWriteLoginSession;
  DaoWriteGeneralCache get generalCache => db.daoWriteGeneralCache;
}
