


import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/base_database.dart';
import 'package:pihka_frontend/database/favorite_profiles_database.dart';
import 'package:pihka_frontend/database/profile_list_database.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class MessageDatabase extends BaseDatabase {
  MessageDatabase._private();
  static final _instance = MessageDatabase._private();
  factory MessageDatabase.getInstance() {
    return _instance;
  }

  static const tableName = "messages";

  @override
  DatabaseType get databaseType => DatabaseType.chatMessages;

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE messages(
        id INTEGER PRIMARY KEY,
        local_account_uuid TEXT NOT NULL,
        remote_account_uuid TEXT NOT NULL,
        message_text TEXT NOT NULL,
        sent_message_state INTEGER,
        received_message_state INTEGER,

        -- Server sends valid values for the next two fields.
        message_number INTEGER,
        unix_time INTEGER
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
      return firstIntValue(await db.query(tableName, columns: ["COUNT(id)"]));
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
    final unixTime = DateTime.fromMillisecondsSinceEpoch(entry.unixTime * 1000);
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
        {"received_message_state": receivedMessageState.number},
        where: "local_account_uuid = ? AND remote_account_uuid = ? AND message_number = ?",
        whereArgs: [localAccountId.accountId, remoteAccountId.accountId, messageNumber.messageNumber],
      );
    });
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
    }
  );

  Map<String, Object?> toMap() {
    final unixTimeMilliseconds = unixTime?.millisecondsSinceEpoch;
    final unixTimeSeconds = unixTimeMilliseconds != null ? unixTimeMilliseconds ~/ 1000 : null;
    return {
      "local_account_uuid": localAccountId.accountId,
      "remote_account_uuid": remoteAccountId.accountId,
      "message_text": messageText,
      "sent_message_state": sentMessageState?.number,
      "received_message_state": receivedMessageState?.number,
      "message_number": messageNumber?.messageNumber,
      "unix_time": unixTimeSeconds,
    };
  }

  factory MessageEntry.fromMap(Map<String, Object?> map) {
    final localAccountId = AccountId(accountId: map["local_account_uuid"] as String);
    final remoteAccountId = AccountId(accountId: map["remote_account_uuid"] as String);
    final messageText = map["message_text"] as String;

    final sentMessageStateNumber = map["sent_message_state"] as int?;
    final SentMessageState? sentMessageState;
    if (sentMessageStateNumber != null) {
      sentMessageState = SentMessageState.values[sentMessageStateNumber];
    } else {
      sentMessageState = null;
    }

    final receivedMessageStateNumber = map["received_message_state"] as int?;
    final ReceivedMessageState? receivedMessageState;
    if (receivedMessageStateNumber != null) {
      receivedMessageState = ReceivedMessageState.values[receivedMessageStateNumber];
    } else {
      receivedMessageState = null;
    }

    final messageNumberInt = map["message_number"] as int?;
    final MessageNumber? messageNumber;
    if (messageNumberInt != null) {
      messageNumber = MessageNumber(messageNumber: messageNumberInt);
    } else {
      messageNumber = null;
    }

    final unixTimeSeconds = map["unix_time"] as int?;
    final DateTime? unixTime;
    if (unixTimeSeconds != null) {
      unixTime = DateTime.fromMillisecondsSinceEpoch(unixTimeSeconds * 1000);
    } else {
      unixTime = null;
    }

    return MessageEntry(
      localAccountId,
      remoteAccountId,
      messageText,
      sentMessageState: sentMessageState,
      receivedMessageState: receivedMessageState,
      messageNumber: messageNumber,
      unixTime: unixTime,
    );
  }


  @override
  String toString() {
    return "MessageEntry(localAccountId: $localAccountId, remoteAccountId: $remoteAccountId, messageText: $messageText, sentMessageState: $sentMessageState, receivedMessageState: $receivedMessageState, messageNumber: $messageNumber, unixTime: $unixTime)";
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
