import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class AccountId extends SingleRowTable {
  TextColumn get accountId =>
      text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
}

class ServerUrl extends SingleRowTable {
  TextColumn get serverUrl => text().nullable()();
}

class CurrentLocale extends SingleRowTable {
  TextColumn get currentLocale => text().nullable()();
}
