import 'package:database_converter/database_converter.dart';
import 'package:database_utils/database_utils.dart';
import 'package:drift/drift.dart';


class AccountId extends SingleRowTable {
  TextColumn get uuidAccountId => text().map(const NullAwareTypeConverter.wrap(AccountIdConverter())).nullable()();
}

class AccountState extends SingleRowTable {
  TextColumn get jsonAccountState => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
}

class Permissions extends SingleRowTable {
  TextColumn get jsonPermissions => text().map(NullAwareTypeConverter.wrap(JsonString.driftConverter)).nullable()();
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
  TextColumn get refreshTokenAccount => text().map(NullAwareTypeConverter.wrap(RefreshTokenConverter())).nullable()();
  TextColumn get refreshTokenMedia => text().map(NullAwareTypeConverter.wrap(RefreshTokenConverter())).nullable()();
  TextColumn get refreshTokenProfile => text().map(NullAwareTypeConverter.wrap(RefreshTokenConverter())).nullable()();
  TextColumn get refreshTokenChat => text().map(NullAwareTypeConverter.wrap(RefreshTokenConverter())).nullable()();
  TextColumn get accessTokenAccount => text().map(NullAwareTypeConverter.wrap(AccessTokenConverter())).nullable()();
  TextColumn get accessTokenMedia => text().map(NullAwareTypeConverter.wrap(AccessTokenConverter())).nullable()();
  TextColumn get accessTokenProfile => text().map(NullAwareTypeConverter.wrap(AccessTokenConverter())).nullable()();
  TextColumn get accessTokenChat => text().map(NullAwareTypeConverter.wrap(AccessTokenConverter())).nullable()();
}
