import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';


class AccountId extends SingleRowTable {
  TextColumn get accountId => text().map(const AccountIdConverter())();
}

class AccountState extends SingleRowTable {
  TextColumn get jsonAccountState => text().map(NullAwareTypeConverter.wrap(const AccountStateContainerConverter())).nullable()();
}

class Permissions extends SingleRowTable {
  TextColumn get jsonPermissions => text().map(NullAwareTypeConverter.wrap(const PermissionsConverter())).nullable()();
}

class ProfileVisibility extends SingleRowTable {
  TextColumn get jsonProfileVisibility => text().map(NullAwareTypeConverter.wrap(EnumString.driftConverter)).nullable()();
}

class ClientId extends SingleRowTable {
  IntColumn get clientId => integer().map(const NullAwareTypeConverter.wrap(ClientIdConverter())).nullable()();
}

class AccountEmailAddress extends SingleRowTable {
  TextColumn get accountEmailAddress => text().nullable()();
}

class LoginSessionTokens extends SingleRowTable {
  TextColumn get refreshToken => text().map(NullAwareTypeConverter.wrap(RefreshTokenConverter())).nullable()();
  TextColumn get accessToken => text().map(NullAwareTypeConverter.wrap(AccessTokenConverter())).nullable()();
}
