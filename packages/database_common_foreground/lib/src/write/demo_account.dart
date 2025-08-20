import 'package:database_common_foreground/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'demo_account.g.dart';

@DriftAccessor(tables: [schema.DemoAccount])
class DaoWriteDemoAccount extends DatabaseAccessor<CommonForegroundDatabase>
    with _$DaoWriteDemoAccountMixin {
  DaoWriteDemoAccount(super.db);

  Future<void> updateDemoAccountUsername(String? username) async {
    await into(demoAccount).insertOnConflictUpdate(
      DemoAccountCompanion.insert(id: SingleRowTable.ID, demoAccountUsername: Value(username)),
    );
  }

  Future<void> updateDemoAccountPassword(String? password) async {
    await into(demoAccount).insertOnConflictUpdate(
      DemoAccountCompanion.insert(id: SingleRowTable.ID, demoAccountPassword: Value(password)),
    );
  }

  Future<void> updateDemoAccountToken(String? token) async {
    await into(demoAccount).insertOnConflictUpdate(
      DemoAccountCompanion.insert(id: SingleRowTable.ID, demoAccountToken: Value(token)),
    );
  }
}
