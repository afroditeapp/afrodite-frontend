import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class PushNotificationDeviceTokenConverter
    extends TypeConverter<PushNotificationDeviceToken, String> {
  const PushNotificationDeviceTokenConverter();

  @override
  PushNotificationDeviceToken fromSql(fromDb) {
    return PushNotificationDeviceToken(token: fromDb);
  }

  @override
  String toSql(value) {
    return value.token;
  }
}

class VapidPublicKeyConverter extends TypeConverter<VapidPublicKey, String> {
  const VapidPublicKeyConverter();

  @override
  VapidPublicKey fromSql(fromDb) {
    return VapidPublicKey(key: fromDb);
  }

  @override
  String toSql(value) {
    return value.key;
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
