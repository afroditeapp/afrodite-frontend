
import 'package:database_model/database_model.dart';
import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class MessageIdConverter extends TypeConverter<MessageId, int> {
  const MessageIdConverter();

  @override
  MessageId fromSql(fromDb) {
    return MessageId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class ReceivedLikesIteratorSessionIdConverter extends TypeConverter<ReceivedLikesIteratorSessionId, int> {
  const ReceivedLikesIteratorSessionIdConverter();

  @override
  ReceivedLikesIteratorSessionId fromSql(fromDb) {
    return ReceivedLikesIteratorSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class MatchesIteratorSessionIdConverter extends TypeConverter<MatchesIteratorSessionId, int> {
  const MatchesIteratorSessionIdConverter();

  @override
  MatchesIteratorSessionId fromSql(fromDb) {
    return MatchesIteratorSessionId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class PublicKeyIdConverter extends TypeConverter<PublicKeyId, int> {
  const PublicKeyIdConverter();

  @override
  PublicKeyId fromSql(fromDb) {
    return PublicKeyId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}

class PrivateKeyBytesConverter extends TypeConverter<PrivateKeyBytes, Uint8List> {
  const PrivateKeyBytesConverter();

  @override
  PrivateKeyBytes fromSql(fromDb) {
    return PrivateKeyBytes(data: fromDb);
  }

  @override
  Uint8List toSql(value) {
    return value.data;
  }
}

class PublicKeyBytesConverter extends TypeConverter<PublicKeyBytes, Uint8List> {
  const PublicKeyBytesConverter();

  @override
  PublicKeyBytes fromSql(fromDb) {
    return PublicKeyBytes(data: fromDb);
  }

  @override
  Uint8List toSql(value) {
    return value.data;
  }
}

class ConversationIdConverter extends TypeConverter<ConversationId, int> {
  const ConversationIdConverter();

  @override
  ConversationId fromSql(fromDb) {
    return ConversationId(id: fromDb);
  }

  @override
  int toSql(value) {
    return value.id;
  }
}


class NewReceivedLikesCountConverter extends TypeConverter<NewReceivedLikesCount, int> {
  const NewReceivedLikesCountConverter();

  @override
  NewReceivedLikesCount fromSql(fromDb) {
    return NewReceivedLikesCount(c: fromDb);
  }

  @override
  int toSql(value) {
    return value.c;
  }
}


class UnreadMessagesCountConverter extends TypeConverter<UnreadMessagesCount, int> {
  const UnreadMessagesCountConverter();

  @override
  UnreadMessagesCount fromSql(fromDb) {
    return UnreadMessagesCount(fromDb);
  }

  @override
  int toSql(value) {
    return value.count;
  }
}

class MessageConverter extends TypeConverter<Message, Uint8List> {
  const MessageConverter();

  @override
  Message fromSql(fromDb) {
    return Message.parseFromBytes(fromDb);
  }

  @override
  Uint8List toSql(value) {
    return value.toMessagePacket();
  }
}
