
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

class CustomReportsFileHashConverter extends TypeConverter<CustomReportsFileHash, String> {
  const CustomReportsFileHashConverter();

  @override
  CustomReportsFileHash fromSql(fromDb) {
    return CustomReportsFileHash(h: fromDb);
  }

  @override
  String toSql(value) {
    return value.h;
  }
}

class ClientFeaturesFileHashConverter  extends TypeConverter<ClientFeaturesFileHash, String> {
  const ClientFeaturesFileHashConverter();

  @override
  ClientFeaturesFileHash fromSql(fromDb) {
    return ClientFeaturesFileHash(h: fromDb);
  }

  @override
  String toSql(value) {
    return value.h;
  }
}

class ClientIdConverter extends TypeConverter<ClientId, int> {
  const ClientIdConverter();

  @override
  ClientId fromSql(fromDb) {
    return ClientId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
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
