import 'package:database_common_background/src/database.dart';
import 'package:drift/drift.dart';

part 'app.g.dart';

// All functionality moved to database_common_foreground
@DriftAccessor(tables: [])
class DaoReadApp extends DatabaseAccessor<CommonBackgroundDatabase> with _$DaoReadAppMixin {
  DaoReadApp(super.db);
}
