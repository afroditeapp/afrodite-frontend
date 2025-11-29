import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class AccountIdConverter extends TypeConverter<AccountId, String> {
  const AccountIdConverter();

  @override
  AccountId fromSql(fromDb) {
    return AccountId(aid: fromDb);
  }

  @override
  String toSql(value) {
    return value.aid;
  }
}

class LocalAccountIdConverter extends TypeConverter<LocalAccountId, int> {
  const LocalAccountIdConverter();

  @override
  LocalAccountId fromSql(fromDb) {
    return LocalAccountId(fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class AccessTokenConverter extends TypeConverter<AccessToken, String> {
  const AccessTokenConverter();

  @override
  AccessToken fromSql(fromDb) {
    return AccessToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class RefreshTokenConverter extends TypeConverter<RefreshToken, String> {
  const RefreshTokenConverter();

  @override
  RefreshToken fromSql(fromDb) {
    return RefreshToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class CustomReportsConfigHashConverter extends TypeConverter<CustomReportsConfigHash, String> {
  const CustomReportsConfigHashConverter();

  @override
  CustomReportsConfigHash fromSql(fromDb) {
    return CustomReportsConfigHash(h: fromDb);
  }

  @override
  String toSql(value) {
    return value.h;
  }
}

class ClientFeaturesConfigHashConverter extends TypeConverter<ClientFeaturesConfigHash, String> {
  const ClientFeaturesConfigHashConverter();

  @override
  ClientFeaturesConfigHash fromSql(fromDb) {
    return ClientFeaturesConfigHash(h: fromDb);
  }

  @override
  String toSql(value) {
    return value.h;
  }
}

class UnreadNewsCountConverter extends TypeConverter<UnreadNewsCount, int> {
  const UnreadNewsCountConverter();

  @override
  UnreadNewsCount fromSql(fromDb) {
    return UnreadNewsCount(c: fromDb);
  }

  @override
  int toSql(value) {
    return value.c;
  }
}
