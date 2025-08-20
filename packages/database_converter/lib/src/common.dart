import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class FcmDeviceTokenConverter extends TypeConverter<FcmDeviceToken, String> {
  const FcmDeviceTokenConverter();

  @override
  FcmDeviceToken fromSql(fromDb) {
    return FcmDeviceToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class PendingNotificationTokenConverter extends TypeConverter<PendingNotificationToken, String> {
  const PendingNotificationTokenConverter();

  @override
  PendingNotificationToken fromSql(fromDb) {
    return PendingNotificationToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class ClientLanguageConverter extends TypeConverter<ClientLanguage, String> {
  const ClientLanguageConverter();

  @override
  ClientLanguage fromSql(fromDb) {
    return ClientLanguage(l: fromDb);
  }

  @override
  String toSql(value) {
    return value.l;
  }
}
