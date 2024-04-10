


import 'package:drift/drift.dart';
import 'package:openapi/api.dart';
import 'package:utils/utils.dart';


abstract class LazyDatabaseProvider {
  LazyDatabase getLazyDatabase();
}

class AccountIdConverter extends TypeConverter<AccountId, String> {
  const AccountIdConverter();

  @override
  AccountId fromSql(fromDb) {
    return AccountId(accountId: fromDb);
  }

  @override
  String toSql(value) {
    return value.accountId;
  }
}

class ContentIdConverter extends TypeConverter<ContentId, String> {
  const ContentIdConverter();

  @override
  ContentId fromSql(fromDb) {
    return ContentId(contentId: fromDb);
  }

  @override
  String toSql(value) {
    return value.contentId;
  }
}

class MessageNumberConverter extends TypeConverter<MessageNumber, int> {
  const MessageNumberConverter();

  @override
  MessageNumber fromSql(fromDb) {
    return MessageNumber(messageNumber: fromDb);
  }

  @override
  int toSql(value) {
    return value.messageNumber;
  }
}

class UtcDateTimeConverter extends TypeConverter<UtcDateTime, int> {
  const UtcDateTimeConverter();

  @override
  UtcDateTime fromSql(fromDb) {
    return UtcDateTime.fromUnixEpochMilliseconds(fromDb);
  }

  @override
  int toSql(value) {
    return value.toUnixEpochMilliseconds();
  }
}
