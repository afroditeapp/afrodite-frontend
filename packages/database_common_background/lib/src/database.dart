import 'package:database_common_background/src/read/login_session.dart';
import 'package:database_common_background/src/read/app.dart';
import 'package:database_common_background/src/write/login_session.dart';
import 'package:database_common_background/src/write/app.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

part 'database.g.dart';

/// Common app data which can be accessed when app is in background
@DriftDatabase(
  tables: [],
  daos: [
    // Read
    DaoReadApp,
    DaoReadLoginSession,
    // Write
    DaoWriteApp,
    DaoWriteLoginSession,
  ],
)
class CommonBackgroundDatabase extends _$CommonBackgroundDatabase {
  CommonBackgroundDatabase(QueryExcecutorProvider dbProvider)
    : super(dbProvider.getQueryExcecutor());

  CommonBackgroundDatabaseRead get read => CommonBackgroundDatabaseRead(this);
  CommonBackgroundDatabaseWrite get write => CommonBackgroundDatabaseWrite(this);

  @override
  int get schemaVersion => 1;
}

class CommonBackgroundDatabaseRead {
  final CommonBackgroundDatabase db;
  CommonBackgroundDatabaseRead(this.db);
  DaoReadLoginSession get loginSession => db.daoReadLoginSession;
  DaoReadApp get app => db.daoReadApp;
}

class CommonBackgroundDatabaseWrite {
  final CommonBackgroundDatabase db;
  CommonBackgroundDatabaseWrite(this.db);
  DaoWriteLoginSession get loginSession => db.daoWriteLoginSession;
  DaoWriteApp get app => db.daoWriteApp;
}
