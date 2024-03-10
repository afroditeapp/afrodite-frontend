


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class MessageDatabase extends BaseDatabase {
  MessageDatabase._private();
  static final _instance = MessageDatabase._private();
  factory MessageDatabase.getInstance() {
    return _instance;
  }

  static const tableName = "messages";
  static const columId = "id";
  static const columLocalAccountUuid = "local_account_uuid";
  static const columRemoteAccountUuid = "remote_account_uuid";
  static const columMessageText = "message_text";
  static const columSentMessageState = "sent_message_state";
  static const columReceivedMessageState = "received_message_state";
  static const columMessageNumber = "message_number";
  static const columUnixTime = "unix_time";

  @override
  DatabaseType get databaseType => DatabaseType.chatMessages;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $tableName(
        $columId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columLocalAccountUuid TEXT NOT NULL,
        $columRemoteAccountUuid TEXT NOT NULL,
        $columMessageText TEXT NOT NULL,
        $columSentMessageState INTEGER,
        $columReceivedMessageState INTEGER,

        -- Server sends valid values for the next two fields.
        $columMessageNumber INTEGER,
        $columUnixTime INTEGER
      )
    """);
  }

  @override
  Future<void> init() async {
    // Create database or run migrations
    await getOrOpenDatabase(deleteBeforeOpenForDevelopment: false);

    // await clearProfiles();
    // final count = await profileCount();
    // if (count == null || count == 0) {
    //   await insertProfile(ProfileListEntry("default1", "default"));
    //   await insertProfile(ProfileListEntry("default2", "default"));
    //   await insertProfile(ProfileListEntry("default3", "default"));
    // }

    // final count2 = await profileCount();
    // final profiles = await getProfileList(1, count2!);
    // print(profiles);
  }

  Future<void> clear() async {
    await runAction((db) async {
      return await db.delete(tableName);
    });
  }

  /// Number of all messages in the database
  Future<int?> count() async {
    return await runAction((db) async {
      return firstIntValue(await db.query(tableName, columns: ["COUNT($columId)"]));
    });
  }

  /// Number of all messages in the database
  Future<int?> countMessagesInConversation(
    AccountId localAccountId,
    AccountId remoteAccountId,
  ) async {
    return await runAction((db) async {
      return firstIntValue(await db.query(
        tableName,
        columns: ["COUNT($columId)"],
        where: "$columLocalAccountUuid = ? AND $columRemoteAccountUuid = ?",
        whereArgs: [localAccountId.accountId, remoteAccountId.accountId],
      ));
    });
  }

  /// Returns ID of last inserted row if insert was successful.
  Future<int?> insert(MessageEntry entry) async {
    return await runAction((db) async {
      return await db.insert(tableName, entry.toMap());
    });
  }

  Future<bool> insertToBeSentMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    String messageText,
  ) async {
    final message = MessageEntry(
      localAccountId,
      remoteAccountId,
      messageText,
      sentMessageState: SentMessageState.pending,
    );
    final result = await insert(message);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  // Returns true if the insert was successful.
  Future<bool> insertPendingMessage(AccountId localAccountId, PendingMessage entry) async {
    final unixTime = DateTime.fromMillisecondsSinceEpoch(entry.unixTime.unixTime * 1000);
    final message = MessageEntry(
      localAccountId,
      entry.id.accountIdSender,
      entry.message,
      sentMessageState: null,
      receivedMessageState: ReceivedMessageState.waitingDeletionFromServer,
      messageNumber: entry.id.messageNumber,
      unixTime: unixTime,
    );
    final result = await insert(message);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateReceivedMessageState(
    AccountId localAccountId,
    AccountId remoteAccountId,
    MessageNumber messageNumber,
    ReceivedMessageState receivedMessageState,
  ) async {
    await runAction((db) async {
      return await db.update(
        tableName,
        {columReceivedMessageState: receivedMessageState.number},
        where: "$columLocalAccountUuid = ? AND $columRemoteAccountUuid = ? AND $columMessageNumber = ?",
        whereArgs: [localAccountId.accountId, remoteAccountId.accountId, messageNumber.messageNumber],
      );
    });
  }

  /// Get message with given index in a conversation.
  /// The index 0 is the latest message.
  Future<MessageEntry?> getMessage(
    AccountId localAccountId,
    AccountId remoteAccountId,
    int index,
  ) async {
    return await runAction((db) async {
      final result = await db.query(
        tableName,
        columns:
          [
            columId,
            columLocalAccountUuid,
            columRemoteAccountUuid,
            columMessageText,
            columSentMessageState,
            columReceivedMessageState,
            columMessageNumber,
            columUnixTime,
          ],
        where: "$columLocalAccountUuid = ? AND $columRemoteAccountUuid = ?",
        whereArgs: [localAccountId.accountId, remoteAccountId.accountId],
        orderBy: "$columId DESC",
        limit: 1,
        offset: index,
      );
      final list = result.map((e) {
        return MessageEntry.fromMap(e);
      }).toList();
      return list.firstOrNull;
    });
  }

  /// Get list of messages starting from startId. The next ID is smaller.
  Future<List<MessageEntry>> getMessageListByLocalMessageId(
    AccountId localAccountId,
    AccountId remoteAccountId,
    int startId,
    int limit,
  ) async {
    return await runAction((db) async {
      final result = await db.query(
        tableName,
        columns:
          [
            columId,
            columLocalAccountUuid,
            columRemoteAccountUuid,
            columMessageText,
            columSentMessageState,
            columReceivedMessageState,
            columMessageNumber,
            columUnixTime,
          ],
        where: "$columLocalAccountUuid = ? AND $columRemoteAccountUuid = ? AND $columId <= ?",
        whereArgs: [localAccountId.accountId, remoteAccountId.accountId, startId],
        orderBy: "$columId DESC",
        limit: limit,
      );
      final list = result.map((e) {
        return MessageEntry.fromMap(e);
      }).toList();
      return list;
    }) ?? [];
  }

  // Future<void> removeProfile(AccountId accountId) async {
  //   await runAction((db) async {
  //     return await db.delete(
  //       tableName,
  //       where: "uuid = ?",
  //       whereArgs: [accountId.accountId],
  //     );
  //   });
  // }

  // Future<void> updateMessage(AccountId accountId, Profile profile) async {
  //   await runAction((db) async {
  //     return await db.update(
  //       tableName,
  //       {"profile_text": profile.profileText},
  //       where: "uuid = ?",
  //       whereArgs: [accountId.accountId],
  //     );
  //   });
  // }

  // Future<MessageEntry?> getProfileEntry(AccountId accountId) async {
  //   return await runAction((db) async {
  //     final result = await db.query(
  //       tableName,
  //       columns: ["uuid", "image_uuid", "name", "profile_text"],
  //       where: "uuid = ?",
  //       whereArgs: [accountId.accountId],
  //     );
  //     final list = result.map((e) {
  //       return MessageEntry.fromMap(e);
  //     }).toList();
  //     return list.firstOrNull;
  //   });
  // }

  // Future<Profile?> getProfile(AccountId accountId) async {
  //   final entry = await getProfileEntry(accountId);
  //   if (entry != null) {
  //     return Profile(
  //       name: entry.name,
  //       profileText: entry.profileText,
  //       // TODO: save version?
  //       version: ProfileVersion(versionUuid: ""),
  //     );
  //   } else {
  //     return null;
  //   }
  // }

}

class MessageEntry {
  /// Local database ID of the message.
  /// This really is not null. Null is to avoid setting ID when inserting.
  final int? id;
  int get localId => id!;

  final AccountId localAccountId;
  final AccountId remoteAccountId;
  final String messageText;
  /// Null if message was received.
  final SentMessageState? sentMessageState;
  /// Null if message was sent.
  final ReceivedMessageState? receivedMessageState;
  /// Message number in a conversation. Server sets this value.
  final MessageNumber? messageNumber;
  /// Seconds since Unix epoch. Server sets this falue.
  final DateTime? unixTime;

  MessageEntry(
    this.localAccountId,
    this.remoteAccountId,
    this.messageText,
    {
      this.sentMessageState,
      this.receivedMessageState,
      this.messageNumber,
      this.unixTime,
      this.id,
    }
  );

  Map<String, Object?> toMap() {
    final unixTimeMilliseconds = unixTime?.millisecondsSinceEpoch;
    final unixTimeSeconds = unixTimeMilliseconds != null ? unixTimeMilliseconds ~/ 1000 : null;
    final map = {
      MessageDatabase.columLocalAccountUuid: localAccountId.accountId,
      MessageDatabase.columRemoteAccountUuid: remoteAccountId.accountId,
      MessageDatabase.columMessageText: messageText,
      MessageDatabase.columSentMessageState: sentMessageState?.number,
      MessageDatabase.columReceivedMessageState: receivedMessageState?.number,
      MessageDatabase.columMessageNumber: messageNumber?.messageNumber,
      MessageDatabase.columUnixTime: unixTimeSeconds,
    };
    if (id != null) {
      map[MessageDatabase.columId] = id;
    }
    return map;
  }

  factory MessageEntry.fromMap(Map<String, Object?> map) {
    final localAccountId = AccountId(accountId: map[MessageDatabase.columLocalAccountUuid] as String);
    final remoteAccountId = AccountId(accountId: map[MessageDatabase.columRemoteAccountUuid] as String);
    final messageText = map[MessageDatabase.columMessageText] as String;

    final sentMessageStateNumber = map[MessageDatabase.columSentMessageState] as int?;
    final SentMessageState? sentMessageState;
    if (sentMessageStateNumber != null) {
      sentMessageState = SentMessageState.values[sentMessageStateNumber];
    } else {
      sentMessageState = null;
    }

    final receivedMessageStateNumber = map[MessageDatabase.columReceivedMessageState] as int?;
    final ReceivedMessageState? receivedMessageState;
    if (receivedMessageStateNumber != null) {
      receivedMessageState = ReceivedMessageState.values[receivedMessageStateNumber];
    } else {
      receivedMessageState = null;
    }

    final messageNumberInt = map[MessageDatabase.columMessageNumber] as int?;
    final MessageNumber? messageNumber;
    if (messageNumberInt != null) {
      messageNumber = MessageNumber(messageNumber: messageNumberInt);
    } else {
      messageNumber = null;
    }

    final unixTimeSeconds = map[MessageDatabase.columUnixTime] as int?;
    final DateTime? unixTime;
    if (unixTimeSeconds != null) {
      unixTime = DateTime.fromMillisecondsSinceEpoch(unixTimeSeconds * 1000);
    } else {
      unixTime = null;
    }

    final id = map[MessageDatabase.columId] as int?;

    return MessageEntry(
      localAccountId,
      remoteAccountId,
      messageText,
      sentMessageState: sentMessageState,
      receivedMessageState: receivedMessageState,
      messageNumber: messageNumber,
      unixTime: unixTime,
      id: id,
    );
  }


  @override
  String toString() {
    return "MessageEntry(id: $id, localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime)";
  }
}

enum SentMessageState {
  /// Waiting to be sent to server.
  pending(0),
  /// Sent to server, but not yet received by the other user.
  sent(1),
  /// Received by the other user.
  received(2),
  /// Read by the other user.
  read(3),
  /// Sending failed.
  sendingError(4);

  const SentMessageState(this.number);
  final int number;
}

enum ReceivedMessageState {
  /// Waiting to be deleted from server.
  waitingDeletionFromServer(0),
  /// Message is deleted from server.
  deletedFromServer(1);

  const ReceivedMessageState(this.number);
  final int number;
}
