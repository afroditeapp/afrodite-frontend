import 'package:database_common/src/database.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

import '../schema.dart' as schema;

part 'demo_account.g.dart';

@DriftAccessor(tables: [schema.DemoAccount])
class DaoReadDemoAccount extends DatabaseAccessor<CommonForegroundDatabase>
    with _$DaoReadDemoAccountMixin {
  DaoReadDemoAccount(super.db);

  Stream<String?> watchDemoAccountUsername() =>
      _watchDemoAccountColumn((r) => r.demoAccountUsername);

  Stream<String?> watchDemoAccountPassword() =>
      _watchDemoAccountColumn((r) => r.demoAccountPassword);

  Stream<String?> watchDemoAccountToken() => _watchDemoAccountColumn((r) => r.demoAccountToken);

  Stream<T?> _watchDemoAccountColumn<T extends Object>(T? Function(DemoAccountData) extractColumn) {
    return (select(
      demoAccount,
    )..where((t) => t.id.equals(SingleRowTable.ID.value))).map(extractColumn).watchSingleOrNull();
  }
}
