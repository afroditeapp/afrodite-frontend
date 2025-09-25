import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';

class LocalAccountId extends Table {
  IntColumn get id => integer().map(const LocalAccountIdConverter()).autoIncrement()();
  TextColumn get uuid => text().map(const AccountIdConverter()).unique()();
}

class AccountId extends SingleRowTable {
  TextColumn get accountId => text().map(const AccountIdConverter())();
}

class AccountState extends SingleRowTable {
  TextColumn get jsonAccountState =>
      text().map(NullAwareTypeConverter.wrap(const AccountStateContainerConverter())).nullable()();
}

class Permissions extends SingleRowTable {
  TextColumn get jsonPermissions =>
      text().map(NullAwareTypeConverter.wrap(const PermissionsConverter())).nullable()();
}

class ProfileVisibility extends SingleRowTable {
  TextColumn get jsonProfileVisibility =>
      text().map(NullAwareTypeConverter.wrap(const ProfileVisibilityConverter())).nullable()();
}

class ClientId extends SingleRowTable {
  IntColumn get clientId =>
      integer().map(const NullAwareTypeConverter.wrap(ClientIdConverter())).nullable()();
}

class EmailAddress extends SingleRowTable {
  TextColumn get emailAddress => text().nullable()();
}

class LoginSessionTokens extends SingleRowTable {
  TextColumn get refreshToken =>
      text().map(NullAwareTypeConverter.wrap(RefreshTokenConverter())).nullable()();
  TextColumn get accessToken =>
      text().map(NullAwareTypeConverter.wrap(AccessTokenConverter())).nullable()();
}
