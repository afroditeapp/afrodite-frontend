import 'package:database_common_background/src/database.dart';
import 'package:drift/drift.dart';

part 'login_session.g.dart';

// All functionality moved to database_common_foreground
@DriftAccessor(tables: [])
class DaoReadLoginSession extends DatabaseAccessor<CommonBackgroundDatabase>
    with _$DaoReadLoginSessionMixin {
  DaoReadLoginSession(super.db);
}
