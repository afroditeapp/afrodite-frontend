import 'package:database_common/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

import '../schema.dart' as schema;

part 'login_session.g.dart';

@DriftAccessor(tables: [schema.AccountId])
class DaoWriteLoginSession extends DatabaseAccessor<CommonDatabase>
    with _$DaoWriteLoginSessionMixin {
  DaoWriteLoginSession(super.db);

  Future<void> login(AccountId id) async {
    await into(accountId).insertOnConflictUpdate(
      AccountIdCompanion.insert(id: SingleRowTable.ID, accountId: Value(id)),
    );
  }

  Future<void> logout() async {
    await into(accountId).insertOnConflictUpdate(
      AccountIdCompanion.insert(id: SingleRowTable.ID, accountId: Value(null)),
    );
  }
}
